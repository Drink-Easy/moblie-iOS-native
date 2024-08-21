//
//  ChooseTasteViewController.swift
//  Drink-EG
//
//  Created by 이수현 on 8/3/24.
//

import Foundation
import UIKit
import SnapKit

class ChooseTasteViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let colorView = UIView()
    let colorBox = UIView()
    let colorLabel = UILabel()
    let tasteView = UIView()
    let tasteOptionsTitle = ["레드베리", "체리", "자두", "딸기", "우디", "바닐라", "아카시아", "흙", "민트", "시가", "훈제", "너트", "자몽", "라임", "가죽", "직접추가"]
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
    
    var dataList: [RadarChartData] = []
    var receivedColor = ""
    var selectedWineId: Int?
    var selectedWineImage: String?
    var selectedWineName: String?
    var selectedWineArea: String?
    var selectedWineSort: String?
    
    var aromaCollectionView: UICollectionView!
    var tasteCollectionView: UICollectionView!
    var finishCollectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
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
        setupAromaLabel()
        setuparomaCollectionView()
        setupTasteLabel()
        setupTasteCollectionView()
        setupFinsihLabel()
        setupFinishCollectionView()
        setupNextButton()
        setupNextButtonConstraints()
    }
    
    func setuparomaCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 92, height: 33)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        aromaCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        aromaCollectionView.backgroundColor = .clear
        aromaCollectionView.delegate = self
        aromaCollectionView.dataSource = self
        aromaCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "AromaOptionCell")
        
        tasteView.addSubview(aromaCollectionView)
        aromaCollectionView.snp.makeConstraints { make in
            make.top.equalTo(aromaLabel.snp.bottom).offset(9)
            make.leading.trailing.equalTo(tasteView).inset(16)
            // make.height.equalTo(tasteView.snp.height).multipliedBy(0.22)
            make.height.greaterThanOrEqualTo(230)
        }
        
    }
    
    func setupTasteCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 92, height: 33)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        tasteCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        tasteCollectionView.backgroundColor = .clear
        tasteCollectionView.delegate = self
        tasteCollectionView.dataSource = self
        tasteCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "TasteOptionCell")
        
        tasteView.addSubview(tasteCollectionView)
        tasteCollectionView.snp.makeConstraints { make in
            make.top.equalTo(tasteLabel.snp.bottom).offset(9)
            make.leading.trailing.equalTo(tasteView).inset(16)
            make.height.greaterThanOrEqualTo(230)
        }
    }
    
    func setupFinishCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 92, height: 33)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        finishCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        finishCollectionView.backgroundColor = .clear
        finishCollectionView.delegate = self
        finishCollectionView.dataSource = self
        finishCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "FinishOptionCell")
        
        tasteView.addSubview(finishCollectionView)
        finishCollectionView.snp.makeConstraints { make in
            make.top.equalTo(finishLabel.snp.bottom).offset(9)
            make.leading.trailing.equalTo(tasteView).inset(16)
            make.height.greaterThanOrEqualTo(230)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasteOptionsTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseIdentifier: String
        let sectionKey: String
        
        if collectionView == aromaCollectionView {
            reuseIdentifier = "AromaOptionCell"
            sectionKey = "scentAroma"
        } else if collectionView == tasteCollectionView {
            reuseIdentifier = "TasteOptionCell"
            sectionKey = "scentTaste"
        } else {
            reuseIdentifier = "FinishOptionCell"
            sectionKey = "scentFinish"
        }
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        let buttonTitle = tasteOptionsTitle[indexPath.row]
        
        let font = UIFont(name: "Pretendard-SemiBold", size: 16) ?? UIFont.systemFont(ofSize: 16)
        var attributedTitle = AttributedString(buttonTitle)
        attributedTitle.font = font
        
        var config = UIButton.Configuration.plain()
        config.attributedTitle = attributedTitle
        config.title = buttonTitle
        config.baseForegroundColor = .black
        config.background.strokeColor = UIColor(red: 0.765, green: 0.765, blue: 0.765, alpha: 1)
        config.background.strokeWidth = 2
        config.background.cornerRadius = 100
        
       
        
        let button = UIButton(configuration: config)
        button.frame = cell.contentView.bounds
        button.layer.cornerRadius = button.frame.height / 2
        button.layer.masksToBounds = true
        
        if buttonTitle == "직접추가" {
            button.backgroundColor = UIColor(hex: "D9D9D9")
        } else {
            button.backgroundColor = .clear
        }
        
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        button.tag = indexPath.row
        button.accessibilityLabel = sectionKey
        cell.contentView.addSubview(button)
        return cell
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        guard let sectionKey = sender.accessibilityLabel else { return }
        let buttonTitle = tasteOptionsTitle[sender.tag]
        
        if sender.backgroundColor == UIColor(hex: "FBCBC4") {
            if buttonTitle == "직접추가" {
                sender.backgroundColor = UIColor(hex: "D9D9D9")
            } else {
                sender.backgroundColor = .clear
            }
            sender.layer.borderColor = UIColor(red: 0.765, green: 0.765, blue: 0.765, alpha: 1).cgColor
            selectedOptions[sectionKey]?.removeAll(where: { $0 == buttonTitle })
        } else {
            sender.backgroundColor = UIColor(hex: "FBCBC4")
            sender.layer.borderColor = UIColor(hex: "FA8D7B")?.cgColor
            selectedOptions[sectionKey, default: []].append(buttonTitle)
        }
        
        sender.layer.cornerRadius = sender.frame.height / 2
        sender.layer.masksToBounds = true
    }
    
    func setupNavigationBarButton() {
        navigationItem.hidesBackButton = false
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
            make.height.equalTo(1500)
        }
    }
    
    func setupLabel() { // Label의 기본 속성을 설정하는 함수
        contentView.addSubview(tastingnoteLabel)
        tastingnoteLabel.text = "테이스팅 노트"
        tastingnoteLabel.font = .systemFont(ofSize: UIConstants.labelFontSize, weight: UIFont.Weight(rawValue: 700))
        tastingnoteLabel.textAlignment = .center
        tastingnoteLabel.textColor = .black
    }
    
    func setuptastingnoteLabelConstraints() { // Label의 제약 조건을 설정하는 함수
        tastingnoteLabel.snp.makeConstraints{ make in
            make.top.equalTo(contentView.snp.top).offset(20)
            make.leading.equalTo(contentView.snp.leading).offset(27)
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
            make.centerY.equalTo(wineView.snp.centerY)
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
        tasteView.layer.borderColor = UIColor(hex: "0000001A")?.cgColor
        tasteView.layer.cornerRadius = 10
    }

    func setupTasteViewConstraints() {
        tasteView.snp.makeConstraints{ make in
            make.top.equalTo(colorView.snp.bottom).offset(13)
            make.centerX.equalTo(colorView.snp.centerX)
            make.leading.equalTo(colorView.snp.leading)
            make.bottom.equalTo(contentView.snp.bottom).offset(-50)
        }
    }
    
    func setupAromaLabel() {
        tasteView.addSubview(aromaLabel)
        aromaLabel.text = "Aroma"
        aromaLabel.textAlignment = .center
        aromaLabel.textColor = .black
        aromaLabel.font = UIFont(name: "Pretend-SemiBold", size: 20)
        
        aromaLabel.snp.makeConstraints { make in
            make.top.equalTo(tasteView.snp.top).offset(25)
            make.leading.equalTo(tasteView.snp.leading).offset(15)
        }
    }
    
    func setupTasteLabel() {
        tasteView.addSubview(tasteLabel)
        tasteLabel.text = "Taste"
        tasteLabel.textAlignment = .center
        tasteLabel.textColor = .black
        tasteLabel.font = UIFont(name: "Pretend-SemiBold", size: 20)
        
        tasteLabel.snp.makeConstraints { make in
            make.top.equalTo(aromaCollectionView.snp.bottom).offset(50)
            make.leading.equalTo(aromaLabel.snp.leading)
        }
    }
    
    func setupFinsihLabel() {
        tasteView.addSubview(finishLabel)
        finishLabel.text = "Finish"
        finishLabel.textAlignment = .center
        finishLabel.textColor = .black
        finishLabel.font = UIFont(name: "Pretend-SemiBold", size: 20)
        
        finishLabel.snp.makeConstraints { make in
            make.top.equalTo(tasteCollectionView.snp.bottom).offset(50)
            make.leading.equalTo(tasteLabel.snp.leading)
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
        nextVC.receivedColor = receivedColor
        nextVC.selectedWineId = selectedWineId
        nextVC.selectedWineName = selectedWineName
        nextVC.selectedWineImage = selectedWineImage
        nextVC.selectedWineArea = selectedWineArea
        nextVC.selectedWineSort = selectedWineSort
        
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func setupNextButtonConstraints() {
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(finishCollectionView.snp.bottom).offset(49)
            make.leading.equalTo(tasteView.snp.leading).offset(17)
            make.centerX.equalTo(tasteView.snp.centerX)
            make.height.equalTo(60)
            
        }
    }
    
}
