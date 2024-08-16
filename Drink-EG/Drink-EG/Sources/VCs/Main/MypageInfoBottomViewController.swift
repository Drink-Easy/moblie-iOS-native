//
//  MypageInfoBottomViewController.swift
//  Drink-EG
//
//  Created by 이호연 on 8/16/24.
//

import Foundation
import UIKit
import SnapKit




class MypageInfoBottomViewController: UIViewController {
    
    let imageView = UIImageView()

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        setupVideo()
        configureSheet()
        setupVideoViewConstraints()
        
    }
    
        
        private func setupVideo() {
            view.addSubview(imageView)
            
            imageView.overrideUserInterfaceStyle = .dark
            imageView.frame = view.bounds
            imageView.contentMode = .scaleAspectFill
            //imageView.clipsToBounds = true
            //imageView.layer.cornerRadius = 40
            imageView.image = UIImage(named: "SampleImage")
        }
    
    func setupVideoViewConstraints() {
        imageView.snp.makeConstraints { make in
            //make.top.equalTo(myinfoLabel.snp.bottom).offset(80) // noteListLabel의 아래에 20포인트 여백
            make.centerX.equalToSuperview() // 가로축 중앙에 배치
            make.height.equalTo(568)
            make.width.equalTo(405)

        }
    }
        
        
        private func configureSheet() {
            
            
            let vc = MypageInfoViewController()
            
            let navVC = UINavigationController(rootViewController: vc)
            
            navVC.isModalInPresentation = true
            
            if let sheet = navVC.sheetPresentationController {
                
                sheet.preferredCornerRadius = 40
                
                
                sheet.detents = [.custom(resolver: {context in
                    0.4 * context.maximumDetentValue
                }), .large()]

                
                sheet.largestUndimmedDetentIdentifier = .large
            }
            navigationController?.present(navVC, animated: true)
        }
    }


class MypageInfoViewController: UIViewController {

    let mypageLabel = UILabel()
    let myinfoLabel = UILabel()
    let mynameLabel = UILabel()
    let myinfobutton = UIButton(type: .system)

    
    let imageView = UIImageView()
    
    //let nameLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //setupCollectionView()
        setupView()
        setupNavigationBarButton()
        setupLabel()
        setupMypageLabelConstraints()
        setupMyImageView()
        setupMyImageViewConstraints()
        setupMyinfoLabel()
        setupMyinfoLabelConstraints()
        setupMynameLabel()
        setupMynameLabelConstraints()
        setupMyinfoButton()
        
        //setupNoteCollectionViewConstraints()
    }
    
    func setupView() { // 뷰 설정 함수
        view.addSubview(mypageLabel)
        view.addSubview(myinfoLabel)
        view.addSubview(imageView)
        view.addSubview(mynameLabel)
        view.addSubview(myinfobutton)

    }
    
    func setupNavigationBarButton() {
        navigationItem.hidesBackButton = true
        let backArrow = UIImage(systemName: "chevron.backward")
        let leftButton = UIBarButtonItem(image: backArrow, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = leftButton
        leftButton.tintColor = .black
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: 노트 보관함에 관한 UI
    func setupLabel() {
        mypageLabel.text = "마이페이지"
        mypageLabel.font = .boldSystemFont(ofSize: 30)
        mypageLabel.textAlignment = .center
        mypageLabel.textColor = .black
    }
    
    func setupMypageLabelConstraints() {
        mypageLabel.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(46)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
        }
    }
    
    //내 정보
    func setupMyinfoLabel() {
        myinfoLabel.text = "내 정보"
        myinfoLabel.font = .boldSystemFont(ofSize: 24)
        myinfoLabel.textAlignment = .center
        myinfoLabel.textColor = .black
    }
    
    func setupMyinfoLabelConstraints() {
        myinfoLabel.snp.makeConstraints{ make in
            make.top.equalTo(mypageLabel.snp.top).offset(100)
            make.leading.equalTo(mypageLabel.snp.leading)
        }
    }
    
    
    
    
    func setupMyImageView() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 40
        imageView.image = UIImage(named: "SampleImage") // Asset에 있는 이미지 설정
    }

    func setupMyImageViewConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(myinfoLabel.snp.bottom).offset(80)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(134)
        }
    }

    
    //김이지님
    func setupMynameLabel() {
        mynameLabel.text = "안녕하세요, 김이지님!"
        mynameLabel.font = .boldSystemFont(ofSize: 24)
        mynameLabel.textAlignment = .center
        mynameLabel.textColor = .black
    }
    
    func setupMynameLabelConstraints() {
        mynameLabel.snp.makeConstraints{ make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            
        }
    }
    
    
    func setupMyinfoButton() {
        myinfobutton.setTitle("+ 내 정보 수정", for: .normal)
        myinfobutton.setTitleColor(.black, for: .normal)
        myinfobutton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        myinfobutton.backgroundColor = UIColor(hex: "FA735B")
        myinfobutton.layer.cornerRadius = 20
        myinfobutton.addTarget(self, action: #selector(myinfoButtonTapped), for: .touchUpInside)
        myinfobutton.snp.makeConstraints { make in
            //make.edges.equalToSuperview().inset(16)
            make.top.equalTo(mynameLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview() // 가로축 중앙에 배치
            make.height.equalTo(40)
            make.width.equalTo(101)

        }
    }
        
        @objc func myinfoButtonTapped() {
            navigationController?.popViewController(animated: true)
        }
        
    }
    

    
     
    
    
    
    
    
    
    
