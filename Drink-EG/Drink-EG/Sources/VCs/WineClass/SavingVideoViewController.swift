//
//  SavingVideoViewController.swift
//  Drink-EG
//
//  Created by 김도연 on 7/21/24.
//

import UIKit

class SaveVideoViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let saveclassLabel = UILabel()
    let imageView = UIImageView() // CollectionView에 image와 label 추가
    let nameLabel = UILabel()
    let noteListLabel = UILabel() // 노트 보관함 Label
    var noteListGrid: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupView()
        setupSaveClassLabel()
        setupSaveClassLabelConstraints()
        setupNoteListLabelConstraints()
        setupNoteCollectionViewConstraints()
        view.backgroundColor = .systemGray6
    }
    
    func setupView() { // 뷰 설정 함수
        view.addSubview(saveclassLabel)
        view.addSubview(noteListLabel)
        view.addSubview(noteListGrid)
    }
    
    func setupSaveClassLabel() { // Label의 기본 속성을 설정하는 함수
        saveclassLabel.text = "저장된 영상"
        saveclassLabel.font = .boldSystemFont(ofSize: 28)
        saveclassLabel.textAlignment = .center
        saveclassLabel.textColor = .black
    }
    
    func setupSaveClassLabelConstraints() { // Label의 제약 조건을 설정하는 함수
        saveclassLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
        }
    }
    
    func setupCollectionView() { // CollectionView의 기본 속성을 설정하는 함수
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 110, height: 160)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        noteListGrid = UICollectionView(frame: .zero, collectionViewLayout: layout)
        noteListGrid.backgroundColor = .systemGray6
        noteListGrid.layer.cornerRadius = 10
        
        noteListGrid.dataSource = self
        noteListGrid.delegate = self
        noteListGrid.register(SearchVideoCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        let backgroundView = UIView()
        backgroundView.layer.cornerRadius = 10
        backgroundView.layer.masksToBounds = true
        noteListGrid.backgroundView = backgroundView
    }
    
    func setupNoteListLabelConstraints() { // Label의 제약 조건을 설정하는 함수
        noteListLabel.snp.makeConstraints { make in
            make.top.equalTo(saveclassLabel.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(10)
        }
    }
    
    func setupNoteCollectionViewConstraints() { // CollectionView의 제약 조건을 설정하는 함수
        noteListGrid.snp.makeConstraints { make in
            make.leading.equalTo(saveclassLabel)
            make.top.equalTo(saveclassLabel.snp.bottom).offset(10)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(393)
            make.height.equalTo(732)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SearchVideoCollectionViewCell else {
            fatalError("Unable to dequeue SearchVideoCollectionViewCell")
        }
        cell.imageView.image = UIImage(named: "SampleImage")
        cell.nameLabel.text = "초보자를 위한, 와인 입문 순서"
        cell.backgroundColor = .clear
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 60
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

class SearchVideoCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    let nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        
        contentView.addSubview(nameLabel)
        
        
        
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(160)
            
            
        }
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        nameLabel.numberOfLines = 0 // Allow multiple lines
        nameLabel.lineBreakMode = .byWordWrapping
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

