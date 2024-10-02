//
//  MyTastingNote.swift
//  Drink-EG
//
//  Created by 이수현 on 9/28/24.
//

import Foundation
import UIKit
import SnapKit

class MyTastingNote: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private let imageCollectionData = ImageCollectionView()
    
    private var collectionView: UICollectionView!
    
    private let vector: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(hex: "DBDBDB")
        return v
    }()
    
    private let tastingNoteLabel: UILabel = {
        let t = UILabel()
        t.text = "나의 테이스팅 노트"
        t.font  = UIFont(name: "Pretendard-SemiBold", size: 20)
        t.textColor = .black
        t.textAlignment = .left
        return t
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupCollectionView()
    }
    
    func setupUI() {
        addSubview(vector)
        vector.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(1)
        }
        
        addSubview(tastingNoteLabel)
        tastingNoteLabel.snp.makeConstraints { make in
            make.top.equalTo(vector.snp.bottom).offset(40)
            make.leading.equalTo(vector.snp.leading)
            make.centerX.equalToSuperview()
        }
        
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 48
        layout.minimumInteritemSpacing = 10
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(WineImageCell.self, forCellWithReuseIdentifier: "TastingNoteCell")
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(tastingNoteLabel.snp.bottom).offset(28)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ImageCollectionView().images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TastingNoteCell", for: indexPath) as! WineImageCell
        cell.configure(with: imageCollectionData, index: indexPath.item)
        return cell
    }
    
    // UICollectionViewDelegateFlowLayout 메서드
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 32) / 3 // 3열 구성
        return CGSize(width: width, height: width * 1.5) // 셀 높이 비율 설정
    }
    
    required init? (coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
