//
//  WineListTableViewCell.swift
//  Drink-EG
//
//  Created by 이현주 on 10/30/24.
//

import UIKit
import SnapKit
import SDWebImage

class WineListTableViewCell: UITableViewCell {
    
    public lazy var image: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 5
        iv.layer.masksToBounds = true
        return iv
    }()

    public lazy var name: UILabel = {
        let l1 = UILabel()
        l1.font = UIFont.ptdSemiBoldFont(ofSize: 16)
        l1.textColor = UIColor(hex: "#121212")
        l1.numberOfLines = 0
        l1.adjustsFontSizeToFitWidth = true // 텍스트가 레이블 너비에 맞도록 크기 조정
        l1.minimumScaleFactor = 0.5
        return l1
    }()
    
    public lazy var kind: UILabel = {
        let l = UILabel()
        l.text = "와인 > 스파클링, 샴페인"
        l.font = UIFont.ptdRegularFont(ofSize: 14)
        l.textColor = UIColor(hex: "#999999")
        l.numberOfLines = 1
        l.adjustsFontSizeToFitWidth = true
        return l
    }()
    
    public lazy var score: UILabel = {
        let l3 = UILabel()
        l3.font = .ptdRegularFont(ofSize: 14)
        l3.textColor = UIColor(hex: "#5813B1")
        l3.numberOfLines = 1
        return l3
    }()
    
    public lazy var likeBtn: UIButton = {
        let b = UIButton()
        b.backgroundColor = .clear
        b.setImage(UIImage(named: "like_nfill"), for: .normal)
        return b
    }()

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.image.image = nil
        self.name.text = nil
        //self.kind.text = nil
        self.score.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        addSubview(image)
        addSubview(name)
        addSubview(kind)
        addSubview(score)
        addSubview(likeBtn)
        
        image.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.verticalEdges.equalToSuperview().inset(6)
            make.width.height.equalTo(70) //일단...
        }
        
        name.snp.makeConstraints { make in
            make.leading.equalTo(image.snp.trailing).offset(18)
            make.top.equalToSuperview().offset(19)
            // 너비 설정
        }
        
        kind.snp.makeConstraints { make in
            make.leading.equalTo(name.snp.leading)
            make.top.equalTo(name.snp.bottom).offset(8)
            //너비 설정
        }
        
        likeBtn.snp.makeConstraints { make in
            make.centerY.equalTo(name)
            make.trailing.equalToSuperview().offset(-27.2)
        }
        
        score.snp.makeConstraints { make in
            make.centerY.equalTo(likeBtn)
            make.trailing.equalTo(likeBtn.snp.leading).offset(-2)
        }
        
    }
    
    func configure(wine: Wine) {
        let imageURL = URL(string: wine.imageUrl!)
        image.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder"))
        name.text = wine.name
        let scoreString: String = String(wine.rating)
        score.text = scoreString
    }
}
