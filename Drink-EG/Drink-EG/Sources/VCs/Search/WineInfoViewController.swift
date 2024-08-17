//
//  WineInfoViewController.swift
//  Drink-EG
//
//  Created by 김도연 on 7/21/24.
//

import UIKit
import SnapKit
import SDWebImage
import Moya

class WineInfoViewController: UIViewController {
    
    let provider = MoyaProvider<SearchAPI>(plugins: [CookiePlugin()])
    
    var wineImage: String?
    var wineId: Int?
    
    var sort: String = ""
    var area: String = ""
    var sweetness: Int = 0
    var acid: Int = 0
    var tannin: Int = 0
    var bodied: Int = 0
    var alcohol: Int = 0
    var aroma: String = ""
    var taste: String = ""
    var finish: String = ""
    var scoreDouble: Double = 0.0
    
    let pentagonChart = PolygonChartView()
    lazy var dataList: [RadarChartData] = [RadarChartData(type: .sweetness, value: sweetness),
                                      RadarChartData(type: .acid, value: acid),
                                      RadarChartData(type: .tannin, value: tannin),
                                      RadarChartData(type: .bodied, value: bodied),
                                      RadarChartData(type: .alcohol, value: alcohol)]
    
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
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        if let imageUrl = wineImage, let url = URL(string: imageUrl) {
            iv.sd_setImage(with: url, placeholderImage: UIImage(named: "Loxton"))
        } else {
            iv.image = UIImage(named: "Loxton")
        }
        return iv
    }()
    
    lazy var name: UILabel = {
        let l = UILabel()
        l.font = .boldSystemFont(ofSize: 18)
        l.textColor = .black
        l.numberOfLines = 0
        l.adjustsFontSizeToFitWidth = true // 텍스트가 레이블 너비에 맞도록 크기 조정
        l.minimumScaleFactor = 0.7
        return l
    }()
    
    private lazy var specInfo: UILabel = {
        let l = UILabel()
        l.text = "종류: \(sort)\n생산지: \(area)"
        l.font = .systemFont(ofSize: 12)
        l.textColor = .black
        l.numberOfLines = 0
        return l
    }()
    
    private let score: UILabel = {
        let l = UILabel()
        l.font = .boldSystemFont(ofSize: 12)
        l.textColor = UIColor(hex: "#FA735B")
        return l
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
    
    private func createLabel(text: String) -> UILabel {
        let l = UILabel()
        l.font = .boldSystemFont(ofSize: 18)
        l.textColor = .black
        l.text = text
        return l
    }
    
    private func createButton(title: String) -> UIButton {
        let v = UIButton(type: .system)
        v.layer.cornerRadius = 18
        v.layer.masksToBounds = true
        v.backgroundColor = UIColor(hex: "#FBCBC4")
        v.layer.borderWidth = 2
        v.layer.borderColor = UIColor(hue: 0.025, saturation: 0.63, brightness: 0.98, alpha: 0.7).cgColor
            
        v.setTitle(title, for: .normal)
        v.sizeToFit()
        v.contentEdgeInsets = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20)
        v.titleLabel?.font = .boldSystemFont(ofSize: 16)
        v.setTitleColor(.black, for: .normal)
            
        return v
    }
        
    private var AromaLabel: UILabel!
    private var TasteLabel: UILabel!
    private var FinishLabel: UILabel!
    private var Aroma: UIButton!
    private var Taste: UIButton!
    private var Finish: UIButton!
    
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
        reviewListViewController.score = self.scoreDouble
        reviewListViewController.name.text = self.name.text
        reviewListViewController.wineImage = self.wineImage
        reviewListViewController.wineId = self.wineId
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
        wineStoreListViewController.curWine = repackWineData()
        wineStoreListViewController.scoreDouble = self.scoreDouble
        wineStoreListViewController.name.text = self.name.text
        wineStoreListViewController.imageView.image = self.imageView.image
        //reviewListViewController.wineId = self.wineId
        navigationController?.pushViewController(wineStoreListViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        view.backgroundColor = .white
        
        getWineInfo { [weak self] isSuccess in
            if isSuccess {
                self?.setupUI()
            } else {
                print("데이터를 받아오는데 실패했습니다. 다시 시도해주세요.")
            }
        }
    }
    
    private func setupUI() {
        
        setupPentagonChart()
        
        AromaLabel = createLabel(text: "Aroma")
        TasteLabel = createLabel(text: "Taste")
        FinishLabel = createLabel(text: "Finish")
            
        Aroma = createButton(title: aroma)
        Taste = createButton(title: taste)
        Finish = createButton(title: finish)
        
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(27)
        }
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(10)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.height.greaterThanOrEqualTo(scrollView.snp.height).priority(.low)
            make.width.equalTo(scrollView.frameLayoutGuide)
            make.bottom.equalToSuperview().inset(20)
        }
        
        // 상단 와인 정보
        contentView.addSubview(infoView)
        infoView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview().inset(14)
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
            make.width.lessThanOrEqualTo(205)
            make.height.lessThanOrEqualTo(40)
        }
        
        infoView.addSubview(specInfo)
        specInfo.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom).offset(11)
            make.leading.equalTo(name)
        }
        
        infoView.addSubview(score)
        score.snp.makeConstraints { make in
            make.top.equalTo(name.snp.top)
            make.trailing.equalToSuperview().inset(15)
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
            make.centerX.equalToSuperview()
            make.width.equalTo(353)
            make.height.equalTo(309)
        }
        
        contentView.addSubview(explainEntireView)
        explainEntireView.snp.makeConstraints { make in
            make.top.equalTo(tastingNoteView.snp.bottom).offset(10.5)
            make.leading.trailing.equalTo(tastingNoteView)
            make.height.greaterThanOrEqualTo(116)
        }
        
        explainEntireView.addSubview(AromaLabel)
        AromaLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(23)
            make.leading.equalToSuperview().offset(33)
        }
        
        
        explainEntireView.addSubview(TasteLabel)
        TasteLabel.snp.makeConstraints { make in
            make.top.equalTo(AromaLabel)
            make.centerX.equalToSuperview()
        }
        
        explainEntireView.addSubview(FinishLabel)
        FinishLabel.snp.makeConstraints { make in
            make.top.equalTo(TasteLabel)
            make.trailing.equalToSuperview().inset(33)
        }
        
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
        
        // StackView 정의
        // TODO : 함수 분리
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
    }
}

extension WineInfoViewController {
    func getWineInfo(completion: @escaping (Bool) -> Void) {
        provider.request(.getWineInfo(wineId: self.wineId ?? 1)) { result in
            switch result {
            case .success(let response):
                do {
                    
                    if let jsonString = String(data: response.data, encoding: .utf8) {
                        print("Received JSON: \(jsonString)")
                    }
                    
                    let responseData = try JSONDecoder().decode(APIResponseWineInfoResponse.self, from: response.data)
//                    self.handleResponseData()
                    self.sort = responseData.result.sort
                    self.area = responseData.result.area
                    let sugar = Int(responseData.result.sugarContent)
                    self.sweetness = sugar
                    let acidd = Int(responseData.result.acidity)
                    self.acid = acidd
                    let alcoholl = Int(responseData.result.alcohol)
                    self.alcohol = alcoholl
                    let bodyy = Int(responseData.result.body)
                    self.bodied = bodyy
                    let tanninn = Int(responseData.result.tannin)
                    self.tannin = tanninn
                    if (responseData.result.scentAroma.isEmpty) {
                        self.aroma = ""
                    } else {
                        self.aroma = responseData.result.scentAroma[0]
                    }
                    if (responseData.result.scentTaste.isEmpty) {
                        self.taste = ""
                    } else {
                        self.taste = responseData.result.scentTaste[0]
                    }
                    if (responseData.result.scentFinish.isEmpty) {
                        self.finish = ""
                    } else {
                        self.finish = responseData.result.scentFinish[0]
                    }
                    self.scoreDouble = responseData.result.rating
                    let scoreString: String = String(responseData.result.rating)
                    self.score.text = "★ \(scoreString)"
                    
                    completion(true)
                } catch {
                    print("Failed to decode response: \(error)")
                    completion(false)
                }
            case.failure(let error):
                print("Error: \(error.localizedDescription)")
                if let response = error.response {
                    print("Response Body: \(String(data: response.data, encoding: .utf8) ?? "")")
                }
                completion(false)
            }
        }
    }
    
    func handleResponseData(_ data: WineInfo) {
        
    }
    
    func repackWineData() -> Wine {
        return Wine(wineId: self.wineId!, name: self.name.text!, imageUrl: self.wineImage, rating: self.scoreDouble, price: 0)
    }
}
