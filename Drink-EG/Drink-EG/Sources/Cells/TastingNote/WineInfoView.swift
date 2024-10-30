//
//  WineInfoView.swift
//  Drink-EG
//
//  Created by 이수현 on 10/30/24.
//

import UIKit

class WineInfoView: UIView {

    private let wineName: UILabel = {
        let w = UILabel()
        w.text = "루이 로드레 크리스탈 2015"
        w.textColor = .black
        w.textAlignment = .center
        w.font = UIFont(name: "Pretendard-SemiBold", size: 24)
        return w
    }()
    
    private let wineImage: UIImageView = {
        let w = UIImageView()
        w.contentMode = .scaleToFill
        w.image = UIImage(named: "wine1")
        w.layer.cornerRadius = 14
        return w
    }()
    
    private let wineDescription: UIView = {
        let w = UIView()
        w.backgroundColor = .white
        w.layer.cornerRadius = 14
        return w
    }()
    
    private let wineKind: UILabel = {
        let w = UILabel()
        w.text = "종류"
        w.textColor = UIColor(hex: "#7E13B1")
        w.textAlignment = .center
        w.font = UIFont(name: "Pretendard-SemiBold", size: 14)
        return w
    }()
    
    private let wineGrape: UILabel = {
        let w = UILabel()
        w.text = "품종"
        w.textColor = UIColor(hex: "#7E13B1")
        w.textAlignment = .center
        w.font = UIFont(name: "Pretendard-SemiBold", size: 14)
        return w
    }()
    
    private let wineFrom: UILabel = {
        let w = UILabel()
        w.text = "생산지"
        w.textColor = UIColor(hex: "#7E13B1")
        w.textAlignment = .center
        w.font = UIFont(name: "Pretendard-SemiBold", size: 14)
        return w
    }()
    
    private let graphView: UIView = {
        let g = UIView()
        g.backgroundColor = .white
        g.layer.cornerRadius = 10
        return g
    }()
    
    private let graphLabel: UILabel = {
        let g = UILabel()
        g.text = "Graph"
        g.font = UIFont.
    }
    
    
    
    func setupUI() {
        addSubview(wineName)
        wineName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(110)
            make.leading.equalToSuperview().offset(25)
        }
        
        addSubview(wineImage)
        wineImage.snp.makeConstraints { make in
            make.top.equalTo(wineName.snp.bottom).offset(20)
            make.leading.equalTo(wineName.snp.leading)
            make.width.height.equalTo(100)
        }
        
        addSubview(wineDescription)
        wineDescription.snp.makeConstraints { make in
            make.top.equalTo(wineImage.snp.top)
            make.bottom.equalTo(wineImage.snp.bottom)
            make.leading.equalTo(wineImage.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        wineDescription.addSubview(wineKind)
        wineKind.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(13)
        }
        
        wineDescription.addSubview(wineGrape)
        wineGrape.snp.makeConstraints { make in
            make.top.equalTo(wineKind.snp.bottom).offset(8)
            make.leading.equalTo(wineKind.snp.leading)
        }
        
        wineDescription.addSubview(wineFrom)
        wineFrom.snp.makeConstraints { make in
            make.top.equalTo(wineGrape.snp.bottom).offset(8)
            make.leading.equalTo(wineGrape.snp.leading)
        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
