//
//  NewWineClassCell.swift
//  Drink-EG
//
//  Created by 김도연 on 10/30/24.
//

import UIKit

class NewWineClassCell: UITableViewCell {
    
    private let wineImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let wineNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.ptdBoldFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private let wineProgressView: GradientProgressView = {
        let progressView = GradientProgressView(progressViewStyle: .default)
        progressView.progressTintColor = .clear // progress 자체 색상은 비우고 gradient로 설정
        return progressView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

class GradientProgressView: UIProgressView {
    
    private let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradientLayer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradientLayer()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    private func setupGradientLayer() {
        // 그라데이션 색상 설정
        gradientLayer.colors = [
            UIColor.white.cgColor,
            UIColor(hex: "#7E13B1")!.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        // ProgressView의 track을 숨기고 gradientLayer를 추가
        trackTintColor = .clear
        backgroundColor = UIColor(hex: "#DBDBDB")!
        layer.addSublayer(gradientLayer)
        
        // gradientLayer가 progress보다 앞쪽에 표시되도록 설정
        gradientLayer.mask = layer.sublayers?.first
    }
}
