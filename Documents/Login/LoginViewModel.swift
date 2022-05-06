//
//  LoginViewModel.swift
//  Documents
//
//  Created by Дмитрий Голубев on 05.05.2022.
//

import Foundation

final class LoginViewModel{
    
    var onStateChanged: ((State) -> Void)?
    var password: String?
    
    var pas1: String?
    var pas2: String?
    
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
            switch LoginModel.setPassword(pas1: p1, pas2: p2){
            case .sucsess:
                sucsessLogin()
            case .eazyPassword:
                print("Пароль должен содержать не менее 4х символов.")
            case .notEqualPassword:
                print("Пароли не совпадают.")
            case .cantSetPassword:
                print("Невозможно установить заданныый пароль")
            }
        case .login:
            ()
        }
    }
    
    private func sucsessLogin(){
        print("пароль установлен!")
    }
}

extension LoginViewModel{
    
    enum State{
        case initial
        case login
        case registration
        case error(String)
    }
    
    enum Action{
        case viewIsReady
        case createPassword
        case login
    }
}

