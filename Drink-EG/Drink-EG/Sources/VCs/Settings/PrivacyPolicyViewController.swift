//
//  PrivacyPolicyViewController.swift
//  Drink-EG
//
//  Created by 이수현 on 8/20/24.
//

import Foundation
import UIKit
import SnapKit

class PrivacyPolicyViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let contentsLabel = UILabel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBarButton()
        setupScrollView()
        setupContentsText()
    }
    
    func setupNavigationBarButton() {
        navigationItem.hidesBackButton = false
        let backArrow = UIImage(systemName: "chevron.backward")
        let leftButton = UIBarButtonItem(image: backArrow, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = leftButton
        leftButton.tintColor = .black
        navigationItem.title = "개인정보 처리방침"
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.height.equalTo(UIScreen.main.bounds.height).multipliedBy(1) // 수정 필요
        }
    }
    
    func setupContentsText() {
        contentView.addSubview(contentsLabel)
        contentsLabel.text = "드링키지(이하 ‘회사'라고 함)는 회사가 제공하고자 하는 서비스(이하 ‘회사 서비스’)를 이용하는 개인(이하 ‘이용자’ 또는 ‘개인’)의 정보(이하 ‘개인정보’)를 보호하기 위해, 개인정보보호법, 정보통신망 이용촉진 및 정보보호 등에 관한 법률(이하 '정보통신망법') 등 관련 법령을 준수하고, 서비스 이용자의 개인정보 보호 관련한 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 다음과 같이 개인정보처리방침(이하 ‘본 방침’)을 수립합니다."
        contentsLabel.numberOfLines = 0
        contentsLabel.lineBreakMode = .byTruncatingTail
        // contentsLabel.textAlignment = .center
        contentsLabel.textColor = .black
        contentsLabel.font = .systemFont(ofSize: UIConstants.labelFontSize, weight: UIFont.Weight(rawValue: 700))
        
        contentsLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView.safeAreaLayoutGuide.snp.leading).offset(27)
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(30)
            make.height.equalTo(contentView.snp.height)
        }
    }

}
