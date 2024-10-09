//
//  CustomTabBarView.swift
//  Drink-EG
//
//  Created by 김도연 on 10/7/24.
//
//
//import UIKit
//import SnapKit
//import Then
//
//class CustomTabBarView: UIView {
//
//    var buttons: [UIButton] = []
//    var buttonTapped: ((Int) -> Void)?
//
//    init(titles: [String]) {
//        super.init(frame: .zero)
//        setupTabs(with: titles)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func setupTabs(with titles: [String]) {
//        let stackView = UIStackView().then {
//            $0.axis = .horizontal
//            $0.distribution = .fillEqually
//            $0.alignment = .center
//        }
//
//        titles.enumerated().forEach { index, title in
//            let button = UIButton().then {
//                $0.setTitle(title, for: .normal)
//                $0.setTitleColor(.gray, for: .normal)
//                $0.setTitleColor(.blue, for: .selected)
//                $0.tag = index
//                $0.addTarget(self, action: #selector(tabButtonTapped(_:)), for: .touchUpInside)
//            }
//            buttons.append(button)
//            stackView.addArrangedSubview(button)
//        }
//
//        addSubview(stackView)
//        stackView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//    }
//
//    @objc private func tabButtonTapped(_ sender: UIButton) {
//        buttons.forEach { $0.isSelected = false }
//        sender.isSelected = true
//        buttonTapped?(sender.tag)
//    }
//
//    func selectTab(at index: Int) {
//        buttons.enumerated().forEach { idx, button in
//            button.isSelected = (idx == index)
//        }
//    }
//}
