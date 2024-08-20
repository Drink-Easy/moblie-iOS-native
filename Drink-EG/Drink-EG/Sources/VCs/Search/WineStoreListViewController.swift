//
//  WineStoreListViewController.swift
//  Drink-EG
//
//  Created by 김도연 on 7/21/24.
//

import SnapKit
import UIKit
import SDWebImage

protocol StoreListDelegate: AnyObject {
    func didSelectStore(_ store: ShopData)
}

class WineStoreListViewController: UIViewController {
    
    let customPickerButton = CustomPickerButton()
    let pickerView = UIPickerView()
    let toolbar = UIToolbar()
    let pickerData = ["낮은 가격순", "가까운 거리순"]
    
    weak var delegate: StoreListDelegate?
    var selectedShop: String?
    
    var curWine : Wine?
    
    var scoreDouble = 4.5
    var wineImage: String?
    
//    private var WineShopContents: [String] = ["PODO", "루바토 와인", "버건디", "와인나우", "보데가 와인"]
    var whineShopList : [ShopData] = [
        ShopData(name: "PODO", address: "서울특별시 마포구 와우산로 94", distanceToUser: 1.2, price: 27000),
        ShopData(name: "루바토 와인", address: "서울특별시 종로구 자하문로 6", distanceToUser: 3.2, price: 30000),
        ShopData(name: "버건디", address: "서울특별시 동대문구 장안로 31", distanceToUser: 10.3, price: 28400),
        ShopData(name: "와인나우", address: "서울특별시 송파구 잠실대로 25", distanceToUser: 5.3, price: 74280),
        ShopData(name: "보데가 와인", address: "서울특별시 영등포구 국제금융로 16", distanceToUser: 4.2, price: 91500)
    ]
    
    private let label: UILabel = {
        let l = UILabel()
        l.text = "근처 판매처"
        l.font = .systemFont(ofSize: 28, weight: UIFont.Weight(700))
        l.textColor = .black
        l.numberOfLines = 0
        return l
    }()
    
    private let wineInfo: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(hex: "FFDCD9")
        v.layer.cornerRadius = 10
        v.layer.borderWidth = 1.5
        v.layer.borderColor = UIColor(hue: 0.025, saturation: 0.63, brightness: 0.98, alpha: 0.7).cgColor
        return v
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let name: UILabel = {
        let l1 = UILabel()
        l1.text = "Loxton"
        l1.font = .boldSystemFont(ofSize: 18)
        l1.textColor = .black
        l1.numberOfLines = 2
        l1.lineBreakMode = .byTruncatingTail // 생략 부호(...)가 꼬리에 위치하도록 설정
        return l1
    }()
    
    lazy var score: UILabel = {
        let l3 = UILabel()
        l3.text = "★ \(scoreDouble)"
        l3.font = .boldSystemFont(ofSize: 12)
        l3.textColor = UIColor(hex: "#FF7A6D")
        return l3
    }()
    
    lazy var wineShopListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(WineShopListCollectionViewCell.self, forCellWithReuseIdentifier: "WineShopListCollectionViewCell")
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        
        cv.decelerationRate = .fast
        cv.backgroundColor = .clear
        cv.layer.cornerRadius = 10
        
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor = .black
        // 네비게이션 바 설정
//        if let navigationBar = navigationController?.navigationBar {
//            navigationBar.isTranslucent = false
//            navigationBar.shadowImage = UIImage() // 하단에 생기는 경계선을 없앰
//            navigationBar.setBackgroundImage(UIImage(), for: .default) // 배경 이미지를 투명하게 설정
//            navigationBar.barTintColor = .white // 필요 시 배경 색을 흰색으로 설정
//        }
        
        view.backgroundColor = .white
        setupUI()
        
        if let imageUrl = wineImage, let url = URL(string: imageUrl) {
            imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "Loxton"))
        } else {
            imageView.image = UIImage(named: "Loxton")
        }
    }
    
    private func setupUI() {
            view.addSubview(label)
            label.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
                make.leading.equalTo(view.safeAreaLayoutGuide).offset(27)
            }
            
            view.addSubview(wineInfo)
            wineInfo.snp.makeConstraints { make in
                make.top.equalTo(label.snp.bottom).offset(26)
                make.trailing.leading.equalToSuperview().inset(16)
                make.height.lessThanOrEqualTo(120)
            }
            
            wineInfo.addSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview().inset(20)
                make.leading.equalToSuperview().offset(12)
                make.width.equalTo(imageView.snp.height)
            }
        
            wineInfo.addSubview(score)
            score.snp.makeConstraints { make in
                make.top.equalTo(imageView.snp.top)
                make.trailing.equalToSuperview().inset(15)
            }
        
            wineInfo.addSubview(name)
            name.snp.makeConstraints { make in
                make.top.equalTo(imageView.snp.top)
                make.leading.equalTo(imageView.snp.trailing).offset(13)
                make.trailing.equalTo(score.snp.leading).offset(-10)
//                make.width.lessThanOrEqualTo(205)
                make.height.lessThanOrEqualTo(55)
            }
            
            customPickerButton.setupPickerView(pickerView, toolbar: toolbar, pickerData: pickerData)
            view.addSubview(customPickerButton)
            
            customPickerButton.snp.makeConstraints { make in
                make.top.equalTo(wineInfo.snp.bottom).offset(44)
                make.trailing.equalTo(wineInfo.snp.trailing)
                make.width.equalTo(customPickerButton.buttonWidth)
                make.height.equalTo(customPickerButton.pickerButtonHeight)
            }
            
            // Setup Picker View
            view.addSubview(pickerView)
            
            pickerView.snp.makeConstraints { make in
                make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
                make.height.equalTo(200) // 높이 설정
            }
            
            // Setup Toolbar
            view.addSubview(toolbar)
            
            toolbar.snp.makeConstraints { make in
                make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
                make.bottom.equalTo(pickerView.snp.top)
                make.height.equalTo(44) // 높이 설정
            }
            
            view.addSubview(wineShopListCollectionView)
            wineShopListCollectionView.snp.makeConstraints { make in
                make.top.equalTo(customPickerButton.snp.bottom).offset(10)
                make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(15)
                make.bottom.equalTo(view.safeAreaLayoutGuide).inset(15)
            }
            
            view.sendSubviewToBack(wineShopListCollectionView)
        }
}

extension WineStoreListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return whineShopList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WineShopListCollectionViewCell", for: indexPath) as! WineShopListCollectionViewCell
        
        cell.configure(shop: whineShopList[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let previousViewController = navigationController?.viewControllers.dropLast().last {
            if previousViewController is WineInfoViewController {
                let selectedCell = collectionView.cellForItem(at: indexPath) as! WineShopListCollectionViewCell
                let data = whineShopList[indexPath.row]
                let wineOrderViewController = WineOrderViewController()
                
                wineOrderViewController.wine = curWine
                wineOrderViewController.curShop = data
                
                wineOrderViewController.wineImage = self.wineImage ?? ""
                
                // TODO : 삭제 가능한 데이터들
                wineOrderViewController.shop = data.name
                wineOrderViewController.shopAddr = data.address
                wineOrderViewController.distanceDouble = data.distanceToUser
                wineOrderViewController.priceInt = data.price
                wineOrderViewController.wineName = self.name.text ?? "값없음"
                wineOrderViewController.score = self.scoreDouble
                
                navigationController?.pushViewController(wineOrderViewController, animated: true)
            } else if previousViewController is ShoppingCartListViewController {
                let selectedShop = whineShopList[indexPath.row]
                delegate?.didSelectStore(selectedShop)
                navigationController?.popViewController(animated: true) // 장바구니 화면으로 돌아가기
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 120)
    }
}
