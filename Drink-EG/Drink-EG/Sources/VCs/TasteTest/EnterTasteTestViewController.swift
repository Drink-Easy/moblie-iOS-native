//
//  EnterTasteTestViewController.swift
//  Drink-EG
//
//  Created by 이현주 on 8/2/24.
//

import UIKit

class EnterTasteTestViewController: UIViewController {
    
    let startButton = UIButton(type: .system)
    
    private let hiLabel: UILabel = {
        let l = UILabel()
        l.text = "안녕하세요 ,\n만나서 반갑습니다 !"
        l.textColor = .black
        l.textAlignment = .left
        l.font = UIFont.systemFont(ofSize: 32, weight: UIFont.Weight(rawValue: 700))
        l.numberOfLines = 0
        
        return l
    }()
    
    private let plzLabel: UILabel = {
        let l = UILabel()
        l.text = "어플을 더욱 알차게 사용하실 수 있게\n저희에게 몇가지 정보를 알려주세요 !"
        l.textColor = .black
        l.textAlignment = .left
        l.font = UIFont.systemFont(ofSize: 20)
        l.numberOfLines = 0
        
        return l
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named:"icon_back")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named:"icon_back")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor = .black
        
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        configureStartButton()
        
        view.addSubview(startButton)
        startButton.snp.makeConstraints { make in
            make.top.equalTo(view).offset(727)
            make.centerX.equalToSuperview()
            make.leading.equalTo(view).offset(33)
            make.height.equalTo(60)
            make.width.equalTo(327)
        }
        
        let buttonStackView = UIStackView(arrangedSubviews: [hiLabel, plzLabel])
        buttonStackView.axis = .vertical
        //buttonStackView.distribution = .fillProportionally
        buttonStackView.spacing = 25
                
        view.addSubview(buttonStackView)
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(125)
            make.leading.equalToSuperview().offset(27)
            make.width.equalTo(338)
            make.height.equalTo(165)
        }
    }
    
    private func configureStartButton() {
        startButton.setTitle("시작하기", for: .normal)
        startButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        startButton.setTitleColor(.black, for: .normal)
        startButton.contentHorizontalAlignment = .center
        
        startButton.backgroundColor = UIColor(hue: 0.1389, saturation: 0.54, brightness: 1, alpha: 1.0)
        startButton.layer.cornerRadius = 16
        startButton.layer.borderWidth = 0
        
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    @objc private func startButtonTapped() {
        let firstTasteTestViewController = FirstTasteTestViewController()
        navigationController?.pushViewController(firstTasteTestViewController, animated: true)
    }
}
