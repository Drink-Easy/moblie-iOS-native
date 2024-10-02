//
//  MenuCollectionViewCell.swift
//  Drink-EG
//
//  Created by 이현주 on 9/29/24.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    private let menuImage: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor(hex: "D9D9D9")
        return iv
    }()
    
    private let menuName: UILabel = {
        let l1 = UILabel()
        l1.font = .systemFont(ofSize: 12, weight: .regular)
        l1.textColor = .black
        l1.textAlignment = .center
        //l1.numberOfLines = 2
        return l1
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //레이아웃까지
    private func setupUI() {
        self.contentView.addSubview(menuImage)
        self.contentView.addSubview(menuName)
        self.contentView.layer.cornerRadius = 5
        self.contentView.layer.masksToBounds = true

  
        menuImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        menuName.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(5)
            make.bottom.equalToSuperview().inset(2)
        }
    }
    
    func configure(name: String) {
        menuName.text = name
    }
}
