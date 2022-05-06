//
//  LoginModel.swift
//  Documents
//
//  Created by Дмитрий Голубев on 05.05.2022.
//

import Foundation

final class LoginModel{
    private static let uid = "B29CA25E-219C-4637-873D-08D8477DE20A"
    private static let serviceName = "Documents"
    private static var password: String?
    
    static func isExist() -> Bool{
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: serviceName,
            kSecAttrAccount: uid,
            kSecReturnData: true
        ] as CFDictionary
        var exectedData: AnyObject?
        let status = SecItemCopyMatching(query, &exectedData)
        guard status == errSecSuccess,
              let passData = exectedData as? Data,
              let pass = String(data: passData, encoding: .utf8)
        else { return false}
        password = pass
        return true
    }
    
    private static func createPassword(_ pswd: String) -> LoginStatus{
//        guard let passData = pswd.data(using: .utf8) else { return .cantSetPassword}
//        let attributes = [
//            kSecClass: kSecClassGenericPassword,
//            kSecValueData: passData,
//            kSecAttrAccount: uid,
//            kSecAttrService: serviceName,
//        ] as CFDictionary
//
//        let status = SecItemAdd(attributes, nil)
//
//        guard status == errSecSuccess else {print("не удалось добавить пароль"); return .cantSetPassword}
        return .sucsess
    }
    
    static func setPassword(pas1: String, pas2: String) -> LoginStatus {
        if pas1 != pas2 { return .notEqualPassword}
        if pas1.count < 4 { return .eazyPassword}
        if createPassword(pas1) == .sucsess{
            return .sucsess
        } else {
            return .cantSetPassword
        }
    }
}

extension LoginModel{
    enum LoginStatus{
        case sucsess
        case eazyPassword
        case notEqualPassword
        case cantSetPassword
    }
}
