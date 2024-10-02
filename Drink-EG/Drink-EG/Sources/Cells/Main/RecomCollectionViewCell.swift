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
        l1.font = .systemFont(ofSize: 13, weight: .bold)
        l1.textColor = .white
        l1.numberOfLines = 2
        //l1.adjustsFontSizeToFitWidth = true
        l1.lineBreakMode = .byTruncatingTail // 생략 부호(...)가 꼬리에 위치하도록 설정
        return l1
    }()
        
    private let view: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(hue: 0.7389, saturation: 0.89, brightness: 0.69, alpha: 0.7)
        return v
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.shadowOpacity = 0.3
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 5
        layer.masksToBounds = false
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
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.equalTo(view.snp.top).offset(10)
//            make.width.lessThanOrEqualToSuperview().inset(15)
            make.height.lessThanOrEqualTo(35)
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
