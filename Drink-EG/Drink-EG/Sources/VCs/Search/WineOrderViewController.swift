//
//  WineOrderViewController.swift
//  Drink-EG
//
//  Created by 김도연 on 7/21/24.
//

import UIKit
import SnapKit
import SDWebImage
import SwiftyToaster

class WineOrderViewController: UIViewController {
    
    let shoppingManager = ShoppingListManager.shared
    
    private var quantity: Int = 1 {
        didSet {
            updateNumLabel()
        }
    }
    
    var shop: String?
    var score = 4.5
    var wineName: String = ""
    var wineImage: String?
    var shopAddr : String?
    var distanceDouble : Double?
    var priceInt: Int?
    
    var wine : Wine?
    var curShop : ShopData?
    
    private let scoreLabel = UILabel()
    private let shopName = UILabel()
    
    private let label: UILabel = {
        let l = UILabel()
        l.text = "판매처"
        l.font = .systemFont(ofSize: 28, weight: UIFont.Weight(700))
        l.textColor = .black
        l.numberOfLines = 0
        return l
    }()
    
    private let stick: UIView = {
        let s = UIView()
        s.backgroundColor = UIColor(hex: "FA735B")
        s.layer.borderWidth = 0
        return s
    }()
    
    private let name: UILabel = {
        let l = UILabel()
        l.text = "Red Label"
        l.font = .boldSystemFont(ofSize: 20)
        l.textColor = .black
        l.numberOfLines = 2
        l.lineBreakMode = .byTruncatingTail // 생략 부호(...)가 꼬리에 위치하도록 설정
        return l
    }()
    
    private let image: UIImageView = {
        let i = UIImageView()
        i.image = UIImage(named: "Red Label")
        i.layer.cornerRadius = 10
        i.layer.masksToBounds = true
        i.layer.borderWidth = 1.5
        i.layer.borderColor = UIColor(hex: "#E5E5E5")?.cgColor
        return i
    }()
    
    private let infoView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(hex: "#EDEDED")
        v.layer.cornerRadius = 10
        v.layer.masksToBounds = true
        v.layer.borderWidth = 1.5
        v.layer.borderColor = UIColor(hex: "#D9D9D9")?.cgColor
        return v
    }()
    
    private let distance = UILabel()
    
    fileprivate func setDistanceText(_ textData : String) {
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: "icon_location")
        
        let imageOffsetY: CGFloat = -2.0 // 텍스트와 이미지의 정렬을 맞추기 위해 조정합니다.
        imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: 10, height: 14) // 이미지의 크기를 설정합니다.
        
        let completeText = NSMutableAttributedString(string: "")
        
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        completeText.append(attachmentString)
        
        // 매장 텍스트 추가
        let text = NSAttributedString(string: " \(textData) km", attributes: [.font: UIFont.boldSystemFont(ofSize: 12)])
        completeText.append(text)
        distance.attributedText = completeText
        distance.textColor = UIColor(hex: "#FF7A6D")
    }
    
    private let address: UILabel = {
        let l3 = UILabel()
        l3.text = "서울특별시 마포구 와우산로 94"
        l3.textColor = UIColor(hex: "#767676")
        l3.font = UIFont.boldSystemFont(ofSize: 14)
        return l3
    }()
    
    let price: UILabel = {
        let l4 = UILabel()
        l4.text = "25,000 ₩"
        l4.textColor = UIColor(hex: "#767676")
        l4.font = UIFont.boldSystemFont(ofSize: 12)
        return l4
    }()
    
    private let changeNumButton: UIButton = {
        let b = UIButton(type: .custom)
        b.backgroundColor = .clear
        b.setImage(UIImage(named: "ChangeNumButton")?.withRenderingMode(.alwaysOriginal), for: .normal)
        b.addTarget(self, action: #selector(changeNumButtonTapped), for: .touchUpInside)
        b.adjustsImageWhenHighlighted = false
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
    
    private let goToCartButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("장바구니 담기", for: .normal)
        b.setTitleColor(UIColor(hex: "#FA735B"), for: .normal)
        b.titleLabel?.font = .boldSystemFont(ofSize: 18)
        b.contentHorizontalAlignment = .center
        
        b.backgroundColor = .white
        b.layer.cornerRadius = 25
        b.layer.masksToBounds = true
        b.layer.borderWidth = 2
        b.layer.borderColor = UIColor(hex: "#FA735B")?.cgColor
        b.addTarget(self, action: #selector(goToCartButtonTapped), for: .touchUpInside)
        return b
    }()
    
    @objc private func goToCartButtonTapped() {
        let shoppingCartListVC = ShoppingCartListViewController()
        if let wineData = self.wine, let shopData = self.curShop {
            shoppingManager.addNewWine(UserWineData(wine: wineData, shop: shopData), quantity)
        }
        navigationController?.pushViewController(shoppingCartListVC, animated: true)
    }
    
    private let goToBuyButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("구매하기", for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.titleLabel?.font = .boldSystemFont(ofSize: 18)
        b.contentHorizontalAlignment = .center
        
        b.backgroundColor = UIColor(hex: "#FA735B")
        b.layer.cornerRadius = 25
        b.layer.masksToBounds = true
        b.addTarget(self, action: #selector(goToBuyButtonTapped), for: .touchUpInside)
        
        return b
    }()
    
    @objc private func goToBuyButtonTapped() {
        Toaster.shared.makeToast("구매 완료 !")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        view.backgroundColor = .white
        setupNavigationBarButton()
        setupUI()
        
        if let imageUrl = wineImage, let url = URL(string: imageUrl) {
            image.sd_setImage(with: url, placeholderImage: UIImage(named: "Loxton"))
        } else {
            image.image = UIImage(named: "Loxton")
        }
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

    private func setupUI() {
        configureWineName()
        configureShopInfo()
        configureShopName()
        
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(27)
        }
        
        view.addSubview(stick)
        stick.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(31)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(1.5)
        }
        
        view.addSubview(image)
        image.snp.makeConstraints { make in
            make.top.equalTo(stick).offset(21)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(17)
            make.width.lessThanOrEqualTo(80)
            make.height.equalTo(image.snp.width)
        }
        
        view.addSubview(name)
        name.snp.makeConstraints { make in
            make.top.equalTo(image.snp.top)
            make.leading.equalTo(image.snp.trailing).offset(13)
            make.trailing.equalTo(stick.snp.trailing).offset(-5)
            make.height.lessThanOrEqualTo(60)
//            make.width.lessThanOrEqualTo(250)
        }
        
//        view.addSubview(scoreLabel)
//        scoreLabel.snp.makeConstraints { make in
//            make.centerY.equalTo(name)
//            make.leading.equalTo(name.snp.trailing).offset(18)
//        }
        
        view.addSubview(infoView)
        infoView.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(18)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.greaterThanOrEqualTo(120)
        }
        
        infoView.addSubview(shopName)
        shopName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(17)
        }
        
        infoView.addSubview(distance)
        distance.snp.makeConstraints { make in
            make.centerY.equalTo(shopName)
            make.leading.equalTo(shopName.snp.trailing).offset(13)
        }
        
        infoView.addSubview(address)
        address.snp.makeConstraints { make in
            make.top.equalTo(shopName.snp.bottom).offset(13)
            make.leading.equalTo(shopName)
        }
        
        infoView.addSubview(price)
        price.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(13)
            make.trailing.equalToSuperview().inset(17)
        }
        
        view.addSubview(changeNumButton)
        changeNumButton.snp.makeConstraints { make in
            make.top.equalTo(infoView.snp.bottom).offset(16)
            make.trailing.equalTo(infoView.snp.trailing).inset(10)
        }
        
        changeNumButton.addSubview(NumLabel)
        NumLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        let stackView = UIStackView(arrangedSubviews: [goToCartButton, goToBuyButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 9
                
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(53)
            make.leading.trailing.equalTo(infoView)
            make.height.greaterThanOrEqualTo(50)
        }
        
        goToCartButton.snp.makeConstraints { make in
            make.width.equalTo(goToBuyButton)
        }
    }
    
//    private func configureScore() {
//        scoreLabel.text = "★ \(score)"
//        scoreLabel.font = .boldSystemFont(ofSize: 14)
//        scoreLabel.textColor = UIColor(hex: "#FA735B")
//    }
    
    private func configureShopName() {
        shopName.font = .boldSystemFont(ofSize: 18)
        shopName.textColor = .black
        shopName.numberOfLines = 0
    }
    
    private func configureShopInfo() {
        if let shopdata = curShop {
            shopName.text = shop
            address.text = shopAddr
            setDistanceText("\(shopdata.distanceToUser)")
            price.text = "\(shopdata.price) ₩"
        }
    }
    
    private func configureWineName() {
        name.text = self.wineName
    }
}
