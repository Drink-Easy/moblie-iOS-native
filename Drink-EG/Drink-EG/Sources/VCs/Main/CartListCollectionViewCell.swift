//
//  CartListCollectionViewCell.swift
//  Drink-EG
//
//  Created by 이현주 on 8/11/24.
//

import UIKit
import SnapKit

class CartListCollectionViewCell: UICollectionViewCell {
    
    var changeMarketButtonAction : (() -> Void) = {}
    
    private var quantity: Int = 0 {
        didSet {
            updateNumLabel()
        }
    }
    
    private let CheckImage = UIImage(named: "icon_cartCheck_fill")
    private let nCheckImage = UIImage(named: "icon_cartCheck_nfill")
    private let CheckButton = UIButton(type: .custom)
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Loxton")
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        return iv
    }()
    
    private let name: UILabel = {
        let l1 = UILabel()
        l1.text = "Loxton"
        l1.font = .boldSystemFont(ofSize: 18)
        l1.textColor = .black
        l1.numberOfLines = 0
        return l1
    }()
    
    private let marketNprice: UILabel = {
        let l2 = UILabel()
        
        let firstImageAttachment = NSTextAttachment()
        firstImageAttachment.image = UIImage(named: "icon_market")
        
        let firstImageOffsetY: CGFloat = -2.0 // 텍스트와 이미지의 정렬을 맞추기 위해 조정합니다.
        firstImageAttachment.bounds = CGRect(x: 0, y: firstImageOffsetY, width: 12, height: 12) // 이미지의 크기를 설정합니다.

        let secondImageAttachment = NSTextAttachment()
        secondImageAttachment.image = UIImage(named: "Vector")
                
        let secondImageOffsetY: CGFloat = -2.0 // 이미지와 텍스트의 정렬을 맞추기 위해 조정
        secondImageAttachment.bounds = CGRect(x: 0, y: secondImageOffsetY, width: 1, height: 12)

        let completeText = NSMutableAttributedString(string: "")
        
        // 첫 번째 이미지 추가
        let firstAttachmentString = NSAttributedString(attachment: firstImageAttachment)
        completeText.append(firstAttachmentString)

        // 매장 텍스트 추가
        let textBeforeSecondImage = NSAttributedString(string: " PODO  ", attributes: [.font: UIFont.systemFont(ofSize: 16)])
        completeText.append(textBeforeSecondImage)

        // 두 번째 이미지 추가
        let secondAttachmentString = NSAttributedString(attachment: secondImageAttachment)
        completeText.append(secondAttachmentString)

        // 가격 텍스트 추가
        let textAfterSecondImage = NSAttributedString(string: "  25,000 ₩", attributes: [.font: UIFont.systemFont(ofSize: 16)])
        completeText.append(textAfterSecondImage)

        l2.attributedText = completeText
        l2.font = .boldSystemFont(ofSize: 12)
        l2.textColor = UIColor(hex: "#767676")
        return l2
    }()
    
    private let score: UILabel = {
        let l3 = UILabel()
        l3.text = "4.5 ★"
        l3.font = .boldSystemFont(ofSize: 12)
        l3.textColor = UIColor(hex: "#FF7A6D")
        return l3
    }()
    
    private let changeMarketButton: UIButton = {
        let b = UIButton(type: .system)
        b.backgroundColor = UIColor(hex: "#FA735B")
        b.setTitle("매장변경", for: .normal)
        b.titleLabel?.font = .boldSystemFont(ofSize: 12)
        b.setTitleColor(.white, for: .normal)
        b.layer.cornerRadius = 13
        b.layer.masksToBounds = true
        b.addTarget(self, action: #selector(changeMarketButtonTapped), for: .touchUpInside)
        
        return b
    }()
    
    @objc private func changeMarketButtonTapped() {
        changeMarketButtonAction()
    }
    
    private let changeNumButton: UIButton = {
        let b = UIButton(type: .custom)
        b.backgroundColor = .clear
        b.setImage(UIImage(named: "ChangeNumButton")?.withRenderingMode(.alwaysOriginal), for: .normal)
        b.addTarget(self, action: #selector(changeNumButtonTapped), for: .touchUpInside)
        return b
    }()
    
    private let NumLabel: UILabel = {
        let l = UILabel()
        l.text = "1"
        l.font = UIFont.boldSystemFont(ofSize: 12)
        l.textAlignment = .center
        l.textColor = .black
        
        return l
    }()
    
    private func updateNumLabel() {
        let label = "\(quantity)"
        NumLabel.text = label
    }
        
    @objc func changeNumButtonTapped(_ sender: UIButton, forEvent event: UIEvent) {
        // 터치 이벤트를 가져옵니다.
        if let touch = event.allTouches?.first {
            let location = touch.location(in: sender)
            let buttonWidth = sender.bounds.width
                
            if location.x < buttonWidth * 0.3 {
                // 버튼의 왼쪽 30% 영역을 클릭한 경우
                decreaseQuantity()
            } else if location.x > buttonWidth * 0.7 {
                // 버튼의 오른쪽 30% 영역을 클릭한 경우
                increaseQuantity()
            }
        }
    }
        
    private func decreaseQuantity() {
        quantity = max(quantity - 1, 1)
    }

    private func increaseQuantity() {
        quantity += 1
    }
    
    private let deleteButton: UIButton = {
        let b = UIButton(type: .system)
        let symbolName = "xmark"  // 사용할 시스템 이미지 이름
        let configuration = UIImage.SymbolConfiguration(weight: .semibold)  // 굵기 설정
        let image = UIImage(systemName: symbolName, withConfiguration: configuration)
        b.setImage(image, for: .normal)
        b.tintColor = UIColor(hex: "999999")
        b.backgroundColor = .clear
        return b
    }()
    
    private func configureCheckButton() {
        CheckButton.setImage(nCheckImage?.withRenderingMode(.alwaysOriginal), for: .normal)
        CheckButton.backgroundColor = .clear
        CheckButton.addTarget(self, action: #selector(CheckButtonTapped), for: .touchUpInside)
    }
    
    @objc private func CheckButtonTapped(_ sender: UIButton) {
        // Bool 값 toggle
        sender.isSelected.toggle()
            
        // 버튼이 클릭될 때마다, 버튼 이미지를 변환
        if sender.isSelected {
            sender.setImage(CheckImage?.withRenderingMode(.alwaysOriginal), for: .selected)
            self.contentView.backgroundColor = UIColor(hex: "FFDCD9")
            self.contentView.layer.borderColor = UIColor(hue: 0.0111, saturation: 0.61, brightness: 1, alpha: 0.7).cgColor
        } else {
            sender.setImage(nCheckImage?.withRenderingMode(.alwaysOriginal), for: .normal)
            self.contentView.backgroundColor = UIColor(hex: "EDEDED")
            self.contentView.layer.borderColor = UIColor(hex: "D9D9D9")?.cgColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //레이아웃까지
    private func setupUI() {
        configureCheckButton()
        
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(name)
        self.contentView.addSubview(marketNprice)
        self.contentView.addSubview(score)
        self.contentView.addSubview(CheckButton)
        self.contentView.addSubview(changeMarketButton)
        self.contentView.addSubview(changeNumButton)
        changeNumButton.addSubview(NumLabel)
        self.contentView.addSubview(deleteButton)
        self.contentView.backgroundColor = UIColor(hex: "EDEDED")
        self.contentView.layer.borderWidth = 1.5
        self.contentView.layer.borderColor = UIColor(hex: "D9D9D9")?.cgColor
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.masksToBounds = true
  
        CheckButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17)
            make.leading.equalToSuperview().offset(14)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(17)
            make.leading.equalTo(CheckButton.snp.trailing).offset(8.6)
            make.width.equalTo(imageView.snp.height)
        }
        
        name.snp.makeConstraints { make in
            make.top.equalTo(imageView)
            make.leading.equalTo(imageView.snp.trailing).offset(15)
        }
        
        marketNprice.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom).offset(7)
            make.leading.equalTo(name)
        }
        
        score.snp.makeConstraints { make in
            make.centerY.equalTo(name)
            make.leading.equalTo(name.snp.trailing).offset(13)
        }
        
        changeMarketButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(14)
            make.leading.equalToSuperview().offset(213)
            make.width.greaterThanOrEqualTo(67)
            make.height.greaterThanOrEqualTo(24)
        }
        
        changeNumButton.snp.makeConstraints { make in
            make.top.equalTo(changeMarketButton)
            make.leading.equalTo(changeMarketButton.snp.trailing).offset(6)
            make.width.greaterThanOrEqualTo(63)
            make.height.greaterThanOrEqualTo(26)
        }
        
        NumLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(14)
            make.width.height.equalTo(15)
        }
    }
    
    func configure1(imageName: String) {
        if let image = UIImage(named: imageName) {
            self.name.text = imageName
            imageView.image = image
        }
    }
    func configure2(isSelected: Bool) {
        CheckButton.isSelected = isSelected
    }
}

