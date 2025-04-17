//
//  StringExtenstion.swift
//  quickmem
//
//  Created by Nguyen Quang Minh on 4/17/25.
//
import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }

    func localized(with arguments: CVarArg...) -> String {
        return String(format: self.localized, arguments: arguments)
    }

    var toLocalizationKey: String {
        var key = self.lowercased()
        key = key.components(separatedBy: CharacterSet.alphanumerics.inverted)
            .joined(separator: " ")
        key = key.trimmingCharacters(in: .whitespacesAndNewlines)
        key = key.replacingOccurrences(of: " ", with: "_")
        return "error_\(key)"
    }

    func isValidEmail() -> Bool {
        let emailRegex = "^[A-Za-z0-9+_.-]+@([A-Za-z0-9.-]+)\\.([A-Za-z]{2,})$"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }

    func isValidPassword() -> Bool {
        let passwordRegex = "^.{6,}$"  
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: self)
    }

}
