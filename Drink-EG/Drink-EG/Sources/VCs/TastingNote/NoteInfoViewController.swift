//
//  NoteInfoViewController.swift
//  Drink-EG
//
//  Created by 김도연 on 7/21/24.
//

import Foundation
import UIKit
import SnapKit

class NoteInfoViewController: UIViewController {
    
    let tastingnoteLabel = UILabel()
    let pentagonChart = PolygonChartView()
    let wineView = UIView()
    let wineImageView = UIImageView()
    let wineName = UILabel()
    let chooseColorView = UIView()
    let chooseColorLabel = UILabel()
    let chooseColorButtons = [UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton()]
    var dataList: [RadarChartData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBarButton()
        setupLabel()
        setuptastingnoteLabelConstraints()
        setupWineView()
        setupWineViewConstraints()
        setupWineImageView()
        setupWineImageViewConstraints()
        setupWineName()
        setupWineNameConstraints()
        setupPentagonChart()
        setupPentagonChartConstraints()
        setupChooseColorView()
        setupChooseColorViewConstraints()
        setupChooseColorLabel()
        setupChooseColorLabelConstraints()
        setupColorButton()
        setupColorButtonConstraints()
    }
    
    func setupNavigationBarButton() {
        navigationItem.hidesBackButton = true
        let backArrow = UIImage(systemName: "chevron.backward")
        let leftButton = UIBarButtonItem(image: backArrow, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = leftButton
        leftButton.tintColor = .black
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    
    func setupLabel() { // Label의 기본 속성을 설정하는 함수
        view.addSubview(tastingnoteLabel)
        tastingnoteLabel.text = "테이스팅 노트"
        tastingnoteLabel.font = .boldSystemFont(ofSize: 30)
        tastingnoteLabel.textAlignment = .center
        tastingnoteLabel.textColor = .black
    }
    
    func setuptastingnoteLabelConstraints() { // Label의 제약 조건을 설정하는 함수
        tastingnoteLabel.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(46)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
        }
    }
    
    func setupPentagonChart() {
        view.addSubview(pentagonChart)
        pentagonChart.dataList = dataList
        pentagonChart.layer.cornerRadius = 10
        pentagonChart.addTarget(self, action: #selector(pentagonButtonTapped), for: .touchUpInside)
    }
    
    func setupPentagonChartConstraints() {
        pentagonChart.snp.makeConstraints{ make in
            make.top.equalTo(wineView.snp.bottom).offset(10)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(361)
            make.height.equalTo(349)
        }
    }
    
    func setupWineView() {
        view.addSubview(wineView)
        wineView.backgroundColor = UIColor(hex: "FF9F8E80")
        wineView.layer.cornerRadius = 10
    }
    
    func setupWineViewConstraints() {
        wineView.snp.makeConstraints{ make in
            make.top.equalTo(tastingnoteLabel.snp.bottom).offset(32)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            make.leading.equalTo(tastingnoteLabel.snp.leading)
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
    
    func setupChooseColorView() {
        view.addSubview(chooseColorView)
        chooseColorView.backgroundColor = .white
        chooseColorView.layer.borderWidth = 2
        chooseColorView.layer.cornerRadius = 10
        chooseColorView.layer.borderColor = UIColor(hex: "0000001A")?.cgColor
    }
    
    func setupChooseColorViewConstraints() {
        chooseColorView.snp.makeConstraints{ make in
            make.top.equalTo(pentagonChart.snp.bottom).offset(10)
            make.centerX.equalTo(wineView.snp.centerX)
            make.width.equalTo(361)
            make.height.equalTo(317)
        }
    }
    
    func setupChooseColorLabel() {
        chooseColorView.addSubview(chooseColorLabel)
        chooseColorLabel.text = "색상 선택"
        chooseColorLabel.textAlignment = .center
        chooseColorLabel.textColor = .black
    }
    
    func setupChooseColorLabelConstraints() {
        chooseColorLabel.snp.makeConstraints{ make in
            make.leading.equalTo(chooseColorView.snp.leading).offset(19)
            make.top.equalTo(chooseColorView.snp.top).offset(27)
            make.width.equalTo(119)
            make.height.equalTo(35)
        }
    }
    
    func setupColorButton() {
        for i in chooseColorButtons {
            chooseColorView.addSubview(i)
            i.layer.cornerRadius = 10
        }
        
        chooseColorButtons[0].backgroundColor = UIColor(hex: "FFFBD8")
        chooseColorButtons[1].backgroundColor = UIColor(hex: "FDEFA4")
        chooseColorButtons[2].backgroundColor = UIColor(hex: "FEB6B6")
        chooseColorButtons[3].backgroundColor = UIColor(hex: "BA2121")
        chooseColorButtons[4].backgroundColor = UIColor(hex: "892222")
        chooseColorButtons[5].backgroundColor = UIColor(hex: "521515")
    }
    
    func setupColorButtonConstraints() {
        for i in 0..<chooseColorButtons.count {
            let button = chooseColorButtons[i]
            button.snp.makeConstraints{ make in
                make.top.equalTo(chooseColorLabel.snp.bottom).offset(10)
                make.width.height.equalTo(40)
                if i == 0 {
                    make.leading.equalTo(chooseColorView.snp.leading).offset(19)
                } else {
                    make.leading.equalTo(chooseColorButtons[i-1].snp.trailing).offset(8)
                }
            }
        }
    }
    
    @objc func pentagonButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    
}
