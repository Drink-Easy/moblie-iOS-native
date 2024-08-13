//
//  WhatsURNameViewController.swift
//  Drink-EG
//
//  Created by 이현주 on 8/13/24.
//

import UIKit

class WhatsURNameViewController: UIViewController, UITextFieldDelegate {
    
    let nextButton = UIButton(type: .system)
    
    private let titleLabel: UILabel = {
        let l = UILabel()
        l.text = "제 이름은..."
        l.textColor = .black
        l.textAlignment = .left
        l.font = UIFont.systemFont(ofSize: 32, weight: UIFont.Weight(rawValue: 700))
        
        return l
    }()
    
    private let nameTextField: UITextField = {
        let t = UITextField()
        t.layer.cornerRadius = 16
        t.layer.masksToBounds = true
        t.backgroundColor = UIColor(hex: "E2E2E2")
        t.placeholder = "입력..."
        t.returnKeyType = .done
        t.clearButtonMode = .always
        t.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        t.leftViewMode = .always
        return t
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor = .black
        
        nameTextField.delegate = self
        
        // nameTextField의 값이 변경될 때 updateNextButtonState를 호출하도록 설정
        nameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            
        // 초기 상태 업데이트
        updateNextButtonState()
        
        view.backgroundColor = .white
        setupUI()
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        updateNextButtonState()
    }
    
    private func setupUI() {
        configureNextButton()
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(view).offset(727)
            make.centerX.equalToSuperview()
            make.leading.equalTo(view).offset(33)
            make.height.equalTo(60)
            make.width.equalTo(327)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view).offset(125)
            make.leading.equalToSuperview().offset(18)
            make.width.equalTo(338)
            make.height.equalTo(44)
        }
        
        view.addSubview(nameTextField)
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(46)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(17)
            make.height.greaterThanOrEqualTo(60)
        }
    }
    
    private func configureNextButton() {
        nextButton.setTitle("다음", for: .normal)
        nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.contentHorizontalAlignment = .center
        
        nextButton.setImage(UIImage(named: "icon_next"), for: .normal)
        nextButton.imageView?.contentMode = .center
        nextButton.tintColor = .white
        nextButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 105, bottom: 0, right: 0)
        
        nextButton.backgroundColor = UIColor(hex: "#E2E2E2")
        nextButton.layer.cornerRadius = 16
        nextButton.layer.borderWidth = 0
    }
    
    private func updateNextButtonState() {
        if let text = nameTextField.text, text.isEmpty {
            // 선택된 셀이 없는 경우
            nextButton.isEnabled = false
            nextButton.backgroundColor = UIColor(hex: "#E2E2E2")
            nextButton.removeTarget(nil, action: nil, for: .allEvents)
        } else {
            // 선택된 셀이 하나 이상 있는 경우
            nextButton.setTitleColor(.white, for: .normal)
            nextButton.tintColor = .white
            nextButton.isEnabled = true
            nextButton.backgroundColor = UIColor(hex: "FA735B")
            nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        }
    }
    
    @objc private func nextButtonTapped() {
        let firstTasteTestViewController = FirstTasteTestViewController()
        navigationController?.pushViewController(firstTasteTestViewController, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.nameTextField {
            self.nameTextField.resignFirstResponder()
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)  //firstresponder가 전부 사라짐
    }
}
