//
//  LoginViewModel.swift
//  Documents
//
//  Created by Дмитрий Голубев on 05.05.2022.
//

import Foundation

final class LoginViewModel{
    
    var onStateChanged: ((State) -> Void)?
    
    var pas1: String?
    var pas2: String?
    var pasForLogin: String?
    var isUpdate = false
    
    private(set) var state: State =  .initial {
        didSet{
            onStateChanged?(state)
        }
    }
    
    func send(_ action: Action){
        switch action {
        case .viewIsReady:
            if LoginModel.isExist() {state = .login} else {state = .registration}
        case .createPassword:
            guard let p1 = pas1, let p2 = pas2 else { return }
            if !isUpdate{
                switch LoginModel.setPassword(pas1: p1, pas2: p2, update: false){
                case .sucsess:
                    state = .passAdded
                case .eazyPassword:
                    clearPas()
                    state = .errorWithCreatePassword("Пароль должен содержать не менее 4х символов.")
                case .notEqualPassword:
                    clearPas()
                    state = .errorWithCreatePassword("Пароли не совпадают.")
                case .cantSetPassword:
                    clearPas()
                    state = .errorWithCreatePassword("Невозможно установить заданныый пароль")
                }
            } else {
                switch LoginModel.setPassword(pas1: p1, pas2: p2, update: true){
                case .sucsess:
                    state = .passUpdated
                case .eazyPassword:
                    clearPas()
                    state = .errorWithCreatePassword("Пароль должен содержать не менее 4х символов.")
                case .notEqualPassword:
                    clearPas()
                    state = .errorWithCreatePassword("Пароли не совпадают.")
                case .cantSetPassword:
                    clearPas()
                    state = .errorWithCreatePassword("Невозможно установить заданныый пароль")
                }
            }
        case .passwordCreated:
            state = .login
        case .login:
            guard let pswd = pasForLogin else {return}
            if LoginModel.checkPass(pas: pswd) {state = .succsesLogin}
            else { state = .failLogin }
        case .viewIsReadyToUpdate:
            state = .registration
        }
    }
    
    private func clearPas(){
        pas1 = nil
        pas2 = nil
    }
}

extension LoginViewModel{
    
    enum State{
        case initial
        case login
        case registration
        case passAdded
        case passUpdated
        case succsesLogin
        case failLogin
        case errorWithCreatePassword(String)
        case error(String)
    }
    
    enum Action{
        case viewIsReady
        case viewIsReadyToUpdate
        case createPassword
        case passwordCreated
        case login
    }
}

