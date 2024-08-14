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
    
    var dataList: [RadarChartData] = []
    
    let colorView = UIView()
    let colorBox = UIView()
    let colorLabel = UILabel()
    let tasteView = UIView()
    let tasteOptions = [[UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(),UIButton()],
                        [UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton()],
                        [UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton()],
    ]
    var selectedOptions: [String: [String]] = [:]
    let tastingnoteLabel = UILabel()
    let aromaLabel = UILabel()
    let tasteLabel = UILabel()
    let finishLabel = UILabel()
    let wineView = UIView()
    let wineImageView = UIImageView()
    let wineName = UILabel()
    let nextButton = UIButton()
    let scrollView = UIScrollView()
    let contentView = UIView()
    var receivedColor = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBarButton()
        setupView()
        setupLabel()
        setuptastingnoteLabelConstraints()
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
        setupAromaLabel()
        setupTasteLabel()
        setupFinsihLabel()
        setupTasteOptions()
        setupAromaLabelConstraints()
        setupTasteOptionsLabelConstraints()
        setupFinishOptionsLabelConstraints()
        setupNextButton()
        setupNextButtonConstraints()
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
    
    func setupView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.backgroundColor = .clear
        contentView.backgroundColor = .clear
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.height.greaterThanOrEqualTo(1374)
        }
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
            make.top.equalTo(contentView.snp.top).offset(46)
            make.leading.equalTo(contentView.snp.leading).offset(16)
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
            make.top.equalTo(tastingnoteLabel.snp.bottom).offset(47)
            make.centerX.equalTo(contentView.snp.centerX)
            make.leading.equalTo(tastingnoteLabel.snp.leading)
            make.height.greaterThanOrEqualTo(94)
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
        contentView.addSubview(colorView)
        colorView.backgroundColor = .white
        colorView.layer.borderColor = UIColor(hex: "0000001A")?.cgColor
        colorView.layer.borderWidth = 2
        colorView.layer.cornerRadius = 10
    }
    
    func setupColorViewConstraints() {
        colorView.snp.makeConstraints{ make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(wineView.snp.bottom).offset(10)
            make.leading.equalTo(wineView.snp.leading)
            make.height.greaterThanOrEqualTo(142)
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
            make.height.greaterThanOrEqualTo(35)
        }
    }
    
    func setupColorBox() {
        colorView.addSubview(colorBox)
        colorBox.backgroundColor = UIColor(hex: "\(receivedColor)")
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
        contentView.addSubview(tasteView)
        tasteView.backgroundColor = .clear
        tasteView.layer.borderWidth = 2
        tasteView.layer.borderColor = UIColor(hex: "F8F8FA")?.cgColor
        tasteView.layer.cornerRadius = 10
    }

    func setupTasteViewConstraints() {
        tasteView.snp.makeConstraints{ make in
            make.top.equalTo(colorView.snp.bottom).offset(13)
            make.centerX.equalTo(colorView.snp.centerX)
            make.leading.equalTo(colorView.snp.leading)
            make.height.greaterThanOrEqualTo(837)
        }
    }
    
    func setupAromaLabel() {
        tasteView.addSubview(aromaLabel)
        aromaLabel.text = "Aroma"
        aromaLabel.textAlignment = .center
        aromaLabel.textColor = .black
        aromaLabel.font = UIFont(name: "Pretend-SemiBold", size: 20)
    }
    
    func setupTasteLabel() {
        tasteView.addSubview(tasteLabel)
        tasteLabel.text = "Taste"
        tasteLabel.textAlignment = .center
        tasteLabel.textColor = .black
        tasteLabel.font = UIFont(name: "Pretend-SemiBold", size: 20)
    }
    
    func setupFinsihLabel() {
        tasteView.addSubview(finishLabel)
        finishLabel.text = "Finish"
        finishLabel.textAlignment = .center
        finishLabel.textColor = .black
        finishLabel.font = UIFont(name: "Pretend-SemiBold", size: 20)
    }
    
    func setupTasteOptions() {
        let array = ["레드베리", "체리", "딸기", "자두", "우드", "바닐라", "훈제", "민트", "너트", "라임", "자몽", "아카시아", "시가", "흙", "가죽", "직접추가"]
        for i in 0..<tasteOptions.count {
            for j in 0..<tasteOptions[i].count {
                let button = tasteOptions[i][j]
                tasteView.addSubview(button)
                
                var config = UIButton.Configuration.plain()
                config.title = array[j]
                
                config.titleAlignment = .leading
                config.baseForegroundColor = .black
                config.background.strokeColor = UIColor(hex: "C3C3C3")
                config.background.strokeWidth = 2
                config.background.cornerRadius = 100
                config.attributedTitle = AttributedString(array[j], attributes: AttributeContainer([
                    .font: UIFont(name: "Pretendard-SemiBold", size: 16)!
                ]))
                
                // 직접추가 버튼에만 아이콘 추가
                if array[j] == "직접추가" {
                    config.image = UIImage(systemName: "plus.circle")
                    config.imagePadding = 6
                    config.imagePlacement = .trailing
                }
                
                button.configuration = config
                button.addTarget(self, action: #selector(tasteOptionsTapped(_:)), for: .touchUpInside)
                
                let titleSize = button.titleLabel!.intrinsicContentSize
                button.snp.makeConstraints { make in
                    make.width.equalTo(titleSize.width+30)
                    make.height.greaterThanOrEqualTo(33)
                }
            }
        }
    }
    
    @objc func tasteOptionsTapped(_ sender : UIButton) {
        guard let title = sender.configuration?.title else { return }
        // Determine which section the button belongs to
        var section: String?
        if tasteOptions[0].contains(sender) {
            section = "Aroma"
        } else if tasteOptions[1].contains(sender) {
            section = "Taste"
        } else if tasteOptions[2].contains(sender) {
            section = "Finish"
        }
        
        guard let selectedSection = section else { return }
        
        if sender.backgroundColor == UIColor(hex: "FBCBC4") {
            sender.backgroundColor = .clear
            sender.layer.borderColor = UIColor(hex: "C3C3C3")?.cgColor
            if var selectedTitles = selectedOptions[selectedSection], let index = selectedTitles.firstIndex(of: title) {
                selectedTitles.remove(at: index)
                selectedOptions[selectedSection] = selectedTitles
            }
        } else {
            // Select the button
            sender.backgroundColor = UIColor(hex: "FBCBC4")
            sender.layer.borderColor = UIColor(hex: "FA8D7B")?.cgColor
            if var selectedTitles = selectedOptions[selectedSection] {
                selectedTitles.append(title)
                selectedOptions[selectedSection] = selectedTitles
            } else {
                selectedOptions[selectedSection] = [title]
            }
        }
        
        sender.layer.cornerRadius = sender.frame.height / 2
        sender.layer.masksToBounds = true
    }
    
    func setupAromaLabelConstraints() {
        aromaLabel.snp.makeConstraints { make in
            make.top.equalTo(tasteView.snp.top).offset(25)
            make.leading.equalTo(tasteView.snp.leading).offset(15)
        }

        let maxButtonsPerRow = 4
        let buttonSpacing: CGFloat = 10.0
        let buttonHeight: CGFloat = 33.0
        
        for j in 0..<tasteOptions[0].count {
            let option = tasteOptions[0][j]
            option.snp.makeConstraints { make in
                if j % maxButtonsPerRow == 0 {
                    if j == 0 {
                        make.top.equalTo(aromaLabel.snp.bottom).offset(10)
                    } else {
                        make.top.equalTo(tasteOptions[0][j - maxButtonsPerRow].snp.bottom).offset(buttonSpacing)
                    }
                    make.leading.equalTo(aromaLabel.snp.leading)
                } else {
                    make.leading.equalTo(tasteOptions[0][j - 1].snp.trailing).offset(buttonSpacing)
                    make.centerY.equalTo(tasteOptions[0][j - 1].snp.centerY)
                }
                make.height.equalTo(buttonHeight)
            }
        }
        
    }
    
    func setupTasteOptionsLabelConstraints() {
        tasteLabel.snp.makeConstraints { make in
            make.top.equalTo(tasteOptions[0][12].snp.bottom).offset(50)
            make.leading.equalTo(aromaLabel.snp.leading)
        }
        
        let maxButtonsPerRow = 4
        let buttonSpacing: CGFloat = 10.0
        let buttonHeight: CGFloat = 33.0
        
        for j in 0..<tasteOptions[1].count {
            let option = tasteOptions[1][j]
            option.snp.makeConstraints { make in
                if j % maxButtonsPerRow == 0 {
                    if j == 0 {
                        make.top.equalTo(tasteLabel.snp.bottom).offset(10)
                    } else {
                        make.top.equalTo(tasteOptions[1][j - maxButtonsPerRow].snp.bottom).offset(buttonSpacing)
                    }
                    make.leading.equalTo(tasteLabel.snp.leading)
                } else {
                    make.leading.equalTo(tasteOptions[1][j - 1].snp.trailing).offset(buttonSpacing)
                    make.centerY.equalTo(tasteOptions[1][j - 1].snp.centerY)
                }
                make.height.equalTo(buttonHeight)
            }
        }
    }
    
    func setupFinishOptionsLabelConstraints() {
        finishLabel.snp.makeConstraints { make in
            make.top.equalTo(tasteOptions[1][12].snp.bottom).offset(50)
            make.leading.equalTo(tasteLabel.snp.leading)
        }
        let maxButtonsPerRow = 4
        let buttonSpacing: CGFloat = 10.0
        let buttonHeight: CGFloat = 33.0
        
        for j in 0..<tasteOptions[2].count {
            let option = tasteOptions[2][j]
            option.snp.makeConstraints { make in
                if j % maxButtonsPerRow == 0 {
                    if j == 0 {
                        make.top.equalTo(finishLabel.snp.bottom).offset(10)
                    } else {
                        make.top.equalTo(tasteOptions[2][j - maxButtonsPerRow].snp.bottom).offset(buttonSpacing)
                    }
                    make.leading.equalTo(finishLabel.snp.leading)
                } else {
                    make.leading.equalTo(tasteOptions[2][j - 1].snp.trailing).offset(buttonSpacing)
                    make.centerY.equalTo(tasteOptions[2][j - 1].snp.centerY)
                }
                make.height.equalTo(buttonHeight)
            }
        }
    }
    
    func setupNextButton() {
        tasteView.addSubview(nextButton)
        nextButton.backgroundColor = UIColor(hex: "FA735B")
        nextButton.setTitle("다음", for: .normal)
        nextButton.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 20)
        nextButton.titleLabel?.textColor = .white
        nextButton.layer.cornerRadius = 16
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    @objc func nextButtonTapped() {
        let nextVC = RatingViewController()
        print(selectedOptions)
        nextVC.dataList = dataList
        nextVC.selectedOptions = selectedOptions
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func setupNextButtonConstraints() {
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(tasteOptions[2][14].snp.bottom).offset(49)
            make.leading.equalTo(tasteView.snp.leading).offset(17)
            make.centerX.equalTo(tasteView.snp.centerX)
            make.height.greaterThanOrEqualTo(60)
        }
    }
    
}
