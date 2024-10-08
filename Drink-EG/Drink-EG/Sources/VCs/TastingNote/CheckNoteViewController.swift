//
//  CheckNoteViewController.swift
//  Drink-EG
//
//  Created by 이수현 on 8/13/24.
//

import UIKit
import SnapKit
import Moya
import SDWebImage

class CheckNoteViewController: UIViewController {
    var wine: String?
    
    let pentagonChart = PolygonChartView()
    var dataList: [RadarChartData] = []
    var selectedOptions: [String: [String]] = [:]
    var reviewString: String = ""
    var value: Double = 0.0
    
    var selectedWineName: String?
    var selectedWineImage: String?
    var area: String?
    var sort: String?
    
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
            make.height.equalTo(UIScreen.main.bounds.height * 1.1)
        }
    }
    
    private let wineInfoLabel: UILabel = {
        let w = UILabel()
        w.text = "와인 정보"
        w.font = .systemFont(ofSize: UIConstants.labelFontSize, weight: UIFont.Weight(rawValue: 700))
        w.textAlignment = .center
        w.textColor = .black
        return w
    }()
    
    private let infoView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(hex: "FBCBC4")
        v.layer.cornerRadius = 10
        v.layer.masksToBounds = true
        return v
    }()
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        if let imageUrlString = selectedWineImage, let imageUrl = URL(string: imageUrlString) {
            iv.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "Loxton"))
        } else {
            iv.image = UIImage(named: "Loxton")
        }
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        return iv
    }()
    
    private lazy var name: UILabel = {
        let l = UILabel()
        l.text = selectedWineName ?? ""
        l.font = .boldSystemFont(ofSize: 16)
        l.textColor = .black
        l.numberOfLines = 1
        l.lineBreakMode = .byTruncatingTail
        return l
    }()
    
    lazy var specInfo: UILabel = {
        let l = UILabel()
        l.text = "품종: \(sort ?? "N/A")\n생산지: \(area ?? "N/A")"
        l.font = UIFont(name: "Pretendard-Bold", size: 12)
        l.textColor = .black
        l.numberOfLines = 2
        l.lineBreakMode = .byTruncatingTail
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
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [name, specInfo])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 5
        return stackView
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
        aromaButton.setTitle(selectedOptions["scentAroma"]?[0], for: .normal)
        aromaButton.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 14)
        aromaButton.setTitleColor(.black, for: .normal)
        aromaButton.backgroundColor = UIColor(hex: "FBCBC4")
        aromaButton.layer.borderColor = UIColor(hex: "FA8D7B")?.cgColor
        aromaButton.layer.cornerRadius = 10
        
        tasteView.addSubview(tasteButton)
        tasteButton.setTitle(selectedOptions["scentTaste"]?[0], for: .normal)
        tasteButton.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 14)
        tasteButton.setTitleColor(.black, for: .normal)
        tasteButton.backgroundColor = UIColor(hex: "FBCBC4")
        tasteButton.layer.borderColor = UIColor(hex: "FA8D7B")?.cgColor
        tasteButton.layer.cornerRadius = 10
        
        tasteView.addSubview(finishButton)
        finishButton.setTitle(selectedOptions["scentFinish"]?[0], for: .normal)
        finishButton.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 14)
        finishButton.setTitleColor(.black, for: .normal)
        finishButton.backgroundColor = UIColor(hex: "FBCBC4")
        finishButton.layer.borderColor = UIColor(hex: "FA8D7B")?.cgColor
        finishButton.layer.cornerRadius = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print(selectedOptions)
        setupNavigationBarButton()
        setupView()
        setupUI()
    }
    
    func setupNavigationBarButton() {
        navigationItem.hidesBackButton = false
        let backArrow = UIImage(systemName: "chevron.backward")
        let leftButton = UIBarButtonItem(image: backArrow, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = leftButton
        leftButton.tintColor = .black
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupUI() {
        setupPentagonChart()
        setupButton()
        setupReview()
        
        contentView.addSubview(wineInfoLabel)
        
        wineInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(27)
        }
        
        contentView.addSubview(infoView)
        
        infoView.snp.makeConstraints { make in
            make.top.equalTo(wineInfoLabel.snp.bottom).offset(30)
            make.leading.equalTo(wineInfoLabel.snp.leading)
            make.centerX.equalTo(contentView.snp.centerX)
            make.height.equalTo(UIScreen.main.bounds.height * 0.09)
        }
        
        infoView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(7.5)
            make.leading.equalToSuperview().offset(8)
            make.width.equalTo(imageView.snp.height)
        }
        
//        infoView.addSubview(stackView)
//        stackView.snp.makeConstraints { make in
//            make.leading.equalTo(imageView.snp.trailing).offset(20)
//            make.trailing.equalTo(infoView.snp.trailing).offset(-50)
//            //make.top.bottom.equalTo(infoView)
//            make.centerY.equalTo(infoView.snp.centerY)
//        }
        
        infoView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(imageView.snp.trailing).offset(20)
            make.trailing.equalTo(infoView.snp.trailing).offset(-50)
        }
        
//        stackView.addSubview(name)
//        name.snp.makeConstraints { make in
////            make.top.equalToSuperview()
////            make.leading.equalTo(imageView.snp.trailing).offset(20)
////            make.trailing.equalTo(infoView.snp.trailing).offset(-50)
//            make.top.leading.equalToSuperview()
//        }
//        
//        stackView.addSubview(specInfo)
//        specInfo.snp.makeConstraints { make in
//            make.top.equalTo(name.snp.bottom).offset(5)
//            make.leading.equalTo(name)
//            make.trailing.equalTo(name.snp.trailing)
//        }
        
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
            make.centerX.equalTo(aromaButton.snp.centerX)
            make.width.equalTo(tasteView.snp.width).multipliedBy(0.25)
        }
        
        tasteView.addSubview(tasteLabel)
        tasteLabel.snp.makeConstraints { make in
            make.centerY.equalTo(aromaLabel.snp.centerY)
            make.centerX.equalTo(tasteButton.snp.centerX)
            make.width.equalTo(tasteView.snp.width).multipliedBy(0.25)
        }
        
        tasteView.addSubview(finishLabel)
        finishLabel.snp.makeConstraints { make in
            make.centerY.equalTo(tasteLabel.snp.centerY)
            make.centerX.equalTo(finishButton.snp.centerX)
            make.width.equalTo(tasteView.snp.width).multipliedBy(0.25)
        }
        
        aromaButton.snp.makeConstraints { make in
            make.top.equalTo(aromaLabel.snp.bottom).offset(7)
            make.leading.equalTo(tasteView.snp.leading).offset(9)
            make.width.equalTo(tasteView.snp.width).multipliedBy(0.25)
        }
        
        tasteButton.snp.makeConstraints { make in
            make.top.equalTo(tasteLabel.snp.bottom).offset(7)
            make.centerX.equalTo(tasteView.snp.centerX)
            make.width.equalTo(tasteView.snp.width).multipliedBy(0.25)
        }
        
        finishButton.snp.makeConstraints { make in
            make.top.equalTo(finishLabel.snp.bottom).offset(7)
            make.trailing.equalTo(tasteView.snp.trailing).offset(-9)
            make.width.equalTo(tasteView.snp.width).multipliedBy(0.25)
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
