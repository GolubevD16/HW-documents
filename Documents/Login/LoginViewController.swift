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
    
    var model: LoginModel?
    
    init(){
        self.viewModel = LoginViewModel()
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
        viewModel.send(.viewIsReady)
    }
    
    private func setUpViewModel(){
        viewModel.onStateChanged = {[weak self] state in
            guard let self = self else { return }
            switch state{
            case .initial:
                ()
            case .login:
                self.showLogin()
                
            case .registration:
                self.showRegistr()
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
        loginView.logButton.setTitle("Введите пароль", for: .normal)
    }
    
    @objc private func tappedButton(){
        if let _ = viewModel.pas1 {
            viewModel.pas2 = loginView.textField.text!
            viewModel.send(.createPassword)
        }
        viewModel.pas1 = loginView.textField.text!
        loginView.textField.text = ""
        loginView.logButton.setTitle("Повторите пароль", for: .normal)
    }
    
    private func passwordFail(){
        viewModel.pas1 = nil
        viewModel.pas2 = nil
        loginView.textField.text = ""
    }
}
