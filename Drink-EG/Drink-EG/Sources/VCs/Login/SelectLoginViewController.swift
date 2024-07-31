//
//  SelectLoginViewController.swift
//  Drink-EG
//
//  Created by 이현주 on 7/30/24.
//

import UIKit

class SelectLoginViewController: UIViewController {

    let loginButton = UIButton(type: .system)
    
    let kakaoButton = UIButton(type: .system)
    let appleButton = UIButton(type: .system)
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "select1")
        return iv
    }()
    
    private let label: UILabel = {
        let l = UILabel()
        l.text = "아직 회원이 아니신가요?"
        l.textColor = UIColor(hue: 0, saturation: 0, brightness: 0.71, alpha: 1.0)
        //l.font = UIFont(name: system, size: 14)
        
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.tintColor = .white
        
        view.backgroundColor = .black
        setupUI()
    }
    
    private func setupUI() {
        configureLoginButton()
        configureKakaoButton()
        configureAppleButton()
        
        let stackView = UIStackView(arrangedSubviews: [kakaoButton, appleButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 12
                
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(449)
            make.leading.trailing.equalToSuperview().inset(33)
            make.width.equalTo(327)
            make.height.equalTo(132)
        }
        
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(view).offset(651)
            make.centerX.equalToSuperview()
            make.leading.equalTo(view).offset(33)
            make.height.equalTo(60)
            make.width.equalTo(327)
        }
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.bottom.equalTo(stackView.snp.top).offset(-100)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(165)
        }
    }
    
    private func configureLoginButton() {
        loginButton.setTitle("로그인", for: .normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.contentHorizontalAlignment = .center
        
        loginButton.backgroundColor = UIColor(hue: 0.1389, saturation: 0.54, brightness: 1, alpha: 1.0)
        loginButton.layer.cornerRadius = 16
        loginButton.layer.borderWidth = 0
        
        loginButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    @objc private func startButtonTapped() {
        let loginViewController = LoginViewController()
        navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    private func configureKakaoButton() {
        kakaoButton.setTitle("카카오 로그인", for: .normal)
        kakaoButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        kakaoButton.setTitleColor(.white, for: .normal)
        kakaoButton.contentHorizontalAlignment = .center
        
        //카카오 이미지를 아이콘 포멧 이미지에 맞게 바꿈
        kakaoButton.setImage(UIImage(named: "kakao")?.withRenderingMode(.alwaysOriginal), for: .normal)
        kakaoButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -18, bottom: 0, right: 0)

        kakaoButton.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0.26, alpha: 0.5)
        //kakaoButton.alpha = 0.5
        kakaoButton.layer.cornerRadius = 16
        kakaoButton.layer.borderWidth = 2
        kakaoButton.layer.borderColor = UIColor.white.cgColor.copy(alpha: 0.1)
        
    }
    
    private func configureAppleButton() {
        appleButton.setTitle("애플 로그인", for: .normal)
        appleButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        appleButton.setTitleColor(.white, for: .normal)
        appleButton.contentHorizontalAlignment = .center
        
        appleButton.setImage(UIImage(named: "apple")?.withRenderingMode(.alwaysOriginal), for: .normal)
        appleButton.tintColor = .white
        appleButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -30, bottom: 0, right: 0)
        
        appleButton.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0.26, alpha: 0.5)
        appleButton.layer.cornerRadius = 16
        appleButton.layer.borderWidth = 2
        appleButton.layer.borderColor = UIColor.white.cgColor.copy(alpha: 0.1)
    }

}
