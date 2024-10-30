//
//  NewWineClassCell.swift
//  Drink-EG
//
//  Created by 김도연 on 10/30/24.
//

import UIKit

class NewWineClassCell: UITableViewCell {
    
    private let containerView = UIView()
    private let progressView = UIView()
    
    private let classImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let classNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.ptdBoldFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private let classProgressbarView: GradientProgressView = {
        let progressView = GradientProgressView(progressViewStyle: .default)
        progressView.progressTintColor = .clear // progress 자체 색상은 비우고 gradient로 설정
        return progressView
    }()
    
    private let progressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.ptdRegularFont(ofSize: 12)
        label.textColor = UIColor(hex: "#7E13B1")
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func setupViews() {
        contentView.addSubview(classImageView)
        contentView.addSubview(containerView)
        
        containerView.addSubview(classNameLabel)
        containerView.addSubview(progressView)
        
        progressView.addSubview(classProgressbarView)
        progressView.addSubview(progressLabel)
    }
    
    private func setupConstraints() {
        classImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.width.equalToSuperview().multipliedBy(0.25)
            make.height.equalTo(classImageView.snp.width).multipliedBy(10.0 / 9.0)
            make.bottom.lessThanOrEqualToSuperview().offset(-10) // 하단 여백 추가
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(classImageView)
            make.bottom.equalToSuperview().offset(-10)
            make.leading.equalTo(classImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        classNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview()
        }
        
        progressView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.greaterThanOrEqualTo(classNameLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        classProgressbarView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalToSuperview()
            make.height.equalTo(4)
        }
        
        progressLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.top.greaterThanOrEqualTo(classProgressbarView.snp.bottom).offset(8)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with image: UIImage?, name: String, progress: Float) {
        classImageView.image = image
        classNameLabel.text = name
        classProgressbarView.progress = progress
        progressLabel.text = String(format: "%.1f%%", progress * 100)
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
    
    private func updateGradientLayerFrame() {
        // `progress` 값을 기반으로 `gradientLayer`의 폭을 조절
        gradientLayer.frame = CGRect(
            x: 0,
            y: 0,
            width: bounds.width * CGFloat(progress),
            height: bounds.height
        )
    }
    
    override var progress: Float {
        didSet {
            updateGradientLayerFrame() // `progress` 값 변경 시 레이어 업데이트
        }
    }
}
