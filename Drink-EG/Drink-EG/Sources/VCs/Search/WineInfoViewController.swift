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
        
        view.addSubview(infoView)
        infoView.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(20)
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
        
        view.addSubview(tastingNoteView)
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
    }
}
