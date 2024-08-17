//
//  RecomCollectionViewCell.swift
//  Drink-EG
//
//  Created by 이현주 on 7/25/24.
//

import UIKit
import SnapKit
import Moya
import SDWebImage

class RecomCollectionViewCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
            let iv = UIImageView()
            return iv
    }()
    
    private let label1: UILabel = {
        let l1 = UILabel()
        l1.font = .systemFont(ofSize: 14, weight: .bold)
        l1.textColor = .black
        l1.numberOfLines = 0
        l1.adjustsFontSizeToFitWidth = true
        l1.minimumScaleFactor = 0.5
        return l1
    }()
        
    private let view: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(hue: 0.0417, saturation: 0.19, brightness: 1, alpha: 0.7)
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
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(view)
        self.contentView.addSubview(label1)
//        self.contentView.addSubview(label2)
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.masksToBounds = true
  
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        label1.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.leading).offset(9)
            make.top.equalTo(view.snp.top).offset(10)
            make.width.lessThanOrEqualToSuperview().inset(10)
            make.height.lessThanOrEqualTo(30)
        }
            
        view.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(imageView.snp.bottom)
            make.height.equalTo(51)
            make.width.equalToSuperview()
        }
        
    }
    
    func configure(recom: RecommendWineResponse) {
        let imageURL = URL(string: recom.imageUrl)
        imageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder"))
        label1.text = recom.wineName
    }
}
