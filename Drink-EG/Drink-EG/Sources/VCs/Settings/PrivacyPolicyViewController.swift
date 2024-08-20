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
    
    public static var isService : Bool = false
    
    let mainTitles : [String] = ["서비스 이용약관", "개인정보 처리방침"]
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    let textView = UITextView()
    
    let contentsLabel = UILabel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBarButton()
        setupTextView()
//        setupScrollView()
//        setupContentsText()
    }
    
    func setupNavigationBarButton() {
        navigationItem.hidesBackButton = false
        let backArrow = UIImage(systemName: "chevron.backward")
        let leftButton = UIBarButtonItem(image: backArrow, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = leftButton
        leftButton.tintColor = .black
        if PrivacyPolicyViewController.isService {
            navigationItem.title = mainTitles[0]
        } else {
            navigationItem.title = mainTitles[1]
        }
        
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupTextView() {
        view.addSubview(textView)
        
        // 텍스트뷰에 표시할 텍스트
        if PrivacyPolicyViewController.isService {
            textView.text = Constants.Policy.service
        } else {
            textView.text = Constants.Policy.privacy
        }
        
        
        // UITextView 속성 설정
        textView.isEditable = false
        textView.font = .systemFont(ofSize: 16)
        textView.textColor = .black
        
        // SnapKit을 사용한 제약 조건 설정
        textView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).offset(5)
        }
    }

}
