// QMAPIClient.swift
// quickmem
//
// Created by Nguyen Quang Minh on 4/14/25.
//

import Foundation

class QMAPIClient: QMAPIService {
    let baseURL: String
    let session: URLSession

    init(
        baseURL: String,
        session: URLSession = .shared
    ) {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.requestCachePolicy = .useProtocolCachePolicy
        configuration.urlCache = nil
        self.baseURL = baseURL
        self.session = URLSession(configuration: configuration)

        print("🚀 [API INIT] Base URL: \(baseURL)")
    }

    // MARK: - Auth API

    func loginWithEmail(loginRequest: LoginRequestDTO) async throws
        -> AuthResponseDTO
    {
        try await request(
            path: "auth/login",
            method: .post,
            body: loginRequest
        )
    }

    func refreshToken() async throws {
        guard let refreshToken = await TokenManager.shared.refreshToken else {
            throw APIError.unauthorized
        }

        let body = RefreshRequestDTO(refreshToken: refreshToken)

        do {
            let response: RefreshResponseDTO = try await authorizedRequest(
                path: "auth/refresh",
                method: .post,
                body: body
            )

            await TokenManager.shared.updateTokens(
                access: response.accessToken,
                refresh: response.refreshToken
            )
        } catch {
            throw APIError.unauthorized
        }
    }

    // MARK: - Private URLSession Request Handling

    private func request<T: Codable, U: Codable>(
        path: String,
        method: HTTPMethod = .get,
        body: T? = nil
    ) async throws -> U {
        let urlString = baseURL.hasSuffix("/") ? baseURL + path : baseURL + "/" + path
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if let body = body {
            request.httpBody = try JSONEncoder().encode(body)
        }

        print(
            """
            \n📤 ========== [REQUEST] ==========
            🌐 [URL] \(urlString)
            📬 [Method] \(method.rawValue)
            \(body != nil ? "📦 [Body] \(body!)" : "")
            """)

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        let jsonString = String(data: data, encoding: .utf8) ?? "No Data"
        switch httpResponse.statusCode {
        case 200..<300:
            do {
                print(
                    """
                    \n📥 ✅ ========== [RESPONSE] ==========
                    🔢 [Status Code] \(httpResponse.statusCode)
                    📄 [Data] \(jsonString)
                    """)

                let decodedData = try jsonDecoder.decode(U.self, from: data)
                return decodedData
            } catch {
                print(
                    """
                    \n❌ 🧨 ========== [DECODING ERROR] ==========
                    💥 [Error] \(error)
                    📄 [Data] \(jsonString)
                    """)
                throw error
            }
        case 400..<500:
            print(
                """
                \n❌ 🚫 ========== [CLIENT ERROR] ==========
                🔢 [Status Code] \(httpResponse.statusCode)
                📄 [Data] \(jsonString)
                """)
            throw APIError.clientError(statusCode: httpResponse.statusCode)
        case 500..<600:
            print(
                """
                \n❌ 🔥 ========== [SERVER ERROR] ==========
                🔢 [Status Code] \(httpResponse.statusCode)
                📄 [Data] \(jsonString)
                """)
            throw APIError.serverError(statusCode: httpResponse.statusCode)
        default:
            print(
                """
                \n❌ 🛑 ========== [UNKNOWN ERROR] ==========
                🔢 [Status Code] \(httpResponse.statusCode)
                📄 [Data] \(jsonString)
                """)
            throw APIError.unknown
        }
    }

    private func authorizedRequest<T: Codable, U: Codable>(
        path: String,
        method: HTTPMethod = .get,
        body: T? = nil,
        retryOnUnauthorized: Bool = true
    ) async throws -> U {
        guard let accessToken = await TokenManager.shared.accessToken else {
            throw APIError.unauthorized
        }

        let urlString = baseURL.hasSuffix("/") ? baseURL + path : baseURL + "/" + path
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(
            "Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        if let body = body {
            request.httpBody = try JSONEncoder().encode(body)
        }

        print(
            """
            \n🔐 📤 ========== [REQUEST - AUTH] ==========
            🌐 [URL] \(urlString)
            📬 [Method] \(method.rawValue)
            🧾 [Headers] Authorization: Bearer [REDACTED]
            \(body != nil ? "📦 [Body] \(body!)" : "")
            """)

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        let jsonString = String(data: data, encoding: .utf8) ?? "No Data"
        switch httpResponse.statusCode {
        case 200..<300:
            do {
                print(
                    """
                    \n🔐 📥 ✅ ========== [RESPONSE - AUTH] ==========
                    🔢 [Status Code] \(httpResponse.statusCode)
                    📄 [Data] \(jsonString)
                    """)

                let decodedData = try jsonDecoder.decode(U.self, from: data)
                return decodedData
            } catch {
                print(
                    """
                    \n🔐 ❌ 🧨 ========== [DECODING ERROR - AUTH] ==========
                    💥 [Error] \(error)
                    📄 [Data] \(jsonString)
                    """)
                throw error
            }
        case 401 where retryOnUnauthorized:
            print(
                """
                \n🔐 ❌ ========== [AUTH ERROR - 401] ==========
                🔁 [Retrying with Refresh Token]
                """)
            try await refreshToken()
            return try await authorizedRequest(
                path: path,
                method: method,
                body: body,
                retryOnUnauthorized: false
            )
        case 400..<500:

            print(
                """
                \n🔐 ❌ 🚫 ========== [CLIENT ERROR - AUTH] ==========
                🔢 [Status Code] \(httpResponse.statusCode)
                📄 [Data] \(jsonString)
                """)
            
            throw APIError.clientError(statusCode: httpResponse.statusCode)
        case 500..<600:
            print(
                """
                \n🔐 ❌ 🔥 ========== [SERVER ERROR - AUTH] ==========
                🔢 [Status Code] \(httpResponse.statusCode)
                📄 [Data] \(jsonString)
                """)
            throw APIError.serverError(statusCode: httpResponse.statusCode)
        default:
            print(
                """
                \n🔐 ❌ 🛑 ========== [UNKNOWN ERROR - AUTH] ==========
                🔢 [Status Code] \(httpResponse.statusCode)
                📄 [Data] \(jsonString)
                """)
            throw APIError.unknown
        }
    }

    private var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
}
