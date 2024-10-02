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
        tabFrame.size.height = 96
        tabFrame.origin.y = view.frame.size.height - 90
        tabBar.frame = tabFrame
    }
    
    private func configureTabs() {
        
        let nav1 = UINavigationController(rootViewController: HomeViewController())
        let nav2 = UINavigationController(rootViewController: WineClassMainViewController())
        let nav3 = UINavigationController(rootViewController: NoteListViewController())
        let nav4 = UINavigationController(rootViewController: CommunityMainViewController())
        let nav5 = UINavigationController(rootViewController: MypageViewController())
        
        nav1.tabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "TabHome"), tag: 0)
        nav2.tabBarItem = UITabBarItem(title: "클래스", image: UIImage(named: "TabClass"), tag: 1)
        nav3.tabBarItem = UITabBarItem(title: "테이스팅 노트", image: UIImage(named: "TabNote"), tag: 2)
        nav4.tabBarItem = UITabBarItem(title: "모임", image: UIImage(named: "TabGroup"), tag: 3)
        nav5.tabBarItem = UITabBarItem(title: "설정", image: UIImage(named: "TabSetting"), tag: 4)
        
        UITabBar.clearShadow()
        tabBar.layer.applyShadow(color: .gray, alpha: 0.3, x: 0, y: 0, blur: 15)
        
        tabBar.tintColor = .label
        tabBar.backgroundColor = .white
        
        tabBar.tintColor = UIColor(hex: "5813B1")
        tabBar.unselectedItemTintColor = UIColor(hue: 0, saturation: 0, brightness: 0, alpha: 0.5)
        
        setViewControllers([nav1, nav2, nav3, nav4, nav5], animated: true)
    }
}

