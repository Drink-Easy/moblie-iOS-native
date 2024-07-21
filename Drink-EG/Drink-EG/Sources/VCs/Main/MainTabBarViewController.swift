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
    
    private func configureTabs() {
        
        let nav1 = UINavigationController(rootViewController: HomeViewController())
        let nav2 = UINavigationController(rootViewController: WineClassMainViewController())
        let nav3 = UINavigationController(rootViewController: NoteListViewController())
        let nav4 = UINavigationController(rootViewController: CommunityMainViewController())
        let nav5 = UINavigationController(rootViewController: SettingMainController())
        
        nav1.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house"), tag: 0)
        nav2.tabBarItem = UITabBarItem(title: "클래스", image: UIImage(systemName: "video"), tag: 1)
        nav3.tabBarItem = UITabBarItem(title: "테이스팅 노트", image: UIImage(systemName: "pencil.and.list.clipboard"), tag: 2)
        nav4.tabBarItem = UITabBarItem(title: "와인 모임", image: UIImage(systemName: "wineglass"), tag: 3)
        nav5.tabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "gearshape"), tag: 4)
        
        tabBar.tintColor = .label
        tabBar.backgroundColor = .systemGray6
        
        setViewControllers([nav1, nav2, nav3, nav4, nav5], animated: true)
    }
}
