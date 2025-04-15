//
//  RefreshRequestDTO.swift
//  quickmem
//
//  Created by Nguyen Quang Minh on 4/15/25.
//

import Foundation

struct RefreshRequestDTO: Codable {
    let refreshToken: String
    
    func toDomainModel() -> RefreshRequestEntity {
        return RefreshRequestEntity(refreshToken: refreshToken)
    }
    
    static func fromDomainModel(_ model: RefreshRequestEntity) -> RefreshRequestDTO {
        return RefreshRequestDTO(refreshToken: model.refreshToken)
    }
}
