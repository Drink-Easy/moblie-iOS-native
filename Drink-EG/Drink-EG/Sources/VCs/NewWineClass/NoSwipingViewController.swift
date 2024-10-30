//
//  SwipingViewController.swift
//  Drink-EG
//
//  Created by 김도연 on 10/7/24.
//
//
//import UIKit
//import SnapKit
//import Then
//
//class SwipingViewController: UIViewController, UIScrollViewDelegate {
//
//    var viewControllers: [UIViewController] = []
//    var scrollView: UIScrollView!
//    var customTabBar: CustomTabBarView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        
//        setupTabBar()
//        setupScrollView()
//        addViewControllers()
//    }
//
//    private func setupTabBar() {
//        customTabBar = CustomTabBarView(titles: ["Home", "Search", "Profile", "Red", "White"]).then {
//            $0.buttonTapped = { [weak self] index in
//                self?.scrollToPage(index)
//            }
//        }
//
//        view.addSubview(customTabBar)
//        customTabBar.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide)
//            make.leading.trailing.equalToSuperview()
//            make.height.equalTo(50)
//        }
//    }
//
//    private func setupScrollView() {
//        scrollView = UIScrollView().then {
//            $0.isPagingEnabled = true
//            $0.showsHorizontalScrollIndicator = false
//            $0.delegate = self
//        }
//
//        view.addSubview(scrollView)
//        scrollView.snp.makeConstraints { make in
//            make.top.equalTo(customTabBar.snp.bottom)
//            make.leading.trailing.bottom.equalToSuperview()
//        }
//    }
//
//    private func addViewControllers() {
//        let homeVC = UIViewController().then { $0.view.backgroundColor = .red }
//        let searchVC = UIViewController().then { $0.view.backgroundColor = .green }
//        let profileVC = UIViewController().then { $0.view.backgroundColor = .blue }
//
//        viewControllers = [homeVC, searchVC, profileVC]
//
//        for (index, vc) in viewControllers.enumerated() {
//            addChild(vc)
//            scrollView.addSubview(vc.view)
//            vc.view.snp.makeConstraints { make in
//                make.top.bottom.equalToSuperview()
//                make.width.equalTo(view)
//                make.height.equalTo(scrollView)
//                if index == 0 {
//                    make.leading.equalTo(scrollView)
//                } else {
//                    make.leading.equalTo(viewControllers[index - 1].view.snp.trailing)
//                }
//                if index == viewControllers.count - 1 {
//                    make.trailing.equalTo(scrollView)
//                }
//            }
//            vc.didMove(toParent: self)
//        }
//    }
//
//    func scrollToPage(_ index: Int) {
//        let offsetX = CGFloat(index) * view.frame.width
//        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
//    }
//
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let pageIndex = Int(scrollView.contentOffset.x / view.frame.width)
//        customTabBar.selectTab(at: pageIndex)
//    }
//}
