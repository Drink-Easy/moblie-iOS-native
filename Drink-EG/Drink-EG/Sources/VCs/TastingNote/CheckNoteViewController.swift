//
//  CheckNoteViewController.swift
//  Drink-EG
//
//  Created by 이수현 on 8/13/24.
//

import Foundation
import UIKit
import SnapKit
import Moya

class CheckNoteViewController: UIViewController {
    var wine: String?
    
    let pentagonChart = PolygonChartView()
    var dataList: [RadarChartData] = []
    var selectedOptions: [String: [String]] = [:]
    var reviewString: String = ""
    var value: Double = 0.0
    
    func setupPentagonChart() {
        pentagonChart.backgroundColor = .clear
        pentagonChart.dataList = dataList
        pentagonChart.layer.cornerRadius = 10
        
    }
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    func setupView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.backgroundColor = .clear
        contentView.backgroundColor = .clear
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.height.equalTo(UIScreen.main.bounds.height * 1.3)
        }
    }
    
    private let infoView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(hex: "FBCBC4")
        v.layer.cornerRadius = 10
        v.layer.masksToBounds = true
        return v
    }()
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        if let wine = wine {
            iv.image = UIImage(named: wine)
        }
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        return iv
    }()
    
    private lazy var name: UILabel = {
        let l = UILabel()
        if let wine = wine {
            l.text = wine
        }
        l.font = .boldSystemFont(ofSize: 18)
        l.textColor = .black
        l.numberOfLines = 0
        return l
    }()
    
    private let specInfo: UILabel = {
        let l = UILabel()
        l.text = "종류: 레드 와인\n품종: 쉬라 100%\n생산지: 호주, South Australia"
        l.font = .systemFont(ofSize: 12)
        l.textColor = .black
        l.numberOfLines = 0
        return l
    }()
    
    lazy var score: UILabel = {
        let l = UILabel()
        l.text = "\(value)"
        l.font = .boldSystemFont(ofSize: 12)
        l.textColor = UIColor(hex: "#767676")
        return l
    }()
    
    private let color: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(hex: "#BA2121")
        v.layer.cornerRadius = 11
        v.layer.masksToBounds = true
        return v
    }()
    
    private let tastingNoteView: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        v.layer.cornerRadius = 36
        v.layer.masksToBounds = true
        v.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor(hex: "E5E5E5")?.cgColor
        return v
    }()
    
    private let represent: UILabel = {
        let l = UILabel()
        l.text = "대표 테이스팅 노트"
        l.font = .systemFont(ofSize: 20, weight: UIFont.Weight(700))
        l.textColor = .black
        l.numberOfLines = 0
        return l
    }()
    
    private let vectorView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(hex: "FA735B")
        return v
    }()
    
    private let tasteView: UIView = {
        let t = UIView()
        t.backgroundColor = .clear
        t.layer.borderColor = UIColor(hex: "E5E5E5")?.cgColor
        t.layer.borderWidth = 2
        t.layer.cornerRadius = 10
        return t
    }()
    
    private let aromaLabel: UILabel = {
        let a = UILabel()
        a.text = "Aroma"
        a.font = UIFont(name: "Pretendard-SemiBold", size: 18)
        a.textColor = .black
        a.textAlignment = .center
        return a
    }()
    
    private let tasteLabel: UILabel = {
        let t = UILabel()
        t.text = "Taste"
        t.font = UIFont(name: "Pretendard-SemiBold", size: 18)
        t.textColor = .black
        t.textAlignment = .center
        return t
    }()
    
    private let finishLabel: UILabel = {
        let f = UILabel()
        f.text = "Finish"
        f.font = UIFont(name: "Pretendard-SemiBold", size: 18)
        f.textColor = .black
        f.textAlignment = .center
        return f
    }()
    
    private let reviewView: UIView = {
        let r = UIView()
        r.backgroundColor = .clear
        r.layer.cornerRadius = 36
        r.layer.masksToBounds = true
        r.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        r.layer.borderWidth = 1
        r.layer.borderColor = UIColor(hex: "E5E5E5")?.cgColor
        return r
    }()
    
    private let reviewLabel: UILabel = {
        let r = UILabel()
        r.text = "리뷰"
        r.font = UIFont(name: "Pretendard-SemiBold", size: 18)
        r.textColor = .black
        r.textAlignment = .center
        return r
    }()
    
    private let reviewVector: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(hex: "FA735B")
        return v
    }()
    
    let review = UILabel()
    
    func setupReview() {
        reviewView.addSubview(review)
        review.text = reviewString
        review.font = UIFont(name: "Pretendard-SemiBold", size: 14)
        review.textColor = .black
        review.textAlignment = .center
        review.numberOfLines = 10
    }
    
    let aromaButton = UIButton()
    let tasteButton = UIButton()
    let finishButton = UIButton()
    
    func setupButton() {
        tasteView.addSubview(aromaButton)
        aromaButton.setTitle(selectedOptions["Aroma"]?[0], for: .normal)
        aromaButton.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        aromaButton.setTitleColor(.black, for: .normal)
        aromaButton.backgroundColor = UIColor(hex: "FBCBC4")
        aromaButton.layer.borderColor = UIColor(hex: "FA8D7B")?.cgColor
        aromaButton.layer.cornerRadius = 10
        
        tasteView.addSubview(tasteButton)
        tasteButton.setTitle(selectedOptions["Taste"]?[0], for: .normal)
        tasteButton.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        tasteButton.setTitleColor(.black, for: .normal)
        tasteButton.backgroundColor = UIColor(hex: "FBCBC4")
        tasteButton.layer.borderColor = UIColor(hex: "FA8D7B")?.cgColor
        tasteButton.layer.cornerRadius = 10
        
        tasteView.addSubview(finishButton)
        finishButton.setTitle(selectedOptions["Finish"]?[0], for: .normal)
        finishButton.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        finishButton.setTitleColor(.black, for: .normal)
        finishButton.backgroundColor = UIColor(hex: "FBCBC4")
        finishButton.layer.borderColor = UIColor(hex: "FA8D7B")?.cgColor
        finishButton.layer.cornerRadius = 10
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        setupUI()
    }
    
    private func setupUI() {
        setupPentagonChart()
        setupButton()
        setupReview()
        
        contentView.addSubview(infoView)
        
        infoView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(50)
            make.leading.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(14)
            make.height.equalTo(UIScreen.main.bounds.height * 0.09)
        }
        
        infoView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(7.5)
            make.leading.equalToSuperview().offset(8)
            make.width.equalTo(imageView.snp.height)
        }
        
        infoView.addSubview(name)
        name.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(11)
            make.leading.equalTo(imageView.snp.trailing).offset(20)
        }
        
        infoView.addSubview(specInfo)
        specInfo.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom).offset(11)
            make.leading.equalTo(name)
        }
        
        infoView.addSubview(score)
        score.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().inset(25)
        }
        
        infoView.addSubview(color)
        color.snp.makeConstraints { make in
            make.top.equalTo(score.snp.bottom).offset(14)
            make.trailing.equalToSuperview().inset(23)
            make.width.height.equalTo(22)
        }
        
        contentView.addSubview(tastingNoteView)
        tastingNoteView.snp.makeConstraints { make in
            make.top.equalTo(infoView.snp.bottom).offset(29)
            make.leading.trailing.equalTo(infoView)
            make.bottom.greaterThanOrEqualTo(414)
        }
        
        tastingNoteView.addSubview(represent)
        represent.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(18)
        }
        
        tastingNoteView.addSubview(pentagonChart)
        pentagonChart.snp.makeConstraints{ make in
            make.top.equalTo(represent.snp.bottom).offset(29)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(UIScreen.main.bounds.width * 0.89)
            make.height.equalTo(pentagonChart.snp.width).multipliedBy(0.87)
        }
        
        tastingNoteView.addSubview(tasteView)
        tasteView.snp.makeConstraints { make in
            make.top.equalTo(pentagonChart.snp.bottom).offset(41.55)
            make.leading.equalTo(tastingNoteView.snp.leading).offset(15)
            make.centerX.equalTo(tastingNoteView.snp.centerX)
            make.height.greaterThanOrEqualTo(116)
        }
        
        tasteView.addSubview(aromaLabel)
        aromaLabel.snp.makeConstraints { make in
            make.top.equalTo(tasteView.snp.top).offset(23)
            make.leading.equalTo(tasteView.snp.leading).offset(27)
        }
        
        tasteView.addSubview(tasteLabel)
        tasteLabel.snp.makeConstraints { make in
            make.centerY.equalTo(aromaLabel.snp.centerY)
            make.leading.equalTo(aromaLabel.snp.trailing).offset(68)
        }
        
        tasteView.addSubview(finishLabel)
        finishLabel.snp.makeConstraints { make in
            make.centerY.equalTo(tasteLabel.snp.centerY)
            make.leading.equalTo(tasteLabel.snp.trailing).offset(78)
        }
        
        aromaButton.snp.makeConstraints { make in
            make.top.equalTo(aromaLabel.snp.bottom).offset(7)
            make.leading.equalTo(tasteView.snp.leading).offset(9)
            make.centerX.equalTo(aromaLabel.snp.centerX)
        }
        
        tasteButton.snp.makeConstraints { make in
            make.top.equalTo(tasteLabel.snp.bottom).offset(7)
            make.centerX.equalTo(tasteLabel.snp.centerX)
            make.leading.equalTo(aromaButton.snp.trailing).offset(45)
        }
        
        finishButton.snp.makeConstraints { make in
            make.top.equalTo(finishLabel.snp.bottom).offset(7)
            make.centerX.equalTo(finishLabel.snp.centerX)
            make.leading.equalTo(tasteButton.snp.trailing).offset(53)
        }
        
        tastingNoteView.addSubview(vectorView)
        vectorView.snp.makeConstraints { make in
            make.top.equalTo(represent.snp.bottom).offset(13)
            make.leading.equalTo(represent.snp.leading).offset(27)
            make.centerX.equalTo(tastingNoteView.snp.centerX)
            make.height.equalTo(1)
        }
        
        tastingNoteView.addSubview(reviewView)
        reviewView.snp.makeConstraints { make in
            make.top.equalTo(tasteView.snp.bottom).offset(19)
            make.leading.trailing.equalTo(tasteView)
            make.height.greaterThanOrEqualTo(215)
        }
        
        reviewView.addSubview(reviewLabel)
        reviewLabel.snp.makeConstraints { make in
            make.top.equalTo(reviewView.snp.top).offset(27)
            make.leading.equalTo(reviewView.snp.leading).offset(33)
        }
        
        reviewView.addSubview(reviewVector)
        reviewVector.snp.makeConstraints { make in
            make.top.equalTo(reviewLabel.snp.bottom).offset(10)
            make.leading.equalTo(reviewView.snp.leading).offset(27)
            make.centerX.equalTo(reviewView.snp.centerX)
            make.height.equalTo(1)
        }
        
        review.snp.makeConstraints { make in
            make.top.equalTo(reviewVector.snp.bottom).offset(26)
            make.leading.equalTo(reviewVector.snp.leading).offset(6)
            make.centerX.equalTo(reviewVector.snp.centerX)
        }
    }
}

