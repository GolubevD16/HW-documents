//
//  File.swift
//  Documents
//
//  Created by Дмитрий Голубев on 05.05.2022.
//

import Foundation
import UIKit

final class LoginViewController: UIViewController{
    private let viewModel: LoginViewModel
    private let update: Bool
    
    init(forUpdatePassword: Bool = false){
        self.viewModel = LoginViewModel()
        self.update = forUpdatePassword
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var loginView: LoginView = {
        loginView = LoginView()
        view.addSubview(loginView)
        
        return loginView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.frame = view.frame
        setUpViewModel()
        if update {viewModel.send(.viewIsReadyToUpdate)} else {viewModel.send(.viewIsReady)}
    }
    
    private func setUpViewModel(){
        viewModel.onStateChanged = {[weak self] state in
            guard let self = self else { return }
            switch state{
            case .initial:
                ()
            case .login:
                self.showLogin()
                self.loginView.logButton.setTitle("Введите пароль", for: .normal)
            case .registration:
                self.showRegistr()
            case .passAdded:
                self.showAlert(mes: "Пароль успешно установлен, введите его для входа.")
                self.viewModel.send(.passwordCreated)
            case .passUpdated:
                self.showAlert(mes: "Пароль успешно обновлен.", exit: true)
                //self.dismiss(animated: true, completion: nil)
            case let .errorWithCreatePassword(mes):
                self.loginView.logButton.setTitle("Создайте пароль", for: .normal)
                self.loginView.textField.text = ""
                self.showAlert(mes: mes)
            case .failLogin:
                self.showAlert(mes: "Введён неверный пароль.")
            case .succsesLogin:
                let vc = MainTabBar()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            case let .error(error):
                print(error)
            }
        }
    }
    
    func showRegistr(){
        loginView.logButton.setTitle("Создайте пароль", for: .normal)
        loginView.logButton.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
    }
    
    func showLogin(){
        loginView.textField.text = ""
        loginView.logButton.removeTarget(self, action: #selector(self.tappedButton), for: .touchUpInside)
        loginView.logButton.addTarget(self, action: #selector(tappedButtonForLogin), for: .touchUpInside)
    }
    
    func showAlert(mes: String, exit: Bool = false){
        let alert = UIAlertController(title: "Внимание", message: mes, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: { _ in
            if exit{
                self.dismiss(animated: true, completion: nil)
            }
        }))
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func tappedButtonForLogin(){
        if loginView.textField.text?.count == 0 { return }
        viewModel.pasForLogin = loginView.textField.text
        viewModel.send(.login)
    }
    
    @objc private func tappedButton(){
        if let _ = viewModel.pas1 {
            viewModel.pas2 = loginView.textField.text
            viewModel.isUpdate = update
            viewModel.send(.createPassword)
        } else {
            if loginView.textField.text?.count == 0 {return}
            viewModel.pas1 = loginView.textField.text
            loginView.textField.text = ""
            loginView.logButton.setTitle("Повторите пароль", for: .normal)
        }
    }
    
    private func passwordFail(){
        viewModel.pas1 = nil
        viewModel.pas2 = nil
        loginView.textField.text = ""
    }
}
