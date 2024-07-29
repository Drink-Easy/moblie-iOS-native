//
//  RecomCollectionViewCell.swift
//  Drink-EG
//
//  Created by 이현주 on 7/25/24.
//

import UIKit

protocol RecomCollectionViewCellDelegate: AnyObject {
    func didTapImageButton(in cell: RecomCollectionViewCell)
}

class RecomCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: RecomCollectionViewCellDelegate?
    
    private let imageButton: UIButton = {
        let ib = UIButton()
        
        return ib
    }()
    
    @objc private func imageButtonTapped() {
        delegate?.didTapImageButton(in: self)
    }
    
    private let label1: UILabel = {
        let l1 = UILabel()
        l1.font = .systemFont(ofSize: 14, weight: .bold)
        l1.textColor = .black
        l1.numberOfLines = 0
        return l1
    }()
    
    private let label2: UILabel = {
        let l2 = UILabel()
        l2.font = .systemFont(ofSize: 10, weight: .regular)
        l2.textColor = .black
        return l2
    }()
    
    private let view: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(hue: 55/360, saturation: 16/100, brightness: 100/100, alpha: 1.0)
        v.alpha = 0.85
        return v
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
        self.contentView.addSubview(imageButton)
        self.contentView.addSubview(view)
        self.contentView.addSubview(label1)
        self.contentView.addSubview(label2)
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.masksToBounds = true
        
        imageButton.addTarget(self, action: #selector(imageButtonTapped), for: .touchUpInside)
            
        imageButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        label1.snp.makeConstraints { make in
            make.leading.equalTo(imageButton.snp.leading).offset(9)
            make.top.equalTo(view.snp.top).offset(10)
        }
        
        label2.snp.makeConstraints { make in
            make.leading.equalTo(label1.snp.leading)
            make.top.equalTo(view.snp.top).offset(28)
        }
        
        view.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(imageButton.snp.bottom)
            make.height.equalTo(51)
            make.width.equalToSuperview()
        }
        
    }
    
    func configure(imageName: String) {
        if let image = UIImage(named: imageName) {
            label1.text = imageName
            label2.text = "2024"
            imageButton.setImage(image, for: .normal)
        }
    }
}
