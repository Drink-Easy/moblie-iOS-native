//
//  ReviewListViewController.swift
//  Drink-EG
//
//  Created by 이현주 on 8/15/24.
//

import UIKit
import SnapKit
import Moya

class ReviewListViewController: UIViewController {
    
    let provider = MoyaProvider<SearchAPI>(plugins: [CookiePlugin()])
    
    var wineId: Int?
    var reviewResults: [WineReview] = []
    var wineImage: String?
    
    var score = 4.5
    private let scoreLabel = UILabel()
    
    let customPickerButton = CustomPickerButton()
    let pickerView = UIPickerView()
    let toolbar = UIToolbar()
    let pickerData = ["최신 리뷰 순", "별점 높은 순", "별점 낮은 순"]
    
    private let label: UILabel = {
        let l = UILabel()
        l.text = "다른유저 리뷰"
        l.font = .systemFont(ofSize: 28, weight: UIFont.Weight(700))
        l.textColor = .black
        l.numberOfLines = 0
        return l
    }()
    
    private let stick: UIView = {
        let s = UIView()
        s.backgroundColor = UIColor(hex: "FA735B")
        s.layer.borderWidth = 0
        return s
    }()
    
    var name: UILabel = {
        let l = UILabel()
        l.font = .boldSystemFont(ofSize: 22)
        l.textColor = .black
        l.numberOfLines = 0
        l.adjustsFontSizeToFitWidth = true // 텍스트가 레이블 너비에 맞도록 크기 조정
        l.minimumScaleFactor = 0.5
        return l
    }()
    
    lazy var image: UIImageView = {
        let i = UIImageView()
        i.layer.cornerRadius = 10
        i.layer.masksToBounds = true
        i.layer.borderWidth = 1.5
        i.layer.borderColor = UIColor(hex: "#E5E5E5")?.cgColor
        if let imageUrl = wineImage, let url = URL(string: imageUrl) {
            i.sd_setImage(with: url, placeholderImage: UIImage(named: "Loxton"))
        } else {
            i.image = UIImage(named: "Loxton")
        }
        return i
    }()
    
    lazy var reviewListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 30, left: 0, bottom: 40, right: 0)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(ReviewListCollectionViewCell.self, forCellWithReuseIdentifier: "ReviewListCollectionViewCell")
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        
        cv.decelerationRate = .fast
        cv.backgroundColor = UIColor(hex: "#E5E5E5")
        cv.layer.cornerRadius = 25
        cv.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        
        return cv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        view.backgroundColor = .white
        getReviewList(query: self.wineId ?? 1) { [weak self] isSuccess in
            if isSuccess {
                self?.reviewListCollectionView.reloadData()
                self?.setupUI()
            } else {
                print("GET 호출 실패")
            }
        }
    }
    
    private func setupUI() {
        configureScore()
        
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(27)
        }
        
        view.addSubview(stick)
        stick.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(31)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(1.5)
        }
        
        view.addSubview(image)
        image.snp.makeConstraints { make in
            make.top.equalTo(stick.snp.bottom).offset(17)
            make.leading.equalTo(stick)
            make.width.lessThanOrEqualTo(110)
            make.height.lessThanOrEqualTo(140)
        }
        
        view.addSubview(name)
        name.snp.makeConstraints { make in
            make.top.equalTo(image)
            make.leading.equalTo(image.snp.trailing).offset(16)
            make.width.lessThanOrEqualTo(175)
        }
        
        view.addSubview(scoreLabel)
        scoreLabel.snp.makeConstraints { make in
            make.centerY.equalTo(name)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        customPickerButton.setupPickerView(pickerView, toolbar: toolbar, pickerData: pickerData)
        view.addSubview(customPickerButton)
        
        customPickerButton.snp.makeConstraints { make in
            make.bottom.equalTo(image.snp.bottom).offset(10)
            make.trailing.equalTo(stick.snp.trailing)
            make.width.equalTo(customPickerButton.buttonWidth)
            make.height.equalTo(customPickerButton.pickerButtonHeight)
        }
        
        // Setup Picker View
        view.addSubview(pickerView)
        
        pickerView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(200) // 높이 설정
        }
        
        // Setup Toolbar
        view.addSubview(toolbar)
        
        toolbar.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(pickerView.snp.top)
            make.height.equalTo(44) // 높이 설정
        }
        
        view.addSubview(reviewListCollectionView)
        reviewListCollectionView.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(20)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        view.sendSubviewToBack(reviewListCollectionView)
    }
    
    private func configureScore() {
        scoreLabel.text = "★ \(score)"
        scoreLabel.font = .boldSystemFont(ofSize: 14)
        scoreLabel.textColor = UIColor(hex: "#FA735B")
    }
    
}

extension ReviewListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviewResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewListCollectionViewCell", for: indexPath) as! ReviewListCollectionViewCell
        
        let review = reviewResults[indexPath.row]
        cell.configure(review: review)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: 110)
    }
    
    func getReviewList(query: Int, completion: @escaping (Bool) -> Void) {
        provider.request(.getWineReview(wineId: query)) { result in
            switch result {
            case .success(let response):
                do {
                    if let jsonString = String(data: response.data, encoding: .utf8) {
                        print("Received JSON: \(jsonString)")
                    }
                    let responseData = try JSONDecoder().decode(APIResponseWineReviewResponse.self, from: response.data)
                    self.reviewResults = responseData.result
                    if self.reviewResults.isEmpty {
                        let noReview = UILabel()
                        noReview.text = "등록된 리뷰가 없습니다."
                        noReview.font = .boldSystemFont(ofSize: 15)
                        noReview.textColor = UIColor(hex: "#767676")
                        self.reviewListCollectionView.addSubview(noReview)
                        noReview.snp.makeConstraints { make in
                            make.centerX.centerY.equalToSuperview()
                        }
                    }
                    self.reviewListCollectionView.reloadData()
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
}
