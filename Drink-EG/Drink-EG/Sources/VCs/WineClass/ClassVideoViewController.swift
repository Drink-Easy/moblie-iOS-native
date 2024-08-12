//
//  ClassVideoViewController.swift
//  Drink-EG
//
//  Created by 김도연 on 7/21/24.
//

import Foundation


import UIKit

class SecondViewController: UIViewController {
    
    let titleclassLabel = UILabel()
    let subTitleclassLabel = UILabel()
    
    let savebutton = UIButton()
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupView()
        setupTitleClassLabel()
        setupTitleClassLabelConstraints()
        setupSaveButton()
        setupSubtitleClassLabel()
        setupSubtitlesLabelConstraints()
        view.backgroundColor = .systemGray6
        
        
    }
    
    func setupView() { // 뷰 설정 함수
        //view.addSubview(noteListLabel)
        view.addSubview(titleclassLabel)
        view.addSubview(subTitleclassLabel)
        view.addSubview(savebutton)

    }
    
    func setupTitleClassLabel() { // Label의 기본 속성을 설정하는 함수
        titleclassLabel.text = "기초 와인 용어! 와인 표현 배우기"
        titleclassLabel.font = .boldSystemFont(ofSize: 24)
        titleclassLabel.textAlignment = .center
        titleclassLabel.textColor = .black
    }
    
    func setupTitleClassLabelConstraints() { // Label의 제약 조건을 설정하는 함수
        titleclassLabel.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
        }
    }
    
    func setupSubtitleClassLabel() { // Label의 기본 속성을 설정하는 함수
        subTitleclassLabel.text = "와인의 기본용어를 전문가 수준으로 배워낼 수 있는 영상을 만들었습니다. 한국어 자막을 최대한 쉽게 만들어 내느라 너무 고민해서 제 머리털이 다 뽑힐 지경이네요! 이번 영상을 오래 기다리셨던만큼, 와인 용어가 어려워 마음고생하는 많은 분들에게 큰 도움이 되었으면 하는 바램입니다!"
        subTitleclassLabel.font = .boldSystemFont(ofSize: 14)
        subTitleclassLabel.textAlignment = .left
        
        subTitleclassLabel.textColor = .black
        subTitleclassLabel.numberOfLines = 0
        subTitleclassLabel.lineBreakMode = .byWordWrapping
        
    }
    
    func setupSubtitlesLabelConstraints() { // Label의 제약 조건을 설정하는 함수
        subTitleclassLabel.snp.makeConstraints{ make in
            make.top.equalTo(titleclassLabel.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-16)

            
        }
    }
    
    func setupSaveButton() {
        // UIButton의 기본 설정
        savebutton.setTitle("저장하기", for: .normal)
        savebutton.setTitleColor(.white, for: .normal)
        savebutton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        savebutton.backgroundColor = UIColor(hex: "FA735B")
        savebutton.layer.cornerRadius = 20
        savebutton.addTarget(self, action: #selector(myinfoButtonTapped), for: .touchUpInside)
        
        // 아이콘 이미지 추가
        let icon = UIImage(systemName: "square.badge.plus")
        savebutton.setImage(icon, for: .normal)
        savebutton.imageView?.tintColor = .white // 아이콘의 색상을 설정할 수 있음
        
        // 아이콘과 텍스트의 위치를 조정
        savebutton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 35)
        savebutton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 65, bottom: 0, right: 15)
        
        // 제약 조건 설정
        savebutton.snp.makeConstraints { make in
            make.top.equalTo(subTitleclassLabel.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(-16) // 화면의 오른쪽에 배치
            make.height.equalTo(40)
            make.width.equalTo(101)
        }
    }

    @objc func myinfoButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    
}
    


