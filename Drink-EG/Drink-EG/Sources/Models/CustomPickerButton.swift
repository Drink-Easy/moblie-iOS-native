//
//  CustomPickerButton.swift
//  Drink-EG
//
//  Created by 이현주 on 8/18/24.
//

import UIKit
import SnapKit

class CustomPickerButton: UIButton {
    
    var pickerView: UIPickerView?
    var toolbar: UIToolbar?
    var pickerData: [String] = []
    
    let pickerButtonHeight: CGFloat = 22
    let buttonWidth: CGFloat = 100
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    private func setupButton() {
        setTitle("분류 순서", for: .normal)
        setImage(UIImage(named: "pickerView"), for: .normal)
        backgroundColor = .white
        setTitleColor(UIColor(hex: "#767676"), for: .normal)
        titleLabel?.font = .boldSystemFont(ofSize: 12)
        contentHorizontalAlignment = .center
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 0)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = UIColor(hex: "#999999")?.cgColor
        addTarget(self, action: #selector(showPicker), for: .touchUpInside)
    }
    
    func setupPickerView(_ pickerView: UIPickerView, toolbar: UIToolbar, pickerData: [String]) {
        self.pickerView = pickerView
        self.toolbar = toolbar
        self.pickerData = pickerData
        
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.backgroundColor = .white
        pickerView.isHidden = true
        
        toolbar.isHidden = true
        toolbar.sizeToFit()
        let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(dismissPicker))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(donePicker))
        toolbar.setItems([cancelButton, flexibleSpace, doneButton], animated: false)
    }
    
    @objc private func showPicker() {
        pickerView?.isHidden = false
        toolbar?.isHidden = false
    }
    
    @objc private func dismissPicker() {
        pickerView?.isHidden = true
        toolbar?.isHidden = true
    }
    
    @objc private func donePicker() {
        if let pickerView = pickerView {
            let selectedOption = pickerData[pickerView.selectedRow(inComponent: 0)]
            setTitle(selectedOption, for: .normal)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            setImage(nil, for: .normal)
            dismissPicker()
        }
    }
}

// MARK: - UIPickerViewDataSource & UIPickerViewDelegate
extension CustomPickerButton: UIPickerViewDataSource, UIPickerViewDelegate {
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

