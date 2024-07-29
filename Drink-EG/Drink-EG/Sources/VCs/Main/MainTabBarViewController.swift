//
//  MainTabBarViewController.swift
//  Drink-EG
//
//  Created by 이현주 on 7/21/24.
//

import UIKit

class MainTabBarViewController : UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabs()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var tabFrame = tabBar.frame
        tabFrame.size.height = 93
        tabFrame.origin.y = view.frame.size.height - 93
        tabBar.frame = tabFrame
    }
    
    private func configureTabs() {
        
        let nav1 = UINavigationController(rootViewController: HomeViewController())
        let nav2 = UINavigationController(rootViewController: WineClassMainViewController())
        let nav3 = UINavigationController(rootViewController: NoteListViewController())
        let nav4 = UINavigationController(rootViewController: CommunityMainViewController())
        let nav5 = UINavigationController(rootViewController: SettingMainController())
        
        nav1.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "TabHome"), tag: 0)
        nav2.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "TabClass"), tag: 1)
        nav3.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "TabNote"), tag: 2)
        nav4.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "TabGroup"), tag: 3)
        nav5.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "TabSetting"), tag: 4)
        
        tabBar.tintColor = .label
        tabBar.backgroundColor = .black
        tabBar.alpha = 0.6
        tabBar.layer.cornerRadius = 20
        tabBar.layer.masksToBounds = true
        
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = UIColor(hue: 0, saturation: 0, brightness: 0.85, alpha: 1.0)
        
        setViewControllers([nav1, nav2, nav3, nav4, nav5], animated: true)
    }
}

