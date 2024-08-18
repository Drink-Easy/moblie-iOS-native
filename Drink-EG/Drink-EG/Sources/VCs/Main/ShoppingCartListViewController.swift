//
//  ShoppingCartListViewController.swift
//  Drink-EG
//
//  Created by 김도연 on 7/20/24.
//

import UIKit
import SnapKit

protocol StoreListDelegate: AnyObject {
    func didSelectStore(_ store: String)
}

class ShoppingCartListViewController: UIViewController, CartListCollectionViewCellDelegate {

    var selectedStore: String?
    let shoppingListManager = ShoppingListManager.shared
    
    private var CartContents: [ShoppingObject] = []
    private var itemsSelectedState: [Bool] = []
    
    private var totalSum : Int = 0
    var currentCheckCellCount : Int = 0
    
    private let allCheckImage = UIImage(named: "icon_cartCheck_fill")
    private let nAllCheckImage = UIImage(named: "icon_cartCheck_nfill")
    private let allCheckButton = UIButton(type: .custom)
    private let allCheckLabel = UILabel()
    
    private let label: UILabel = {
        let l = UILabel()
        l.text = "장바구니"
        l.font = .systemFont(ofSize: 28, weight: UIFont.Weight(700))
        l.textColor = .black
        l.numberOfLines = 0
        return l
    }()
    
    private let checkDeleteButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("선택 삭제", for: .normal)
        b.setTitleColor(UIColor(hex: "#767676"), for: .normal)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        b.backgroundColor = .clear
        return b
    }()
    
    lazy var buyButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("\(totalSum)원 구매하기", for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        b.contentHorizontalAlignment = .center
        b.layer.cornerRadius = 10
        b.layer.borderWidth = 0
        b.backgroundColor = UIColor(hue: 0.025, saturation: 0.79, brightness: 0.98, alpha: 0.8)
        return b
    }()
    
    
    lazy var cartListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(CartListCollectionViewCell.self, forCellWithReuseIdentifier: "CartListCollectionViewCell")
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        
        cv.decelerationRate = .fast
        cv.backgroundColor = .clear
        cv.layer.cornerRadius = 10
        
        return cv
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        CartContents = shoppingListManager.myCartWines
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor = .black
        
        CartContents = shoppingListManager.myCartWines
        
        view.backgroundColor = .white
        itemsSelectedState = Array(repeating: false, count: 20)
        setupUI()
        DispatchQueue.main.async {
            self.cartListCollectionView.reloadData()
        }
    }
    
    func didSelectStore(_ store: String) {
        self.selectedStore = store
        updateStoreInCart()
    }
    
    func updateStoreInCart() {
        // 여기서 장바구니 셀의 매장 이름을 변경하는 코드를 작성합니다.
        cartListCollectionView.reloadData()
    }
    
    private func setupUI() {
        
        configureAllCheckButton()
        configureAllCheckLabel()
        
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(27)
        }
        
        view.addSubview(allCheckButton)
        allCheckButton.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(20)
            make.leading.equalTo(label)
        }
        
        view.addSubview(allCheckLabel)
        allCheckLabel.snp.makeConstraints { make in
            make.centerY.equalTo(allCheckButton)
            make.leading.equalTo(allCheckButton.snp.trailing).offset(6)
        }
        
        view.addSubview(checkDeleteButton)
        checkDeleteButton.snp.makeConstraints { make in
            make.centerY.equalTo(allCheckLabel)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        view.addSubview(buyButton)
        buyButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.greaterThanOrEqualTo(60)
        }
        
        view.addSubview(cartListCollectionView)
        cartListCollectionView.snp.makeConstraints { make in
            make.top.equalTo(allCheckLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(buyButton.snp.top).offset(-20)
        }
    }
    
    private func configureAllCheckButton() {
        allCheckButton.setImage(nAllCheckImage?.withRenderingMode(.alwaysOriginal), for: .normal)
        allCheckButton.backgroundColor = .clear
        allCheckButton.addTarget(self, action: #selector(allCheckButtonTapped), for: .touchUpInside)
    }
    
    fileprivate func getIndexPathAllCells() -> [IndexPath] {
        var allIndexPaths: [IndexPath] = []
        
        let sections = cartListCollectionView.numberOfSections
        for section in 0..<sections {
            let items = cartListCollectionView.numberOfItems(inSection: section)
            for item in 0..<items {
                let indexPath = IndexPath(item: item, section: section)
                allIndexPaths.append(indexPath)
            }
        }
        return allIndexPaths
    }
    
    @objc private func allCheckButtonTapped(_ sender: UIButton) {
        // Bool 값 toggle
        sender.isSelected.toggle()
        
        // 버튼이 클릭될 때마다, 버튼 이미지를 변환
        if sender.isSelected {
            sender.setImage(allCheckImage?.withRenderingMode(.alwaysOriginal), for: .selected)
            currentCheckCellCount = CartContents.count
            for indexPath in getIndexPathAllCells() {
                if let cell = cartListCollectionView.cellForItem(at: indexPath) as? CartListCollectionViewCell {
                    cell.CheckButton.isSelected = false
                    cell.CheckButtonTapped(cell.CheckButton) // 직접 호출하여 셀의 선택 상태를 변경
                    totalSum += cell.price * cell.quantity
                }
            }
        } else {
            sender.setImage(nAllCheckImage?.withRenderingMode(.alwaysOriginal), for: .normal)
            currentCheckCellCount = 0
            totalSum = 0  // totalSum 초기화
            for indexPath in getIndexPathAllCells() {
                if let cell = cartListCollectionView.cellForItem(at: indexPath) as? CartListCollectionViewCell {
                    cell.CheckButton.isSelected = true
                    cell.CheckButtonTapped(cell.CheckButton) // 직접 호출하여 셀의 선택 상태를 변경
                }
            }
        }
        
        buyButton.setTitle("\(totalSum)원 구매하기", for: .normal)
        
        // 전체 선택 상태를 업데이트하고 라벨을 갱신
        configureAllCheckLabel()
        
        // 모든 셀의 configure2를 호출하여 선택 상태 업데이트
        cartListCollectionView.reloadData()
    }
    
//    @objc private func allCheckButtonTapped(_ sender: UIButton) {
//        // Bool 값 toggle
//        let isSelectingAll = !sender.isSelected
//        sender.isSelected = isSelectingAll
//        
//        // 버튼이 클릭될 때마다, 버튼 이미지를 변환
//        let newImage = isSelectingAll ? allCheckImage?.withRenderingMode(.alwaysOriginal) : nAllCheckImage?.withRenderingMode(.alwaysOriginal)
//        sender.setImage(newImage, for: .normal)
//        
//        // 모든 셀에 대해 체크 상태 업데이트
//        currentCheckCellCount = isSelectingAll ? CartContents.count : 0
//        totalSum = 0  // totalSum 초기화
//        for indexPath in getIndexPathAllCells() {
//            if let cell = cartListCollectionView.cellForItem(at: indexPath) as? CartListCollectionViewCell {
//                if cell.CheckButton.isSelected != isSelectingAll {
//                    cell.CheckButton.isSelected = isSelectingAll
//                    cell.CheckButtonTapped(cell.CheckButton) // 직접 호출하여 셀의 선택 상태를 변경
//                }
//                if isSelectingAll {
//                    totalSum += cell.price * cell.quantity  // 전체 선택 시 모든 셀의 가격을 더합니다.
//                }
//            }
//        }
//        
//        // totalSum을 표시할 UI 업데이트 (예: 구매 버튼의 타이틀)
//        buyButton.setTitle("\(totalSum)원 구매하기", for: .normal)
//        
//        // 전체 선택 상태를 업데이트하고 라벨을 갱신
//        configureAllCheckLabel()
//        cartListCollectionView.reloadData()
//    }

    
    func configureAllCheckLabel() {
        allCheckLabel.text = "전체 선택 (\(currentCheckCellCount)/\(CartContents.count))"
        allCheckLabel.font = .boldSystemFont(ofSize: 14)
        allCheckLabel.textColor = UIColor(hex: "#767676")
    }
    
    func checkButtonTapped(on cell: CartListCollectionViewCell, isSelected: Bool) {
        if isSelected {
            if currentCheckCellCount < CartContents.count {
                currentCheckCellCount += 1
                totalSum += cell.price * cell.quantity
            }
        } else {
            if currentCheckCellCount != 0 {
                currentCheckCellCount -= 1
                totalSum -= cell.price * cell.quantity
            }
        }
        configureAllCheckLabel()
        buyButton.setTitle("\(totalSum)원 구매하기", for: .normal)
        
        // 현재 선택된 셀의 개수가 전체 셀의 개수와 같으면 전체 선택 버튼 이미지를 선택 상태로 변경
        if currentCheckCellCount == CartContents.count {
            allCheckButton.setImage(allCheckImage?.withRenderingMode(.alwaysOriginal), for: .selected)
            allCheckButton.isSelected = true
        } else {
            allCheckButton.setImage(nAllCheckImage?.withRenderingMode(.alwaysOriginal), for: .normal)
            allCheckButton.isSelected = false
        }
    }
}

extension ShoppingCartListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CartContents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CartListCollectionViewCell", for: indexPath) as! CartListCollectionViewCell
        cell.delegate = self // 델리게이트 설정
        
        cell.changeMarketButtonAction = {
            let wineStoreListViewController = WineStoreListViewController()
            self.navigationController?.pushViewController(wineStoreListViewController, animated: true)
        }
        
        let data = CartContents[indexPath.row]
        let wineName = data.wineData.wine.name
        let shopName = data.wineData.shop.name
        let price = data.wineData.shop.price
        let count = data.count
        
        cell.configure1(imageName: wineName, wineName: wineName, price: price, count: count, shopName: shopName)
//        cell.configure2(isSelected: itemsSelectedState[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 120)
    }
}
