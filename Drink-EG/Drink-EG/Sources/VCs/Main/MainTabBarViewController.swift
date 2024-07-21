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
        let vc1 = HomeViewController()
        let vc2 = WineClassMainViewController()
        let vc3 = NoteListViewController()
        let vc4 = CommunityMainViewController()
        let vc5 = SettingMainController()
        
        vc1.title = "홈"
        vc2.title = "클래스"
        vc3.title = "테이스팅 노트"
        vc4.title = "와인 모임"
        vc5.title = "설정"
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "video")
        vc3.tabBarItem.image = UIImage(systemName: "pencil.and.list.clipboard")
        vc4.tabBarItem.image = UIImage(systemName: "wineglass")
        vc5.tabBarItem.image = UIImage(systemName: "gearshape")
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        let nav4 = UINavigationController(rootViewController: vc4)
        let nav5 = UINavigationController(rootViewController: vc5)
        
        tabBar.tintColor = .label
        tabBar.backgroundColor = .systemGray6
        
        setViewControllers([nav1, nav2, nav3, nav4, nav5], animated: true)
    }
}
#Preview {
    MainTabBarViewController()
}
