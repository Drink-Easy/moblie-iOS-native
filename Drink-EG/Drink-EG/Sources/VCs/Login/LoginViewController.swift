//
//  LoginViewController.swift
//  Drink-EG
//
//  Created by 이현주 on 7/30/24.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {

    let loginButton = UIButton(type: .system)
    let joinButton = UIButton(type: .system)
    
    let kakaoButton = UIButton(type: .system)
    let appleButton = UIButton(type: .system)
    
    let idStoreButton = UIButton(type: .system)
    private let checkImage = UIImage(named: "icon_check_fill")
    private let ncheckImage = UIImage(named: "icon_check_nfill")
    
    let idSearchButton = UIButton(type: .system)
    
    let idTextField = UITextField()
    let pwTextField = UITextField()
    
    private let notYetLabel: UILabel = {
        let l = UILabel()
        l.text = "아직 회원이 아니신가요?"
        l.textColor = UIColor(hue: 0, saturation: 0, brightness: 0.71, alpha: 1.0)
        l.font = UIFont.boldSystemFont(ofSize: 14)
        
        return l
    }()
    
    private let idStoreLabel: UILabel = {
        let l = UILabel()
        l.text = "아이디 저장"
        l.textColor = UIColor(hex: "#999999")
        l.font = UIFont.systemFont(ofSize: 14)
        
        return l
    }()
    
    private let idLabel: UILabel = {
        let id = UILabel()
        id.text = "아이디"
        id.textColor = UIColor.white
        id.font = UIFont.boldSystemFont(ofSize: 15)
        
        return id
    }()
    
    private let pwLabel: UILabel = {
        let pw = UILabel()
        pw.text = "비밀번호"
        pw.textColor = UIColor.white
        pw.font = UIFont.boldSystemFont(ofSize: 15)
        
        return pw
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named:"icon_back")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named:"icon_back")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor = .white
        
        let titleLabel = UILabel()
        titleLabel.text = "로그인"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
                
        let titleView = UIView()
        titleView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(5)
        }
        
        self.navigationItem.titleView = titleView

        view.backgroundColor = .black
        
        setupUI()
    }
    
    private func setupUI() {
        configureLoginButton()
        configureJoinButton()
        configureKakaoButton()
        configureAppleButton()
        configureIdStoreButton()
        configureIdSearchButton()
        configureIdTextField()
        configurePwTextField()
        
        let joinStackView = UIStackView(arrangedSubviews: [notYetLabel, joinButton])
        joinStackView.axis = .horizontal
        joinStackView.distribution = .fillProportionally
        joinStackView.spacing = 4
        
        view.addSubview(joinStackView)
        joinStackView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(771)
            make.leading.trailing.equalTo(view).inset(96)
            make.width.equalTo(190)
            make.height.equalTo(22)
        }
        
        let buttonStackView = UIStackView(arrangedSubviews: [kakaoButton, appleButton])
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 13
                
        view.addSubview(buttonStackView)
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(571)
            make.leading.trailing.equalToSuperview().inset(110)
            make.centerX.equalToSuperview()
            make.width.equalTo(173)
            make.height.equalTo(60)
        }
        
        let idStoreStackView = UIStackView(arrangedSubviews: [idStoreButton, idStoreLabel])
        idStoreStackView.axis = .horizontal
        idStoreStackView.distribution = .fillProportionally
        idStoreStackView.spacing = 5
                
        view.addSubview(idStoreStackView)
        idStoreStackView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(368)
            make.leading.equalTo(view).offset(43)
            make.width.equalTo(110)
            make.height.equalTo(22)
        }
        
        view.addSubview(idLabel)
        idLabel.snp.makeConstraints { make in
            make.top.equalTo(view).offset(140)
            make.leading.equalTo(view).offset(43)
        }
        
        view.addSubview(idTextField)
        idTextField.snp.makeConstraints { make in
            make.top.equalTo(view).offset(172)
            make.leading.trailing.equalTo(view).inset(33)
            make.width.equalTo(327)
            make.height.equalTo(60)
        }
        
        view.addSubview(pwLabel)
        pwLabel.snp.makeConstraints { make in
            make.top.equalTo(view).offset(252)
            make.leading.equalTo(view).offset(43)
        }
        
        view.addSubview(pwTextField)
        pwTextField.snp.makeConstraints { make in
            make.top.equalTo(view).offset(284)
            make.leading.trailing.equalTo(view).inset(33)
            make.width.equalTo(327)
            make.height.equalTo(60)
        }
        
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(view).offset(461)
            make.centerX.equalToSuperview()
            make.leading.equalTo(view).offset(33)
            make.height.equalTo(60)
            make.width.equalTo(327)
        }
        
        view.addSubview(idSearchButton)
        idSearchButton.snp.makeConstraints { make in
            make.top.equalTo(view).offset(368)
            make.trailing.equalTo(view).inset(43)
            make.width.equalTo(117)
            make.height.equalTo(22)
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
    }
    
    private func configureJoinButton() {
        joinButton.setTitle("회원가입", for: .normal)
        joinButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        joinButton.setTitleColor(UIColor(hex: "#FFEA75"), for: .normal)
        joinButton.contentHorizontalAlignment = .center
        
        joinButton.backgroundColor = .clear
        joinButton.addTarget(self, action: #selector(joinButtonTapped), for: .touchUpInside)
    }
    
    @objc private func joinButtonTapped() {
        let joinViewController = JoinViewController()
        navigationController?.pushViewController(joinViewController, animated: true)
    }
    
    private func configureKakaoButton() {
        //카카오 이미지를 아이콘 포멧 이미지에 맞게 바꿈
        kakaoButton.setImage(UIImage(named: "kakao")?.withRenderingMode(.alwaysOriginal), for: .normal)

        kakaoButton.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0.26, alpha: 0.5)
        kakaoButton.layer.cornerRadius = 16
        kakaoButton.layer.borderWidth = 2
        kakaoButton.layer.borderColor = UIColor.white.cgColor.copy(alpha: 0.1)
        
    }
    
    private func configureAppleButton() {
        appleButton.setImage(UIImage(named: "apple")?.withRenderingMode(.alwaysOriginal), for: .normal)
        appleButton.tintColor = .white
        
        appleButton.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0.26, alpha: 0.5)
        appleButton.layer.cornerRadius = 16
        appleButton.layer.borderWidth = 2
        appleButton.layer.borderColor = UIColor.white.cgColor.copy(alpha: 0.1)
    }
    
    private func configureIdStoreButton() {
        idStoreButton.setImage(ncheckImage?.withRenderingMode(.alwaysOriginal), for: .normal)
        idStoreButton.backgroundColor = .clear
        idStoreButton.addTarget(self, action: #selector(idStoreButtonTapped), for: .touchUpInside)
    }
    
    @objc private func idStoreButtonTapped(_ sender: UIButton) {
        // Bool 값 toggle
        sender.isSelected.toggle()
            
        // 버튼이 클릭될 때마다, 버튼 이미지를 변환
        if sender.isSelected {
            sender.setImage(checkImage?.withRenderingMode(.alwaysOriginal), for: .selected)
        } else {
            sender.setImage(ncheckImage?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
    
    private func configureIdSearchButton() {
        idSearchButton.setTitle("아이디/비밀번호 찾기", for: .normal)
        idSearchButton.setTitleColor(UIColor(hex: "#999999"), for: .normal)
        idSearchButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        idSearchButton.backgroundColor = .clear
    }
    
    private func configureIdTextField() {
        idTextField.attributedPlaceholder = NSAttributedString(string: "아이디를 입력해 주세요", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: "#999999")!, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular)])
        idTextField.textColor = .white
        idTextField.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0.26, alpha: 0.5)
        idTextField.layer.cornerRadius = 16
        idTextField.layer.borderWidth = 2
        idTextField.layer.borderColor = UIColor.white.cgColor.copy(alpha: 0.1)
        idTextField.setIdIcon(UIImage(named: "icon_person")!)
    }
    
    private func configurePwTextField() {
        pwTextField.attributedPlaceholder = NSAttributedString(string: "비밀번호를 입력해 주세요", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: "#999999")!, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular)])
        pwTextField.textColor = .white
        pwTextField.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0.26, alpha: 0.5)
        pwTextField.layer.cornerRadius = 16
        pwTextField.layer.borderWidth = 2
        pwTextField.layer.borderColor = UIColor.white.cgColor.copy(alpha: 0.1)
        pwTextField.setPwIcon(UIImage(named: "icon_lock")!)
    }
}

extension UITextField {
    func setIdIcon(_ image: UIImage) {
        let iconView = UIImageView(frame: CGRect(x: 26, y: -9, width: 16, height: 16))
        iconView.image = image
        let iconContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 58, height: self.frame.height))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = ViewMode.always
    }
    
    func setPwIcon(_ image: UIImage) {
        let iconView = UIImageView(frame: CGRect(x: 28, y: -10, width: 13.5, height: 18))
        iconView.image = image
        let iconContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 58, height: self.frame.height))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = ViewMode.always
    }
}

