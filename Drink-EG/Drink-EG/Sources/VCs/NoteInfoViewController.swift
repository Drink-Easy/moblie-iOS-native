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
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    var selectedWineId: Int?
    var selectedWineImage: String?
    var selectedWineName: String?
    var dataList: [RadarChartData] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
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
    
    func setupView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.backgroundColor = .clear
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.height.equalTo(UIScreen.main.bounds.height)
        }
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
        contentView.addSubview(tastingnoteLabel)
        tastingnoteLabel.text = "테이스팅 노트"
        tastingnoteLabel.font = UIFont(name: "Pretendard-Bold", size: 28)
        tastingnoteLabel.textAlignment = .center
        tastingnoteLabel.textColor = .black
    }
    
    func setuptastingnoteLabelConstraints() { // Label의 제약 조건을 설정하는 함수
        tastingnoteLabel.snp.makeConstraints{ make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(46)
            make.leading.equalTo(contentView.safeAreaLayoutGuide.snp.leading).offset(16)
        }
    }
    
    func setupPentagonChart() {
        contentView.addSubview(pentagonChart)
        pentagonChart.dataList = dataList
        pentagonChart.layer.cornerRadius = 10
        pentagonChart.addTarget(self, action: #selector(pentagonButtonTapped), for: .touchUpInside)
    }
    
    func setupPentagonChartConstraints() {
        pentagonChart.snp.makeConstraints{ make in
            make.top.equalTo(wineView.snp.bottom).offset(10)
            make.centerX.equalTo(contentView.safeAreaLayoutGuide.snp.centerX)
            make.leading.equalTo(wineView.snp.leading)
            make.height.equalTo(UIScreen.main.bounds.height * 0.45)
        }
    }
    
    func setupWineView() {
        contentView.addSubview(wineView)
        wineView.backgroundColor = UIColor(hex: "FF9F8E80")
        wineView.layer.cornerRadius = 10
        wineView.layer.borderWidth = 2
        wineView.layer.borderColor = UIColor(hex: "FA735B")?.cgColor
    }
    
    func setupWineViewConstraints() {
        wineView.snp.makeConstraints{ make in
            make.top.equalTo(tastingnoteLabel.snp.bottom).offset(32)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            make.leading.equalTo(tastingnoteLabel.snp.leading)
            make.height.equalTo(UIScreen.main.bounds.height * 0.12)
        }
    }
    
    func setupWineImageView() {
        wineView.addSubview(wineImageView)
        wineImageView.contentMode = .scaleAspectFit
        wineImageView.layer.cornerRadius = 10
        wineImageView.layer.masksToBounds = true
        if let imageUrl = selectedWineImage, let url = URL(string: imageUrl) {
            wineImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "Loxton"))
        } else {
            wineImageView.image = UIImage(named: "Loxton")
        }
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
        wineName.text = selectedWineName ?? ""
        wineName.font = UIFont(name: "Pretendard-SemiBold", size: 18)
        wineName.numberOfLines = 0
        wineName.lineBreakMode = .byWordWrapping
    }
    
    func setupWineNameConstraints() {
        wineName.snp.makeConstraints{ make in
            make.leading.equalTo(wineImageView.snp.trailing).offset(20)
            make.trailing.equalTo(wineView.snp.trailing).offset(-10)
            make.top.equalTo(wineView.snp.top).offset(36)
        }
    }
    
    func setupChooseColorView() {
        contentView.addSubview(chooseColorView)
        chooseColorView.backgroundColor = .white
        chooseColorView.layer.borderWidth = 2
        chooseColorView.layer.cornerRadius = 10
        chooseColorView.layer.borderColor = UIColor(hex: "0000001A")?.cgColor
    }
    
    func setupChooseColorViewConstraints() {
        chooseColorView.snp.makeConstraints{ make in
            make.top.equalTo(pentagonChart.snp.bottom).offset(10)
            make.centerX.equalTo(wineView.snp.centerX)
            make.leading.equalTo(pentagonChart.snp.leading)
            make.height.equalTo(UIScreen.main.bounds.height * 0.21)
        }
    }
    
    func setupChooseColorLabel() {
        chooseColorView.addSubview(chooseColorLabel)
        chooseColorLabel.text = "색상 선택"
        chooseColorLabel.textAlignment = .center
        chooseColorLabel.textColor = .black
        chooseColorLabel.font = UIFont(name: "Pretendard-Bold", size: 22)
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
            i.addTarget(self, action: #selector(colorButtonTapped(_:)), for: .touchUpInside)
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
                make.width.height.equalTo(chooseColorView.snp.height).multipliedBy(0.22) // 수정 필요
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
    
    @objc func colorButtonTapped(_ sender: UIButton) {
        let vc = ChooseTasteViewController()
        let buttonColor = sender.backgroundColor?.toHex()
        
        vc.dataList = dataList
        vc.receivedColor = buttonColor!
        vc.selectedWineId = selectedWineId
        vc.selectedWineImage = selectedWineImage
        vc.selectedWineName = selectedWineName
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

