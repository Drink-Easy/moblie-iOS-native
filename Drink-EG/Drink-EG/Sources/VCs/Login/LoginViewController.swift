//
//  LoginViewController.swift
//  Drink-EG
//
//  Created by 이현주 on 7/30/24.
//

import UIKit
import SnapKit
import Moya


class LoginViewController: UIViewController, UITextFieldDelegate {
    
    let provider = MoyaProvider<LoginAPI>()
    public var userID : String?
    public var userPW : String?
    var loginDTO : JoinNLoginRequest?

    let loginButton = UIButton(type: .system)
    let joinButton = UIButton(type: .system)
    
    let kakaoButton = UIButton(type: .system)
    let appleButton = UIButton(type: .system)
    
    let idStoreButton = UIButton(type: .custom)
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
        
        idTextField.delegate = self
        pwTextField.delegate = self
        
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
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    @objc private func loginButtonTapped() {
        assignUserData()
        callLoginAPI()
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
        idTextField.tag = 1
        idTextField.attributedPlaceholder = NSAttributedString(string: "아이디를 입력해 주세요", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: "#999999")!, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular)])
        idTextField.textColor = .white
        idTextField.tintColor = .white
        idTextField.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0.26, alpha: 0.5)
        idTextField.layer.cornerRadius = 16
        idTextField.layer.borderWidth = 2
        idTextField.layer.borderColor = UIColor.white.cgColor.copy(alpha: 0.1)
        idTextField.setIdIcon(UIImage(named: "icon_person")!)
        idTextField.returnKeyType = .done
        idTextField.clearButtonMode = .always
    }
    
    private func configurePwTextField() {
        pwTextField.tag = 2
        pwTextField.attributedPlaceholder = NSAttributedString(string: "비밀번호를 입력해 주세요", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: "#999999")!, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular)])
        pwTextField.textColor = .white
        pwTextField.tintColor = .white
        pwTextField.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0.26, alpha: 0.5)
        pwTextField.layer.cornerRadius = 16
        pwTextField.layer.borderWidth = 2
        pwTextField.layer.borderColor = UIColor.white.cgColor.copy(alpha: 0.1)
        pwTextField.setPwIcon(UIImage(named: "icon_lock")!)
        pwTextField.returnKeyType = .done
        pwTextField.textContentType = .password
        pwTextField.isSecureTextEntry = true
        pwTextField.textContentType = .newPassword
        pwTextField.clearButtonMode = .always
    }
    
    // UITextFieldDelegate 메서드
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
        // 텍스트 필드가 선택되었을 때 배경색 변경
        textField.backgroundColor = UIColor(hue: 0.1389, saturation: 0.54, brightness: 1, alpha: 0.2)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(hex: "#FFEA75")?.cgColor
        if textField.tag == 1 {
            textField.setIdIcon(UIImage(named: "icon_person_fill")!)
        }
        else if textField.tag == 2 {
            textField.setPwIcon(UIImage(named: "icon_lock_fill")!)
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        // 텍스트 필드가 선택 해제되었을 때 배경색 원래대로
        textField.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0.26, alpha: 0.5)
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.white.cgColor.copy(alpha: 0.1)
        if textField.tag == 1 {
            textField.setIdIcon(UIImage(named: "icon_person")!)
        }
        else if textField.tag == 2 {
            textField.setPwIcon(UIImage(named: "icon_lock")!)
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.idTextField {
            if let id = self.idTextField.text {
                self.userID = id
            }
            self.pwTextField.becomeFirstResponder()
        } else if textField == self.pwTextField {
            if let pw = self.pwTextField.text {
                self.userPW = pw
            }
            self.pwTextField.resignFirstResponder()
        }
        return true
    }
    
    private func assignUserData() {
        self.userID = self.idTextField.text
        self.userPW = self.pwTextField.text
        self.loginDTO = JoinNLoginRequest(username: self.userID ?? "", password: self.userPW ?? "")
    }
    
    // 배경 클릭시 키보드 내림  ==> view 에 터치가 들어오면 에디팅모드를 끝냄.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)  //firstresponder가 전부 사라짐
    }
    
    private func callLoginAPI() -> APIResponseString? {
        var responseData : APIResponseString?
//        var isSuccess : Bool = false
        if let data = self.loginDTO {
            provider.request(.postLogin(data: data)) { result in
                switch result {
                case .success(let response):
                    do {
                        let data = try response.map(APIResponseString.self)
                        print("Login Success: \(data)")
                        responseData = data as APIResponseString
//                        isSuccess = data.isSuccess
                    } catch {
                        print("Failed to map data: \(error)")
                    }
                case .failure(let error):
                    print("Request failed: \(error)")
                }
            }
        } else {
            print("User Data가 없습니다.")
        }
        return responseData
    }
}

extension UITextField : UITextFieldDelegate {
    
    private static let idIconTag = 1
    private static let pwIconTag = 2
    
    func setIdIcon(_ image: UIImage) {
        if let iconContainerView = leftView,
            let iconView = iconContainerView.viewWithTag(UITextField.idIconTag) as? UIImageView {
            iconView.image = image
        } else {
            let iconView = UIImageView(frame: CGRect(x: 26, y: -9, width: 16, height: 16))
            iconView.image = image
            iconView.tag = UITextField.idIconTag
            let iconContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 58, height: self.frame.height))
            iconContainerView.addSubview(iconView)
            leftView = iconContainerView
            leftViewMode = .always
        }
    }

    func setPwIcon(_ image: UIImage) {
        if let iconContainerView = leftView,
            let iconView = iconContainerView.viewWithTag(UITextField.pwIconTag) as? UIImageView {
            iconView.image = image
        } else {
            let iconView = UIImageView(frame: CGRect(x: 28, y: -10, width: 13.5, height: 18))
            iconView.image = image
            iconView.tag = UITextField.pwIconTag
            let iconContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 58, height: self.frame.height))
            iconContainerView.addSubview(iconView)
            leftView = iconContainerView
            leftViewMode = .always
        }
    }
}

