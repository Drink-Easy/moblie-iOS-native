//
//  ChooseTasteViewController.swift
//  Drink-EG
//
//  Created by 이수현 on 8/3/24.
//

import Foundation
import UIKit
import SnapKit

class ChooseTasteViewController: UIViewController {
    
    let colorView = UIView()
    let colorBox = UIView()
    let colorLabel = UILabel()
    let tasteView = UIView()
    let tasteOptions = [UIButton(), UIButton(), UIButton()]
    let aromaLabel = UILabel()
    let tasteLabel = UILabel()
    let finishLabel = UILabel()
    let wineView = UIView()
    let wineImageView = UIImageView()
    let wineName = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupWineView()
        setupWineViewConstraints()
        setupWineImageView()
        setupWineImageViewConstraints()
        setupWineName()
        setupWineNameConstraints()
        setupColorView()
        setupColorViewConstraints()
        setupColorLabel()
        setupColorLabelConstraints()
        setupColorBox()
        setupColorBoxConstraints()
        setupTasteView()
        setupTasteViewConstraints()
        setupTasteOptions()
        setupTasteOptionsConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.navigationBar.barTintColor = UIColor.red // 네비게이션 바 배경색
        self.navigationController?.navigationBar.tintColor = UIColor.red // 네비게이션 아이템 색상
    }
    
    func setupWineView() {
        view.addSubview(wineView)
        wineView.backgroundColor = UIColor(hex: "FFD73880")
        wineView.layer.cornerRadius = 10
    }
    
    func setupWineViewConstraints() {
        wineView.snp.makeConstraints{ make in
            make.top.equalTo(view.snp.top).offset(156)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(361)
            make.height.equalTo(94)
        }
    }
    
    func setupWineImageView() {
        wineView.addSubview(wineImageView)
        wineImageView.contentMode = .scaleAspectFit
        wineImageView.layer.cornerRadius = 10
        wineImageView.layer.masksToBounds = true
        wineImageView.image = UIImage(named: "SampleImage")
    }
    
    func setupWineImageViewConstraints() {
        wineImageView.snp.makeConstraints{ make in
            make.leading.equalTo(wineView.snp.leading).offset(8)
            make.top.equalTo(wineView.snp.top).offset(7)
            make.bottom.equalTo(wineView.snp.bottom).offset(-7)
            make.width.height.equalTo(80)
            
        }
    }
    
    func setupWineName() {
        wineView.addSubview(wineName)
        wineName.text = "19 Crhnes"
        
    }
    
    func setupWineNameConstraints() {
        wineName.snp.makeConstraints{ make in
            make.centerY.equalTo(wineImageView.snp.centerY)
            make.leading.equalTo(wineImageView.snp.trailing).offset(25)
            make.top.equalTo(wineView.snp.top).offset(36)
            make.bottom.equalTo(wineView.snp.bottom).offset(-36)
        }
    }
    
    func setupColorView() {
        view.addSubview(colorView)
        colorView.backgroundColor = .white
        colorView.layer.borderColor = UIColor(hex: "0000001A")?.cgColor
        colorView.layer.borderWidth = 2
        colorView.layer.cornerRadius = 10
    }
    
    func setupColorViewConstraints() {
        colorView.snp.makeConstraints{ make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(wineView.snp.bottom).offset(10)
            make.width.equalTo(361)
            make.height.equalTo(142)
        }
    }
    
    func setupColorLabel() {
        colorView.addSubview(colorLabel)
        colorLabel.text = "색상"
        colorLabel.textAlignment = .center
        colorLabel.textColor = .black
    }
    
    func setupColorLabelConstraints() {
        colorLabel.snp.makeConstraints{ make in
            make.leading.equalTo(colorView.snp.leading).offset(15)
            make.top.equalTo(colorView.snp.top).offset(18)
            make.width.equalTo(119)
            make.height.equalTo(35)
        }
    }
    
    func setupColorBox() {
        colorView.addSubview(colorBox)
        colorBox.backgroundColor = UIColor(hex: "FDEFA4")
        colorBox.layer.cornerRadius = 10
    }
    
    func setupColorBoxConstraints() {
        colorBox.snp.makeConstraints{ make in
            make.leading.equalTo(colorView.snp.leading).offset(15)
            make.top.equalTo(colorLabel.snp.bottom).offset(10)
            make.width.height.equalTo(50)
        }
    }
    
    func setupTasteView() {
        view.addSubview(tasteView)
        tasteView.backgroundColor = UIColor(hex: "EAEAEA")
        tasteView.layer.cornerRadius = 10
        
    }

    func setupTasteViewConstraints() {
        tasteView.snp.makeConstraints{ make in
            make.top.equalTo(colorView.snp.bottom)
            make.centerX.equalTo(colorView.snp.centerX)
            make.width.equalTo(361)
            make.height.equalTo(404)
        }
    }
    
    func setupAromaLabel() {
        aromaLabel.text = "Aroma"
        aromaLabel.textAlignment = .center
        aromaLabel.textColor = .black
    }
    
    func setupTasteLabel() {
        tasteLabel.text = "Taste"
        tasteLabel.textAlignment = .center
        tasteLabel.textColor = .black
    }
    
    func setupFinsihLabel() {
        finishLabel.text = "Finish"
        finishLabel.textAlignment = .center
        finishLabel.textColor = .black
    }
    
    
    
    func setupTasteOptions() {
        for i in tasteOptions {
            
        }
    }
    
    func setupTasteOptionsConstraints() {
        
    }
    
    
}
