//
//  ThirdTasteTestViewController.swift
//  Drink-EG
//
//  Created by 이현주 on 8/2/24.
//

import UIKit

class ThirdTasteTestViewController: UIViewController {
    
    let nextButton = UIButton(type: .system)
    
    private let titleLabel: UILabel = {
        let l = UILabel()
        l.text = "제 와인 취향은..."
        l.textColor = .black
        l.textAlignment = .left
        l.font = UIFont.systemFont(ofSize: 32, weight: UIFont.Weight(rawValue: 700))
        
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
    }
    
    private func configureNextButton() {
        nextButton.setTitle("다음", for: .normal)
        nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        nextButton.setTitleColor(.black, for: .normal)
        nextButton.contentHorizontalAlignment = .center
        
        nextButton.setImage(UIImage(named: "icon_next"), for: .normal)
        nextButton.imageView?.contentMode = .center
        nextButton.tintColor = UIColor(hex: "#767676")
        nextButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 105, bottom: 0, right: 0)
        
        nextButton.backgroundColor = UIColor(hex: "#E2E2E2")
        nextButton.layer.cornerRadius = 16
        nextButton.layer.borderWidth = 0
    }

}
