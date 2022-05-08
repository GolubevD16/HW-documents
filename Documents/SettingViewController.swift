//
//  SettingViewController.swift
//  Documents
//
//  Created by Дмитрий Голубев on 07.05.2022.
//

import Foundation
import UIKit

final class SettingViewController: UIViewController{
    
    lazy var tableView: UITableView = {
        tableView = UITableView(frame: view.frame, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
        //tableView.allowsSelection = false
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    override func viewDidLoad() {
        view.addSubview(tableView)
        super.viewDidLoad()
    }
}

extension SettingViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0:
            let cell = UITableViewCell()
            let tumbler = UISwitch()
            tumbler.isOn = UserDefaults.standard.bool(forKey: "sort")
            tumbler.addTarget(self, action: #selector(changeSettings(paramTarget:)), for: .valueChanged)
            cell.textLabel?.text = "Сортировка по имени"
            cell.accessoryView = tumbler
            cell.selectionStyle = .none
            
            return cell
        case 1:
            let cell = UITableViewCell()
            cell.textLabel?.text = "Изменить пароль"
            cell.selectionStyle = .none
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    @objc private func changeSettings(paramTarget: UISwitch){
        let defaults = UserDefaults.standard
        defaults.setValue(paramTarget.isOn, forKey: "sort")
    }
}

extension SettingViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1{
            present(LoginViewController(forUpdatePassword: true), animated: true, completion: nil)
        }
    }
}
