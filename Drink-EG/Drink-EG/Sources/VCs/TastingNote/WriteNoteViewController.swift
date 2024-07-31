//
//  WriteNoteViewController.swift
//  Drink-EG
//
//  Created by 김도연 on 7/21/24.
//

import Foundation
import UIKit
import SnapKit

class WriteNoteViewController: UIViewController {
    let tasteSelect = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        setupTasteSelectStackView()
        setupTasteSelectStackViewConstraints()
    }
    
    func setupView() {
        view.addSubview(tasteSelect)
    }

    func setupTasteSelectStackView() {
        tasteSelect.axis = .vertical
        tasteSelect.spacing = 20
        tasteSelect.addArrangedSubview(createRow(labelText: "당도", lowText: "dry", highText: "sweet"))
        tasteSelect.addArrangedSubview(createRow(labelText: "산도", lowText: "low", highText: "high"))
        tasteSelect.addArrangedSubview(createRow(labelText: "타닌", lowText: "low", highText: "high"))
        tasteSelect.addArrangedSubview(createRow(labelText: "바디", lowText: "light", highText: "bold"))
        tasteSelect.addArrangedSubview(createRow(labelText: "알코올", lowText: "low", highText: "high"))
    }
    
    func setupTasteSelectStackViewConstraints() {
        tasteSelect.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
    }
    
    func createRow(labelText: String, lowText: String, highText: String) -> UIStackView {
        let rowStackView = UIStackView()
        rowStackView.axis = .horizontal
        rowStackView.spacing = 10
            
        let label = UILabel()
        label.text = labelText
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.backgroundColor = .white
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(40)
        }
            
        let lowLabel = UILabel()
        lowLabel.text = lowText
        lowLabel.font = UIFont.systemFont(ofSize: 12)
            
        let highLabel = UILabel()
        highLabel.text = highText
        highLabel.font = UIFont.systemFont(ofSize: 12)
            
        rowStackView.addArrangedSubview(label)
        rowStackView.addArrangedSubview(lowLabel)
            
        for _ in 1...5 {
            let button = UIButton()
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.black.cgColor
            button.snp.makeConstraints { make in
                make.width.height.equalTo(30)
        }
            rowStackView.addArrangedSubview(button)
        }
            
        rowStackView.addArrangedSubview(highLabel)
            
        return rowStackView
    }
}
