//
//  ShoppingCartListViewController.swift
//  Drink-EG
//
//  Created by 김도연 on 7/20/24.
//

import UIKit

class ShoppingCartListViewController: UIViewController {
    
    private var CartContents: [String] = ["Red Label", "Castello Monaci", "Loxton", "Samos", "Vendredi"]
    private var itemsSelectedState: [Bool] = []
    
    private let allCheckImage = UIImage(named: "icon_cartCheck_fill")
    private let nAllCheckImage = UIImage(named: "icon_cartCheck_nfill")
    private let allCheckButton = UIButton(type: .custom)
    
    private let label: UILabel = {
        let l = UILabel()
        l.text = "장바구니"
        l.font = .systemFont(ofSize: 28, weight: UIFont.Weight(700))
        l.textColor = .black
        l.numberOfLines = 0
        return l
    }()
    
    private let allCheckLabel: UILabel = {
        let l = UILabel()
        l.text = "전체 선택 (1/3)"
        l.font = .boldSystemFont(ofSize: 14)
        l.textColor = UIColor(hex: "#767676")
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
    
    private let buyButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("50,000원 구매하기", for: .normal)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor = .black
        
        view.backgroundColor = .white
        itemsSelectedState = Array(repeating: false, count: 20)
        setupUI()
    }
    
    private func setupUI() {
        
        configureAllCheckButton()
        
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
            make.top.equalTo(allCheckLabel.snp.bottom).offset(20)
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
    
    @objc private func allCheckButtonTapped(_ sender: UIButton) {
        // Bool 값 toggle
        sender.isSelected.toggle()
            
        // 버튼이 클릭될 때마다, 버튼 이미지를 변환
        if sender.isSelected {
            sender.setImage(allCheckImage?.withRenderingMode(.alwaysOriginal), for: .selected)
            updateAllItemsSelection(isSelected: true)
        } else {
            sender.setImage(nAllCheckImage?.withRenderingMode(.alwaysOriginal), for: .normal)
            updateAllItemsSelection(isSelected: false)
        }
    }
    
    private func updateAllItemsSelection(isSelected: Bool) {
        // 모든 항목의 선택 상태를 변경
        itemsSelectedState = Array(repeating: isSelected, count: itemsSelectedState.count)
            
        // 모든 셀을 업데이트
        for section in 0..<cartListCollectionView.numberOfSections {
            for item in 0..<cartListCollectionView.numberOfItems(inSection: section) {
                let indexPath = IndexPath(item: item, section: section)
                if let cell = cartListCollectionView.cellForItem(at: indexPath) as? CartListCollectionViewCell {
                    cell.configure2(isSelected: isSelected)
                }
            }
        }
    }
}

extension ShoppingCartListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CartContents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CartListCollectionViewCell", for: indexPath) as! CartListCollectionViewCell
        
        cell.changeMarketButtonAction = {
            let wineStoreListViewController = WineStoreListViewController()
            self.navigationController?.pushViewController(wineStoreListViewController, animated: true)
        }
            
        cell.configure1(imageName: CartContents[indexPath.item])
        cell.configure2(isSelected: itemsSelectedState[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let wineInfoViewController = WineInfoViewController()
//        navigationController?.pushViewController(wineInfoViewController, animated: true)
//        selectedWine = suggestion[indexPath.item]
//        let wineInfoViewController = WineInfoViewController()
//        wineInfoViewController.modalPresentationStyle = .fullScreen
//        wineInfoViewController.wine = selectedWine
//        self.present(wineInfoViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 120)
    }
}
