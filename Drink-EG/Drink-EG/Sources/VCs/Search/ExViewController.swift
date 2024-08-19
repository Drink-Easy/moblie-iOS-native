//
//  ExViewController.swift
//  Drink-EG
//
//  Created by 이현주 on 8/18/24.
//

import UIKit
import SnapKit

class ExViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let pickerButton = UIButton(type: .custom)
    let pickerView = UIPickerView()
    let toolbar = UIToolbar()
    let pickerData = ["낮은 가격순", "가까운 거리순"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // Setup Picker Button
        pickerButton.setTitle("분류 순서", for: .normal)
        pickerButton.setImage(UIImage(named: "pickerView"), for: .normal)
        pickerButton.backgroundColor = .white
        pickerButton.setTitleColor(UIColor(hex: "#767676"), for: .normal)
        pickerButton.titleLabel?.font = .boldSystemFont(ofSize: 12)
        pickerButton.contentHorizontalAlignment = .center
        pickerButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 0)
        pickerButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        pickerButton.layer.cornerRadius = 5
        pickerButton.layer.borderWidth = 1
        pickerButton.layer.borderColor = UIColor(hex: "#999999")?.cgColor
        pickerButton.addTarget(self, action: #selector(showPicker), for: .touchUpInside)
        
        
        view.addSubview(pickerButton)
        
        pickerButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
            make.width.equalTo(100)
            make.height.equalTo(22)
        }
        
        // Setup Picker View
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.backgroundColor = .white
        pickerView.isHidden = true
        view.addSubview(pickerView)
        
        pickerView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        // Setup Toolbar
        toolbar.isHidden = true
        toolbar.sizeToFit()
        let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(dismissPicker))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(donePicker))
        toolbar.setItems([cancelButton, flexibleSpace, doneButton], animated: false)
        view.addSubview(toolbar)
        
        toolbar.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(pickerView.snp.top)
        }
    }
    
    // MARK: - Actions
    @objc func showPicker() {
        pickerView.isHidden = false
        toolbar.isHidden = false
    }
    
    @objc func dismissPicker() {
        pickerView.isHidden = true
        toolbar.isHidden = true
    }
    
    @objc func donePicker() {
        let selectedOption = pickerData[pickerView.selectedRow(inComponent: 0)]
        pickerButton.setTitle(selectedOption, for: .normal)
        pickerButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        pickerButton.setImage(nil, for: .normal)
        dismissPicker()
    }
    
    // MARK: - UIPickerViewDataSource & Delegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
}
