//
//  NoteListViewController.swift
//  Drink-EG
//
//  Created by 김도연 on 7/21/24.
//

import Foundation
import UIKit
import SnapKit
import Moya


protocol NewNoteFooterDelegate: AnyObject {
    func didTapNewNoteButton()
}

class NoteCollectionViewCell: UICollectionViewCell { // 셀에 이미지와 label을 추가하기 위한 커스텀 셀
    
    let imageView = UIImageView() // CollectionView에 image와 label 추가
    let nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 12)
        nameLabel.textColor = .black
        nameLabel.numberOfLines = 2
        
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(contentView.snp.width)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
        }
        
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class NewNoteFooter: UICollectionReusableView {
    let button = UIButton(type: .system)
    weak var delegate: NewNoteFooterDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(button)

        button.setTitle("+ 새로 적기", for: .normal)
        button.setTitleColor(UIColor(hex: "FFFFFF"), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = UIColor(hex: "FA735B")
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(newNoteButtonTapped), for: .touchUpInside)
        button.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.height.greaterThanOrEqualTo(61)
            // make.bottom.equalToSuperview().offset(-10)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func newNoteButtonTapped() {
        delegate?.didTapNewNoteButton()
    }
}

// NoteListViewController는 사용자가 작성한 테이스팅 노트를 확인 및 새로 작성할 수 있는 뷰
class NoteListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, NewNoteFooterDelegate {
   
    let provider = MoyaProvider<TastingNoteAPI>()
    
    let noteListLabel = UILabel() // 노트 보관함 Label
    var noteListGrid: UICollectionView! // 테이스팅 노트를 보관할 CollectionView
    let images = ["Castello Monaci", "Castello Monaci", "Castello Monaci", "Castello Monaci", "Castello Monaci", "Castello Monaci", "Castello Monaci", "Castello Monaci", "Castello Monaci", "Castello Monaci", "Castello Monaci", "Castello Monaci", "Castello Monaci", "Castello Monaci", "Castello Monaci", "Castello Monaci"]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupAPI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCollectionView()
        setupView()
        setupNavigationBarButton()
        setupLabel()
        setupNoteListLabelConstraints()
        setupNoteCollectionViewConstraints()
    }
    
    func setupView() { // 뷰 설정 함수
        view.addSubview(noteListLabel)
        view.addSubview(noteListGrid)
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
    
    // MARK: 노트 보관함에 관한 UI
    func setupLabel() { // Label의 기본 속성을 설정하는 함수
        noteListLabel.text = "노트 보관함"
        noteListLabel.font = UIFont(name: "Pretendard-Bold", size: 28)
        noteListLabel.textAlignment = .center
        noteListLabel.textColor = .black
    }
    
    func setupNoteListLabelConstraints() { // Label의 제약 조건을 설정하는 함수
        noteListLabel.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(46)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
        }
    }
    
    // MARK: 작성한 테이스팅 노트를 보여주는 Grid에 관한 UI
    func setupCollectionView() { // CollectionView의 기본 속성을 설정하는 함수
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 65, height: 65)
        layout.minimumLineSpacing = 69
        layout.minimumInteritemSpacing = 22
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.footerReferenceSize = CGSize(width: view.frame.width, height: 60)
        noteListGrid = UICollectionView(frame: .zero, collectionViewLayout: layout)
        noteListGrid.backgroundColor = .clear
        noteListGrid.layer.cornerRadius = 36
        noteListGrid.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMinYCorner)
        noteListGrid.layer.borderWidth = 1
        noteListGrid.layer.borderColor = UIColor.white.cgColor
        
        let shadowPath = UIBezierPath(roundedRect: noteListGrid.bounds, cornerRadius: 36)
        noteListGrid.layer.shadowPath = shadowPath.cgPath
        noteListGrid.layer.shadowColor = UIColor(red: 0.98, green: 0.451, blue: 0.357, alpha: 0.2).cgColor
        noteListGrid.layer.shadowOpacity = 1
        noteListGrid.layer.shadowRadius = 20
        noteListGrid.layer.shadowOffset = CGSize(width: 4, height: -14)
        noteListGrid.layer.masksToBounds = false
        
        
        noteListGrid.dataSource = self
        noteListGrid.delegate = self
        noteListGrid.register(NoteCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        noteListGrid.register(NewNoteFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer")
        
        let backgroundView = UIView()
        backgroundView.layer.cornerRadius = 10
        backgroundView.layer.masksToBounds = false
        noteListGrid.backgroundView = backgroundView
    }
    
    func setupNoteCollectionViewConstraints() { // CollectionView의 제약 조건을 설정하는 함수
        noteListGrid.snp.makeConstraints{ make in
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(noteListLabel.snp.bottom).offset(35)
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // CollectionView Cell 개수를 설정하는 함수
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell { // 재사용 가능한 셀을 가져와서 NoteCollectionViewCell로 캐스팅
        let cell = noteListGrid.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NoteCollectionViewCell

        cell.imageView.image = UIImage(named: "Castello Monaci")
        cell.nameLabel.text = "와인 이름\n1999"
        cell.nameLabel.numberOfLines = 2
        cell.nameLabel.font = UIFont(name: "Pretendard-Bold", size: 14)
        cell.backgroundColor = .clear
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { // 각 셀의 크기를 설정하는 함수
        let numberOfItemsPerRow: CGFloat = 4
        let spacingBetweenCells: CGFloat = 22
        
        let totalSpacing = (2 * spacingBetweenCells) + ((numberOfItemsPerRow - 1) * spacingBetweenCells)
        
        let width = (collectionView.bounds.width - totalSpacing) / numberOfItemsPerRow
        let height = width * 1.6
        
        return CGSize(width: width, height: height)
    }
    
    // MARK: "새로 적기" 버튼에 관한 UI
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath) as! NewNoteFooter
            footer.delegate = self
            return footer
        }
        return UICollectionReusableView()
    }
    
    func didTapNewNoteButton() {

        let nextVC = AddNewNoteViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func setupAPI() {
        provider.request(TastingNoteAPI.getAllNotes) { result in
            switch result {
            case .success(let response):
                do {
                    let data = try response.mapJSON()
                    print("User Data: \(data)")
                } catch {
                    print("Failed to map data: \(error)")
                }
            case .failure(let error):
                print("Request failed: \(error)")
            }
        }
    }
}
