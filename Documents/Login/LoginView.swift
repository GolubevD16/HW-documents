//
//  LoginView.swift
//  Documents
//
//  Created by Дмитрий Голубев on 05.05.2022.
//

import Foundation
import UIKit

final class LoginView: UIView{
    lazy var logButton: UIButton = {
        logButton = UIButton()
        logButton.translatesAutoresizingMaskIntoConstraints = false
        logButton.backgroundColor = .systemBlue
        addSubview(logButton)
        
        return logButton
    }()
    
    lazy var textField: UITextField = {
        textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .systemGray5
        textField.font = UIFont.systemFont(ofSize: 20)
        addSubview(textField)
        
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpLayout(){
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: centerYAnchor),
            textField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/3),
            
            logButton.centerXAnchor.constraint(equalTo: textField.centerXAnchor),
            logButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16),
            logButton.heightAnchor.constraint(equalToConstant: 32),
            logButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/2),
        ])
    }
}
