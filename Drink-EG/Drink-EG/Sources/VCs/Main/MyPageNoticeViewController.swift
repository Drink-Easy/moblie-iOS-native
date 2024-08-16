//
//  MyPageNoticeViewController.swift
//  Drink-EG
//
//  Created by 이호연 on 8/16/24.
//

import Foundation
import UIKit

class MyPageNoticeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private let label: UILabel = {
        let l = UILabel()
        l.text = "공지사항"
        l.font = .systemFont(ofSize: 28, weight: .bold)
        l.textColor = .black
        l.numberOfLines = 0
        return l
    }()
    
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBarButton()
        setupUI()
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
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // Label 추가
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(27)
        }
        
        // CollectionView 레이아웃 설정
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        
        // CollectionView 추가
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        // CollectionView Cell 등록
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    // UICollectionViewDataSource 메서드
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10 // 임시로 10개의 셀을 생성
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .lightGray
        return cell
    }
    
    // UICollectionViewDelegateFlowLayout 메서드
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 40, height: 94)
    }
}
