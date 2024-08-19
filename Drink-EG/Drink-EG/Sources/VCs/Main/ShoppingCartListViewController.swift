//
//  ShoppingCartListViewController.swift
//  Drink-EG
//
//  Created by 김도연 on 7/20/24.
//

import UIKit
import SnapKit

class ShoppingCartListViewController: UIViewController, CartListCollectionViewCellDelegate, StoreListDelegate {

    var selectedStore: String?
    let shoppingListManager = ShoppingListManager.shared
    
    private var CartContents: [ShoppingObject] = []
    
    // selectedCell을 인스턴스 변수로 선언하여 매장 변경을 선택한 셀을 추적합니다.
    private var selectedCell: CartListCollectionViewCell?
    
    private var totalSum: Int = 0 {
        didSet {
            if totalSum < 0 {
                totalSum = 0
            }
        }
    }
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
        b.addTarget(self, action: #selector(checkDeleteButtonTapped(_:)), for: .touchUpInside)
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
        if shoppingListManager.myCartWines.isEmpty {
            showNoWineLabel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor = .black
        
        CartContents = shoppingListManager.myCartWines
        
        view.backgroundColor = .white
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
    
    private func showNoWineLabel() {
        let noWine = UILabel()
        noWine.text = "장바구니에 담은 상품이 없습니다."
        noWine.font = .boldSystemFont(ofSize: 15)
        noWine.textColor = UIColor(hex: "#767676")
        
        self.cartListCollectionView.addSubview(noWine)
        noWine.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
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
    
    @objc private func checkDeleteButtonTapped(_ sender: UIButton) {
        // 선택된 셀의 인덱스 경로를 저장할 배열을 초기화합니다.
        var indexPathsToDelete: [IndexPath] = []

        // 전체 셀을 반복하면서 선택된 셀의 인덱스 경로를 수집합니다.
        for indexPath in getIndexPathAllCells() {
            if let cell = cartListCollectionView.cellForItem(at: indexPath) as? CartListCollectionViewCell {
                if cell.CheckButton.isSelected {
                    // 선택된 셀의 인덱스 경로를 배열에 추가합니다.
                    indexPathsToDelete.append(indexPath)
                    // 총 합계와 선택된 셀 개수를 업데이트합니다.
                    currentCheckCellCount -= 1
                    totalSum -= cell.price * cell.quantity
                }
            }
        }

        // 인덱스 경로 배열을 역순으로 정렬하여 삭제 작업을 수행합니다.
        let sortedIndexPathsToDelete = indexPathsToDelete.sorted { $0.item > $1.item }
        
        // 선택된 셀들만 삭제합니다.
        for indexPath in sortedIndexPathsToDelete {
            let item = CartContents[indexPath.row]
            CartContents.remove(at: indexPath.row)
            shoppingListManager.deleteWine(item)
        }

        // 컬렉션 뷰의 삭제 애니메이션을 수행합니다.
        cartListCollectionView.performBatchUpdates({
            cartListCollectionView.deleteItems(at: sortedIndexPathsToDelete)
        }, completion: { _ in
            // UI 업데이트
            self.buyButton.setTitle("\(self.totalSum)원 구매하기", for: .normal)
            self.configureAllCheckLabel()
            
            // 전체 선택 버튼의 상태를 업데이트합니다.
            if self.currentCheckCellCount == self.CartContents.count && self.CartContents.isEmpty == false {
                self.allCheckButton.setImage(self.allCheckImage?.withRenderingMode(.alwaysOriginal), for: .selected)
                self.allCheckButton.isSelected = true
            } else {
                self.allCheckButton.setImage(self.nAllCheckImage?.withRenderingMode(.alwaysOriginal), for: .normal)
                self.allCheckButton.isSelected = false
            }
        })
        
        if self.shoppingListManager.myCartWines.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.showNoWineLabel()
            }
        }
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

    
    func configureAllCheckLabel() {
        allCheckLabel.text = "전체 선택 (\(currentCheckCellCount)/\(CartContents.count))"
        allCheckLabel.font = .boldSystemFont(ofSize: 14)
        allCheckLabel.textColor = UIColor(hex: "#767676")
    }
    
    func didTapChangeStoreButton(on cell: CartListCollectionViewCell) {
        let wineShopListVC = WineStoreListViewController()
        wineShopListVC.delegate = self
        navigationController?.pushViewController(wineShopListVC, animated: true)
        
        // 선택된 셀을 추적하여 나중에 업데이트할 수 있도록 저장
        selectedCell = cell
    }
    
    func didSelectStore(_ store: ShopData) {
        guard let selectedCell = selectedCell, let indexPath = cartListCollectionView.indexPath(for: selectedCell) else { return }
        
        // 현재 셀의 아이템을 가져옵니다.
        var item = CartContents[indexPath.row]
        
        // 선택된 셀의 매장 이름과 가격을 업데이트합니다.
        selectedCell.shop = store.name
        selectedCell.price = store.price
        
        // 셀의 UI를 업데이트합니다.
        selectedCell.configureMarketNPlace(store.name, store.price, selectedCell.quantity)
        
        // 장바구니 데이터를 업데이트합니다.
        if let wineName = selectedCell.name.text, let index = shoppingListManager.isExistingWineInList(wineName) {
            let shoppingObject = shoppingListManager.myCartWines[index]
            let updatedShoppingObject = ShoppingObject(wineData: UserWineData(wine: shoppingObject.wineData.wine, shop: store))
            shoppingListManager.updatePlace(updatedShoppingObject)
        }
        
        // CartContents 배열의 항목을 업데이트합니다.
        item.wineData.shop = store
        CartContents[indexPath.row] = item
        
        // 총 합계 재계산
        totalSum = 0
        
        // 모든 인덱스 경로를 가져옵니다.
            for section in 0..<cartListCollectionView.numberOfSections {
                for item in 0..<cartListCollectionView.numberOfItems(inSection: section) {
                    let indexPath = IndexPath(item: item, section: section)
                    if let cell = cartListCollectionView.cellForItem(at: indexPath) as? CartListCollectionViewCell {
                        // 셀의 체크 상태 확인
                        if cell.CheckButton.isSelected {
                            let price = cell.price
                            let quantity = cell.quantity
                            totalSum += price * quantity
                        }
                    }
                }
            }
        
        // UI 업데이트
        buyButton.setTitle("\(totalSum)원 구매하기", for: .normal)
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
    
    func deleteButtonTapped(on cell: CartListCollectionViewCell) {
        guard let indexPath = cartListCollectionView.indexPath(for: cell) else { return }
        
        // 셀의 체크 상태를 확인하고 totalSum과 currentCheckCellCount를 업데이트합니다.
        if cell.CheckButton.isSelected {
            currentCheckCellCount -= 1
            totalSum -= cell.price * cell.quantity
            buyButton.setTitle("\(totalSum)원 구매하기", for: .normal)
        }
        
        // `ShoppingListManager`를 통해 삭제할 아이템을 가져옵니다.
        let wineToDelete = CartContents[indexPath.row]
        
        // 로컬 데이터 모델에서 해당 항목을 삭제합니다.
        CartContents.remove(at: indexPath.row)
        
        // `ShoppingListManager`를 통해 삭제합니다.
        shoppingListManager.deleteWine(wineToDelete)
        
        // 컬렉션 뷰 업데이트를 수행합니다.
        cartListCollectionView.performBatchUpdates({
            cartListCollectionView.deleteItems(at: [indexPath])
        }, completion: { _ in
            self.configureAllCheckLabel()
            
            // 전체 선택 버튼의 상태를 업데이트합니다.
            if self.currentCheckCellCount == self.CartContents.count && self.CartContents.isEmpty == false {
                self.allCheckButton.setImage(self.allCheckImage?.withRenderingMode(.alwaysOriginal), for: .selected)
                self.allCheckButton.isSelected = true
            } else {
                self.allCheckButton.setImage(self.nAllCheckImage?.withRenderingMode(.alwaysOriginal), for: .normal)
                self.allCheckButton.isSelected = false
            }
        })
        
        if self.shoppingListManager.myCartWines.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.showNoWineLabel()
            }
        }
    }
    
    func quantityChanged(in cell: CartListCollectionViewCell) {
        // 셀의 인덱스 경로를 찾습니다.
        guard let indexPath = cartListCollectionView.indexPath(for: cell) else { return }
        
        // 현재 셀의 아이템을 가져옵니다.
        let item = CartContents[indexPath.row]
        
        // 수량이 변경되기 전의 기존 수량을 가져옵니다.
        let previousQuantity = cell.previousQuantity
        let updatedQuantity = cell.quantity
        let price = item.wineData.shop.price
        
        // 체크 버튼 상태에 따라 `totalSum`을 업데이트합니다.
        if cell.CheckButton.isSelected {
            
            // 기존 수량에 따른 가격을 총 합계에서 제거합니다.
            totalSum -= previousQuantity * price
            
            // 새로운 수량과 가격을 반영하여 총 합계를 업데이트합니다.
            totalSum += updatedQuantity * price
        }
        
        item.count = updatedQuantity
        CartContents[indexPath.row] = item
        
        // UI 업데이트
        buyButton.setTitle("\(totalSum)원 구매하기", for: .normal)
    }

}

extension ShoppingCartListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CartContents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CartListCollectionViewCell", for: indexPath) as! CartListCollectionViewCell
        cell.delegate = self // 델리게이트 설정
        
        let data = CartContents[indexPath.row]
        let wineName = data.wineData.wine.name
        let wineImage = data.wineData.wine.imageUrl
        let shopName = data.wineData.shop.name
        let price = data.wineData.shop.price
        let count = data.count
        
        cell.configure1(imageName: wineImage, wineName: wineName, price: price, count: count, shopName: shopName)
//        cell.configure2(isSelected: itemsSelectedState[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 120)
    }
}
