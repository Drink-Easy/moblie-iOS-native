//
//  NoteListViewController.swift
//  Drink-EG
//
//  Created by 김도연 on 7/21/24.
//

import Foundation
import UIKit
import SnapKit

class NoteCollectionViewCell: UICollectionViewCell { // 셀에 이미지와 label을 추가하기 위한 커스텀 셀
    
    let imageView = UIImageView()
    let nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .yellow
        
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 12)
        nameLabel.textColor = .black
        
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(contentView.snp.width)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class NewNoteFooter: UICollectionReusableView {
    let button = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(button)

        button.setTitle("+ 새로 적기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.backgroundColor = .clear
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(newButtonTapped), for: .touchUpInside)
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func newButtonTapped() {
        print("새로운 창")
    }
}

class NoteListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    let noteListLabel = UILabel() // 노트 보관함 Label
    var noteListGrid: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCollectionView()
        setupView()
        setupLabel()
        setupNoteListLabelConstraints()
        setupNoteCollectionViewConstraints()
    }
    
    func setupView() {
        view.addSubview(noteListLabel)
        view.addSubview(noteListGrid)
    }
    // MARK: 노트 보관함에 관한 UI
    func setupLabel() {
        noteListLabel.text = "노트 보관함"
        noteListLabel.font = .boldSystemFont(ofSize: 30)
        noteListLabel.textAlignment = .center
        noteListLabel.textColor = .black
    }
    
    func setupNoteListLabelConstraints() {
        noteListLabel.snp.makeConstraints{ make in
            make.top.equalTo(100)
            make.leading.equalTo(45)
        }
    }
    // MARK: 작성한 테이스팅 노트를 보여주는 Grid에 관한 UI
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 85, height: 85)
        layout.minimumLineSpacing = 100
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.footerReferenceSize = CGSize(width: view.frame.width, height: 60)
        
        noteListGrid = UICollectionView(frame: .zero, collectionViewLayout: layout)
        noteListGrid.backgroundColor = .purple
        
        noteListGrid.dataSource = self
        noteListGrid.delegate = self
        noteListGrid.register(NoteCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        noteListGrid.register(NewNoteFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer")
    }
    
    func setupNoteCollectionViewConstraints() {
        noteListGrid.snp.makeConstraints{ make in
            make.top.equalTo(noteListLabel.snp.bottom).offset(50)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-15)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = noteListGrid.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NoteCollectionViewCell
        cell.imageView.image = UIImage(named: "SampleImage")
        cell.nameLabel.text = "와인 이름"
        cell.backgroundColor = .gray
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 85, height: 85)
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 100
        }
            
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 10
        }
   // MARK: "새로 적기" 버튼에 관한 UI
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            if kind == UICollectionView.elementKindSectionFooter {
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath) as! NewNoteFooter
                return footer
            }
            return UICollectionReusableView()
        }

}
