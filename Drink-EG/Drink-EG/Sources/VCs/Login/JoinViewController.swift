//
//  JoinViewController.swift
//  Drink-EG
//
//  Created by 이현주 on 7/30/24.
//
import UIKit
import SnapKit
import Moya

class JoinViewController: UIViewController {
    // MARK: - Properties
    let provider = MoyaProvider<LoginAPI>()
    public var userID: String?
    public var userPW: String?
    var joinDTO: JoinNLoginRequest?
    
    let joinButton = UIButton(type: .system)
    let loginButton = UIButton(type: .system)
    
    let kakaoButton = UIButton(type: .system)
    let appleButton = UIButton(type: .system)
    
    let idTextField = UITextField()
    let pwTextField = UITextField()
    let pwAgainTextField = UITextField()
    
    let alreadyLabel: UILabel = {
        let l = UILabel()
        l.text = "이미 계정이 있으신가요?"
        l.textColor = UIColor(hue: 0, saturation: 0, brightness: 0.71, alpha: 1.0)
        l.font = UIFont.boldSystemFont(ofSize: 14)
        return l
    }()
    
    let idLabel: UILabel = {
        let id = UILabel()
        id.text = "아이디"
        id.textColor = UIColor.white
        id.font = UIFont.boldSystemFont(ofSize: 15)
        return id
    }()
    
    let pwLabel: UILabel = {
        let pw = UILabel()
        pw.text = "비밀번호"
        pw.textColor = UIColor.white
        pw.font = UIFont.boldSystemFont(ofSize: 15)
        return pw
    }()
    
    let pwAgainLabel: UILabel = {
        let pwA = UILabel()
        pwA.text = "비밀번호 재입력"
        pwA.textColor = UIColor.white
        pwA.font = UIFont.boldSystemFont(ofSize: 15)
        return pwA
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        self.setupNavigationBar()
        self.setupUI()
    }
    
    // MARK: - Button Actions
    @objc private func joinButtonTapped() {
        assignUserData()
        callJoinAPI { [weak self] isSuccess in
            if isSuccess {
                self?.goToLoginView()
            } else {
                print("회원가입 실패")
                // 실패 시에 대한 추가 처리
            }
        }
    }
    
    @objc private func loginButtonTapped() {
        goToLoginView()
    }
    
    // MARK: - Private Methods
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named:"icon_back")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named:"icon_back")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor = .white
        
        let titleLabel = UILabel()
        titleLabel.text = "가입하기"
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
    }
    
    private func goToLoginView() {
        let loginViewController = LoginViewController()
        navigationController?.pushViewController(loginViewController, animated: true)
    }
}

extension JoinViewController {
    func setupUI() {
        configureJoinButton()
        configureLoginButton()
        configureKakaoButton()
        configureAppleButton()
        configureIdTextField()
        configurePwTextField()
        configurePwAgainTextField()
        setupLayout()
    }
    
    private func setupLayout() {
        let loginStackView = UIStackView(arrangedSubviews: [alreadyLabel, loginButton])
        loginStackView.axis = .horizontal
        loginStackView.distribution = .fillProportionally
        loginStackView.spacing = 4
        
        view.addSubview(loginStackView)
        loginStackView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(771)
            make.leading.trailing.equalTo(view).inset(97)
            make.width.equalTo(180)
            make.height.equalTo(22)
        }
        
        let buttonStackView = UIStackView(arrangedSubviews: [kakaoButton, appleButton])
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 13
        
        view.addSubview(buttonStackView)
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(594)
            make.leading.trailing.equalToSuperview().inset(110)
            make.centerX.equalToSuperview()
            make.width.equalTo(173)
            make.height.equalTo(60)
        }
        
        view.addSubview(idLabel)
        idLabel.snp.makeConstraints { make in
            make.top.equalTo(view).offset(136)
            make.leading.equalTo(view).offset(43)
        }
        
        view.addSubview(idTextField)
        idTextField.snp.makeConstraints { make in
            make.top.equalTo(view).offset(168)
            make.leading.trailing.equalTo(view).inset(33)
            make.width.equalTo(327)
            make.height.equalTo(60)
        }
        
        view.addSubview(pwLabel)
        pwLabel.snp.makeConstraints { make in
            make.top.equalTo(view).offset(248)
            make.leading.equalTo(view).offset(43)
        }
        
        view.addSubview(pwTextField)
        pwTextField.snp.makeConstraints { make in
            make.top.equalTo(view).offset(280)
            make.leading.trailing.equalTo(view).inset(33)
            make.width.equalTo(327)
            make.height.equalTo(60)
        }
        
        view.addSubview(pwAgainLabel)
        pwAgainLabel.snp.makeConstraints { make in
            make.top.equalTo(view).offset(360)
            make.leading.equalTo(view).offset(43)
        }
        
        view.addSubview(pwAgainTextField)
        pwAgainTextField.snp.makeConstraints { make in
            make.top.equalTo(view).offset(392)
            make.leading.trailing.equalTo(view).inset(33)
            make.width.equalTo(327)
            make.height.equalTo(60)
        }
        
        view.addSubview(joinButton)
        joinButton.snp.makeConstraints { make in
            make.top.equalTo(view).offset(484)
            make.centerX.equalToSuperview()
            make.leading.equalTo(view).offset(33)
            make.height.equalTo(60)
            make.width.equalTo(327)
        }
    }
    
    private func configureJoinButton() {
        joinButton.setTitle("회원가입", for: .normal)
        joinButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        joinButton.setTitleColor(.black, for: .normal)
        joinButton.contentHorizontalAlignment = .center
        
        joinButton.backgroundColor = UIColor(hue: 0.1389, saturation: 0.54, brightness: 1, alpha: 1.0)
        joinButton.layer.cornerRadius = 16
        joinButton.layer.borderWidth = 0
        joinButton.addTarget(self, action: #selector(joinButtonTapped), for: .touchUpInside)
    }
    private func configureLoginButton() {
        loginButton.setTitle("로그인", for: .normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        loginButton.setTitleColor(UIColor(hex: "#FFEA75"), for: .normal)
        loginButton.contentHorizontalAlignment = .center
        
        loginButton.backgroundColor = .clear
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    private func configureKakaoButton() {
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
    private func configurePwAgainTextField() {
        pwAgainTextField.tag = 3
        pwAgainTextField.attributedPlaceholder = NSAttributedString(string: "비밀번호를 한번 더 입력해 주세요", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: "#999999")!, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular)])
        pwAgainTextField.textColor = .white
        pwAgainTextField.tintColor = .white
        pwAgainTextField.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0.26, alpha: 0.5)
        pwAgainTextField.layer.cornerRadius = 16
        pwAgainTextField.layer.borderWidth = 2
        pwAgainTextField.layer.borderColor = UIColor.white.cgColor.copy(alpha: 0.1)
        pwAgainTextField.setPwIcon(UIImage(named: "icon_lock")!)
        pwAgainTextField.returnKeyType = .done
        pwAgainTextField.textContentType = .password
        pwAgainTextField.isSecureTextEntry = true
        pwAgainTextField.textContentType = .newPassword
        pwAgainTextField.clearButtonMode = .always
    }
}

extension JoinViewController {
    func callJoinAPI(completion: @escaping (Bool) -> Void) {
        guard let data = self.joinDTO else {
            print("User Data가 없습니다.")
            completion(false)
            return
        }
        
        provider.request(.postRegister(data: data)) { result in
            switch result {
            case .success(let response):
                do {
                    let data = try response.map(APIResponseString.self)
                    print("User Created: \(data)")
                    completion(data.isSuccess)
                } catch {
                    print("Failed to map data: \(error)")
                    completion(false)
                }
            case .failure(let error):
                print("Request failed: \(error)")
                completion(false)
            }
        }
    }
}

extension JoinViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
        // 텍스트 필드가 선택되었을 때 배경색 변경
        textField.backgroundColor = UIColor(hue: 0.1389, saturation: 0.54, brightness: 1, alpha: 0.2)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(hex: "#FFEA75")?.cgColor
        if textField.tag == 1 {
            textField.setIdIcon(UIImage(named: "icon_person_fill")!)
        }
        else if textField.tag == 2 || textField.tag == 3 {
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
        else if textField.tag == 2 || textField.tag == 3 {
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
            self.pwAgainTextField.becomeFirstResponder()
        } else if textField == self.pwAgainTextField {
            if let rePW = self.pwAgainTextField.text {
                // 토스트 메세지 띄우기
            }
            self.pwAgainTextField.resignFirstResponder()
        }
        return true
    }
    
    // 배경 클릭시 키보드 내림  ==> view 에 터치가 들어오면 에디팅모드를 끝냄.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)  //firstresponder가 전부 사라짐
    }
}

extension JoinViewController {
    func assignUserData() {
        self.userID = self.idTextField.text
        self.userPW = self.pwTextField.text
        self.joinDTO = JoinNLoginRequest(username: self.userID ?? "", password: self.userPW ?? "")
    }
}
