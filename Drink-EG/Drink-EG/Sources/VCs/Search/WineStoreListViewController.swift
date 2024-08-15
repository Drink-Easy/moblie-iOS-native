//
//  WineStoreListViewController.swift
//  Drink-EG
//
//  Created by 김도연 on 7/21/24.
//

import SnapKit
import UIKit

class WineStoreListViewController: UIViewController {
    
    var selectedShop: String?
    
    private var WineShopContents: [String] = ["PODO", "루바토 와인", "버건디", "와인나우", "보데가 와인"]
    
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
    
    private let score: UILabel = {
        let l3 = UILabel()
        l3.text = "4.5 ★"
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
        
        view.backgroundColor = .white
        setupUI()
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
        
        wineInfo.addSubview(name)
        name.snp.makeConstraints { make in
            make.top.equalTo(imageView)
            make.leading.equalTo(imageView.snp.trailing).offset(23)
        }
        
        wineInfo.addSubview(score)
        score.snp.makeConstraints { make in
            make.centerY.equalTo(name)
            make.leading.equalTo(name.snp.trailing).offset(13)
        }
        
        view.addSubview(wineShopListCollectionView)
        wineShopListCollectionView.snp.makeConstraints { make in
            make.top.equalTo(wineInfo.snp.bottom).offset(76)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(15)
        }
    }
}

extension WineStoreListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return WineShopContents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WineShopListCollectionViewCell", for: indexPath) as! WineShopListCollectionViewCell
        
        cell.configure(name: WineShopContents[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell = collectionView.cellForItem(at: indexPath) as! WineShopListCollectionViewCell
        selectedShop = WineShopContents[indexPath.item]
        let wineOrderViewController = WineOrderViewController()
        wineOrderViewController.shop = selectedShop
        navigationController?.pushViewController(wineOrderViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 120)
    }
}
