//
//  WineInfoViewController.swift
//  Drink-EG
//
//  Created by 김도연 on 7/21/24.
//

import UIKit
import SnapKit

class WineInfoViewController: UIViewController {
    
    var wine: String?
    
    let pentagonChart = PolygonChartView()
    var dataList: [RadarChartData] = [RadarChartData(type: .sweetness, value: 8),
                                      RadarChartData(type: .acid, value: 6),
                                      RadarChartData(type: .tannin, value: 2),
                                      RadarChartData(type: .bodied, value: 6),
                                      RadarChartData(type: .alcohol, value: 4)]
    
    func setupPentagonChart() {
        pentagonChart.backgroundColor = .clear
        pentagonChart.dataList = dataList
        pentagonChart.layer.cornerRadius = 10
    }
    
    private let label: UILabel = {
        let l = UILabel()
        l.text = "와인 정보"
        l.font = .systemFont(ofSize: 28, weight: UIFont.Weight(700))
        l.textColor = .black
        l.numberOfLines = 0
        return l
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isDirectionalLockEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .clear
        return contentView
    }()
    
    private let infoView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(hex: "#E5E5E5")
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
    
    private let score: UILabel = {
        let l = UILabel()
        l.text = "4.5"
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
        v.backgroundColor = UIColor(hex: "#E5E5E5")
        v.layer.cornerRadius = 10
        v.layer.masksToBounds = true
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
    
    private let explainEntireView: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        v.layer.cornerRadius = 10
        v.layer.masksToBounds = true
        v.layer.borderWidth = 2
        v.layer.borderColor = UIColor(hex: "#E5E5E5")?.cgColor
        return v
    }()
    
    private func explainLabel() -> UILabel {
        let l = UILabel()
        l.font = .boldSystemFont(ofSize: 18)
        l.textColor = .black
        return l
    }
    
    private func explainView() -> UIButton {
        let v = UIButton(type: .system)
        v.layer.cornerRadius = 18
        v.layer.masksToBounds = true
        v.backgroundColor = UIColor(hex: "#FBCBC4")
        v.layer.borderWidth = 2
        v.layer.borderColor = UIColor(hue: 0.025, saturation: 0.63, brightness: 0.98, alpha: 0.7).cgColor
        
        v.titleLabel?.font = .boldSystemFont(ofSize: 16)
        v.setTitleColor(.black, for: .normal)
        
        return v
    }
    
    private let goToReviewButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("다른 유저 리뷰 보기", for: .normal)
        b.setTitleColor(UIColor(hex: "#FA735B"), for: .normal)
        b.titleLabel?.font = .boldSystemFont(ofSize: 18)
        b.contentHorizontalAlignment = .center
        
        b.backgroundColor = .white
        b.layer.cornerRadius = 25
        b.layer.masksToBounds = true
        b.layer.borderWidth = 2
        b.layer.borderColor = UIColor(hex: "#FA735B")?.cgColor
        b.addTarget(self, action: #selector(reviewButtonTapped), for: .touchUpInside)
        
        return b
    }()
    
    @objc private func reviewButtonTapped() {
        let reviewListViewController = ReviewListViewController()
        navigationController?.pushViewController(reviewListViewController, animated: true)
    }
    
    private let goToShopButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("판매처 보기", for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.titleLabel?.font = .boldSystemFont(ofSize: 18)
        b.contentHorizontalAlignment = .center
        
        b.backgroundColor = UIColor(hex: "#FA735B")
        b.layer.cornerRadius = 25
        b.layer.masksToBounds = true
        b.addTarget(self, action: #selector(shopButtonTapped), for: .touchUpInside)
        
        return b
    }()
    
    @objc private func shopButtonTapped() {
        let wineStoreListViewController = WineStoreListViewController()
        navigationController?.pushViewController(wineStoreListViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = .black
        view.backgroundColor = .white
        
        setupUI()
    }
    
    private func setupUI() {
        
        setupPentagonChart()
        
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(27)
        }
        
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.height.greaterThanOrEqualTo(scrollView.snp.height).priority(.low)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        contentView.addSubview(infoView)
        infoView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(14)
            make.height.lessThanOrEqualTo(101)
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
            make.top.equalTo(infoView.snp.bottom).offset(10.5)
            make.leading.trailing.equalTo(infoView)
            make.height.greaterThanOrEqualTo(414)
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
            make.width.equalTo(353)
            make.height.equalTo(309)
        }
        
        contentView.addSubview(explainEntireView)
        explainEntireView.snp.makeConstraints { make in
            make.top.equalTo(tastingNoteView.snp.bottom).offset(10.5)
            make.leading.trailing.equalTo(tastingNoteView)
            make.height.greaterThanOrEqualTo(116)
        }
        
        let stackView = UIStackView(arrangedSubviews: [goToReviewButton, goToShopButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 9
                
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(explainEntireView.snp.bottom).offset(30)
            make.leading.trailing.equalTo(explainEntireView)
            make.height.greaterThanOrEqualTo(50)
            make.bottom.equalToSuperview().inset(20)
        }
        
        goToReviewButton.snp.makeConstraints { make in
            make.width.equalTo(goToShopButton)
        }
        
        contentView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(20)
        }
        
        let AromaLabel = explainLabel()
        AromaLabel.text = "Aroma"
        
        let TasteLabel = explainLabel()
        TasteLabel.text = "Taste"
        
        let FinishLabel = explainLabel()
        FinishLabel.text = "Finish"
        
        explainEntireView.addSubview(AromaLabel)
        explainEntireView.addSubview(TasteLabel)
        explainEntireView.addSubview(FinishLabel)
        
        AromaLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(23)
            make.leading.equalToSuperview().offset(33)
        }
        
        TasteLabel.snp.makeConstraints { make in
            make.top.equalTo(AromaLabel)
            make.centerX.equalToSuperview()
        }
        
        FinishLabel.snp.makeConstraints { make in
            make.top.equalTo(TasteLabel)
            make.trailing.equalToSuperview().inset(33)
        }
        
        let Aroma = explainView()
        Aroma.setTitle("블루베리", for: .normal)
        Aroma.sizeToFit()
        Aroma.contentEdgeInsets = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20)
        
        let Taste = explainView()
        Taste.setTitle("자두", for: .normal)
        Taste.sizeToFit()
        Taste.contentEdgeInsets = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20)
        
        let Finish = explainView()
        Finish.setTitle("스모키", for: .normal)
        Finish.sizeToFit()
        Finish.contentEdgeInsets = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20)
        
        explainEntireView.addSubview(Aroma)
        explainEntireView.addSubview(Taste)
        explainEntireView.addSubview(Finish)
        
        Aroma.snp.makeConstraints { make in
            make.top.equalTo(AromaLabel.snp.bottom).offset(7)
            make.centerX.equalTo(AromaLabel)
        }
        
        Taste.snp.makeConstraints { make in
            make.top.equalTo(Aroma)
            make.centerX.equalTo(TasteLabel)
        }
        
        Finish.snp.makeConstraints { make in
            make.top.equalTo(Taste)
            make.centerX.equalTo(FinishLabel)
        }
    }
}
