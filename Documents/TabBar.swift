//
//  TabBar.swift
//  Documents
//
//  Created by Дмитрий Голубев on 07.05.2022.
//

import Foundation
import UIKit

final class MainTabBar: UITabBarController{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setUpTabBar()
    }
    
    private func setUpTabBar(){
        
        let gallaryNavVC = UINavigationController(rootViewController: GallaryViewController())
        gallaryNavVC.tabBarItem.title = "Галлерея"
        gallaryNavVC.tabBarItem.image = UIImage(systemName: "photo.on.rectangle.angled")
        updateNavBarAppearance(navController: gallaryNavVC)
        
        let settingNavVC = UINavigationController(rootViewController: SettingViewController())
        settingNavVC.tabBarItem.title = "Настройки"
        settingNavVC.tabBarItem.image = UIImage(systemName: "gearshape")
        settingNavVC.topViewController?.title = "Настройки"
        updateNavBarAppearance(navController: settingNavVC)
        
        self.viewControllers = [gallaryNavVC, settingNavVC]
        
    }
    
    @available(iOS 15.0, *)
    private func updateNavBarAppearance(navController: UINavigationController) {
        let navBarAppearance: UINavigationBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        
        let navTintColor: UIColor = .white
        navBarAppearance.backgroundColor = navTintColor
        
        navController.navigationBar.standardAppearance = navBarAppearance
        navController.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
}
