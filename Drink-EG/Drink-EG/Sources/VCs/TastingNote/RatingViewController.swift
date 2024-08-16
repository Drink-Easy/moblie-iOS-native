//
//  RatingViewController.swift
//  Drink-EG
//
//  Created by 이수현 on 8/13/24.
//

import Foundation
import UIKit
import SnapKit
import Moya
import Cosmos

class RatingViewController: UIViewController {
    
    let tastingnoteLabel = UILabel()
    let scrollView = UIScrollView()
    let contentView = UIView()
    let tasteView = UIView()
    let aromaLabel = UILabel()
    let tasteLabel = UILabel()
    let finishLabel = UILabel()
    let ratingLabel = UILabel()
    let ratingButton = CosmosView()
    let ratingValue = UILabel()
    let vectorView = UIView()
    let reviewLabel = UILabel()
    let reviewText = UITextField()
    let completeButton = UIButton()
    
    var selectedOptions: [String: [String]] = [:]
    var dataList: [RadarChartData] = []
    var value: Double = 0.0
    var receivedColor = ""
    var selectedWineId: Int?
    var selectedWineName: String?
    var selectedWineImage: String?
    
    let provider = MoyaProvider<TastingNoteAPI>(plugins: [CookiePlugin()])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBarButton()
        setupView()
        setupLabel()
        setuptastingnoteLabelConstraints()
        setupTasteView()
        setupTasteViewConstraints()
        setupAromaLabel()
        setupAromaLabelConstraints()
        setupTasteLabel()
        setupTasteLabelConstraints()
        setupFinishLabel()
        setupFinishLabelConstraints()
        setupRatingLabel()
        setupRatingLabelConstraints()
        setupRatingButton()
        setupRatingButtonConstraints()
        setupRatingValue()
        setupRatingValueConstraints()
        setupVectorView()
        setupVectorViewConstraints()
        setupReviewLabel()
        setupReviewLabelConstraints()
        setupReviewText()
        setupReviewTextConstraints()
        setupCompleteButton()
        setupCompleteButtonConstraints()
    }
    
    func setupNavigationBarButton() {
        navigationItem.hidesBackButton = true
        let backArrow = UIImage(systemName: "chevron.backward")
        let leftButton = UIBarButtonItem(image: backArrow, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = leftButton
        leftButton.tintColor = .black
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
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
            make.height.greaterThanOrEqualTo(1500)
        }
    }
    
    func setupLabel() { // Label의 기본 속성을 설정하는 함수
        contentView.addSubview(tastingnoteLabel)
        tastingnoteLabel.text = "테이스팅 노트"
        tastingnoteLabel.font = UIFont(name: "Pretendard-Bold", size: 28)
        tastingnoteLabel.textAlignment = .center
        tastingnoteLabel.textColor = .black
    }
    
    func setuptastingnoteLabelConstraints() { // Label의 제약 조건을 설정하는 함수
        tastingnoteLabel.snp.makeConstraints{ make in
            make.top.equalTo(contentView.snp.top).offset(46)
            make.leading.equalTo(contentView.snp.leading).offset(16)
        }
    }
    
    func setupTasteView() {
        contentView.addSubview(tasteView)
        tasteView.backgroundColor = .clear
        tasteView.layer.borderWidth = 2
        tasteView.layer.borderColor = UIColor(hex: "DFDFE1")?.cgColor
        tasteView.layer.cornerRadius = 10
    }
    
    func setupTasteViewConstraints() {
        tasteView.snp.makeConstraints { make in
            make.top.equalTo(tastingnoteLabel.snp.bottom).offset(50)
            make.centerX.equalTo(contentView.snp.centerX)
            make.leading.equalTo(tastingnoteLabel.snp.leading)
            make.height.greaterThanOrEqualTo(750)
        }
    }
    
    func setupAromaLabel() {
        tasteView.addSubview(aromaLabel)
        aromaLabel.text = "Aroma"
        aromaLabel.textAlignment = .center
        aromaLabel.font = UIFont(name: "Pretendard-SemiBold", size: 20)
        aromaLabel.textColor = .black
    }
    
    func setupAromaLabelConstraints() {
        aromaLabel.snp.makeConstraints { make in
            make.leading.equalTo(tasteView.snp.leading).offset(15)
            make.top.equalTo(tasteView.snp.top).offset(25)
        }
        
        guard let selectedAromaOptions = selectedOptions["Aroma"] else { return }
        let count = selectedAromaOptions.count
        
        var previousButton: UIButton? = nil
        
        for i in 0..<count {
            let button = UIButton(type: .system)
            tasteView.addSubview(button)
            button.setTitle("\(selectedAromaOptions[i])", for: .normal)
            button.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16)
            button.setTitleColor(.black, for: .normal)
            
            button.backgroundColor = UIColor(hex: "FBCBC4")
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor(hex: "FA8D7B")?.cgColor
            button.layer.cornerRadius = 10
            
            
            let titleSize = button.titleLabel!.intrinsicContentSize
            
            button.snp.makeConstraints { make in
                make.width.equalTo(titleSize.width+37)
                make.height.greaterThanOrEqualTo(33)
                
                if i % 4 == 0 {
                    // 첫 번째 버튼이거나 새로운 줄의 첫 번째 버튼
                    make.leading.equalTo(tasteView.snp.leading).offset(13)
                    if i == 0 {
                        make.top.equalTo(aromaLabel.snp.bottom).offset(10)
                    } else {
                        make.top.equalTo(previousButton!.snp.bottom).offset(10)  // 이전 줄의 첫 번째 버튼 아래
                    }
                } else {
                    // 같은 줄의 다른 버튼들
                    make.leading.equalTo(previousButton!.snp.trailing).offset(5)
                    make.centerY.equalTo(previousButton!.snp.centerY)
                }
            }
            previousButton = button
        }
    }
    
    func setupTasteLabel() {
        tasteView.addSubview(tasteLabel)
        tasteLabel.text = "Taste"
        tasteLabel.textAlignment = .center
        tasteLabel.font = UIFont(name: "Pretendard-SemiBold", size: 20)
        tasteLabel.textColor = .black
    }
    
    func setupTasteLabelConstraints() {
        tasteLabel.snp.makeConstraints { make in
            make.leading.equalTo(aromaLabel.snp.leading)
            make.top.equalTo(aromaLabel.snp.bottom).offset(200)
        }
        
        guard let selectedTasteOptions = selectedOptions["Taste"] else { return }
        let count = selectedTasteOptions.count
        
        var previousButton: UIButton? = nil
        
        for i in 0..<count {
            let button = UIButton(type: .system)
            tasteView.addSubview(button)
            button.setTitle("\(selectedTasteOptions[i])", for: .normal)
            button.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16)
            button.setTitleColor(.black, for: .normal)
            
            button.backgroundColor = UIColor(hex: "FBCBC4")
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor(hex: "FA8D7B")?.cgColor
            button.layer.cornerRadius = 10
            
            
            let titleSize = button.titleLabel!.intrinsicContentSize
            
            button.snp.makeConstraints { make in
                make.width.equalTo(titleSize.width+37)
                make.height.greaterThanOrEqualTo(33)
                
                if i % 4 == 0 {
                    // 첫 번째 버튼이거나 새로운 줄의 첫 번째 버튼
                    make.leading.equalTo(tasteView.snp.leading).offset(13)
                    if i == 0 {
                        make.top.equalTo(tasteLabel.snp.bottom).offset(10)
                    } else {
                        make.top.equalTo(previousButton!.snp.bottom).offset(10)  // 이전 줄의 첫 번째 버튼 아래
                    }
                } else {
                    // 같은 줄의 다른 버튼들
                    make.leading.equalTo(previousButton!.snp.trailing).offset(5)
                    make.centerY.equalTo(previousButton!.snp.centerY)
                }
            }
            previousButton = button
        }
    }
    
    func setupFinishLabel() {
        tasteView.addSubview(finishLabel)
        finishLabel.text = "Finish"
        finishLabel.textAlignment = .center
        finishLabel.font = UIFont(name: "Pretendard-SemiBold", size: 20)
        finishLabel.textColor = .black
    }
    
    func setupFinishLabelConstraints() {
        finishLabel.snp.makeConstraints { make in
            make.leading.equalTo(tasteLabel.snp.leading)
            make.top.equalTo(tasteLabel.snp.bottom).offset(200)
        }
        
        guard let selectedFinishOptions = selectedOptions["Finish"] else { return }
        let count = selectedFinishOptions.count
        
        var previousButton: UIButton? = nil
        
        for i in 0..<count {
            let button = UIButton(type: .system)
            tasteView.addSubview(button)
            button.setTitle("\(selectedFinishOptions[i])", for: .normal)
            button.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16)
            button.setTitleColor(.black, for: .normal)
            
            button.backgroundColor = UIColor(hex: "FBCBC4")
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor(hex: "FA8D7B")?.cgColor
            button.layer.cornerRadius = 10
            
            
            let titleSize = button.titleLabel!.intrinsicContentSize
            
            button.snp.makeConstraints { make in
                make.width.equalTo(titleSize.width+37)
                make.height.greaterThanOrEqualTo(33)
                
                if i % 4 == 0 {
                    // 첫 번째 버튼이거나 새로운 줄의 첫 번째 버튼
                    make.leading.equalTo(tasteView.snp.leading).offset(13)
                    if i == 0 {
                        make.top.equalTo(finishLabel.snp.bottom).offset(10)
                    } else {
                        make.top.equalTo(previousButton!.snp.bottom).offset(10)  // 이전 줄의 첫 번째 버튼 아래
                    }
                } else {
                    // 같은 줄의 다른 버튼들
                    make.leading.equalTo(previousButton!.snp.trailing).offset(5)
                    make.centerY.equalTo(previousButton!.snp.centerY)
                }
            }
            previousButton = button
        }
    }
    
    func setupRatingLabel() {
        contentView.addSubview(ratingLabel)
        ratingLabel.text = "별점 평가"
        ratingLabel.textColor = .black
        ratingLabel.textAlignment = .center
        ratingLabel.font = UIFont(name: "Pretendard-Bold", size: 16)
    }
    
    func setupRatingLabelConstraints() {
        ratingLabel.snp.makeConstraints { make in
            make.top.equalTo(tasteView.snp.bottom).offset(40)
            make.leading.equalTo(tasteView.snp.leading)
        }
    }
    
    func setupRatingButton() {
        contentView.addSubview(ratingButton)
        ratingButton.rating = 2.5
        ratingButton.settings.fillMode = .half
        ratingButton.settings.emptyBorderColor = .clear
        ratingButton.settings.starSize = 38
        ratingButton.settings.starMargin = 5
        ratingButton.settings.filledColor = UIColor(hex: "FA735B")!
        ratingButton.settings.emptyColor = UIColor(hex: "D9D9D9")!
        
        ratingButton.didFinishTouchingCosmos = { rating in
            self.ratingValue.text = "\(rating) / 5.0"
            self.value = rating
        }
    }
    
    func setupRatingButtonConstraints() {
        ratingButton.snp.makeConstraints { make in
            make.top.equalTo(ratingLabel.snp.bottom).offset(5)
            make.centerX.equalTo(contentView.snp.centerX)
        }
    }
    
    func setupRatingValue() {
        contentView.addSubview(ratingValue)
        ratingValue.text = "2.5 / 5.0"
        ratingValue.font = UIFont(name: "Pretendard-SemiBold", size: 22)
        ratingValue.textAlignment = .center
    }
    
    func setupRatingValueConstraints() {
        ratingValue.snp.makeConstraints { make in
            make.top.equalTo(ratingButton.snp.bottom).offset(18)
            make.leading.equalTo(ratingButton.snp.leading).offset(50)
            make.centerX.equalTo(ratingButton.snp.centerX)
        }
    }
    
    func setupVectorView() {
        contentView.addSubview(vectorView)
        vectorView.backgroundColor = UIColor(hex: "999999")
    }
    
    func setupVectorViewConstraints() {
        vectorView.snp.makeConstraints { make in
            make.top.equalTo(ratingValue.snp.bottom).offset(19)
            make.leading.equalTo(ratingLabel.snp.leading)
            make.centerX.equalTo(contentView.snp.centerX)
            make.height.equalTo(1)
        }
    }
    
    func setupReviewLabel() {
        contentView.addSubview(reviewLabel)
        reviewLabel.text = "리뷰"
        reviewLabel.textAlignment = .center
        reviewLabel.textColor = .black
        reviewLabel.font = UIFont(name: "Pretendard-Bold", size: 22)
    }
    
    func setupReviewLabelConstraints() {
        reviewLabel.snp.makeConstraints { make in
            make.top.equalTo(vectorView.snp.bottom).offset(47)
            make.leading.equalTo(vectorView.snp.leading)
        }
    }
    
    func setupReviewText() {
        contentView.addSubview(reviewText)
        reviewText.placeholder = "텍스트를 입력해주세요."
        reviewText.layer.cornerRadius = 10
        reviewText.backgroundColor = UIColor(hex: "EAEAEA")
        reviewText.textAlignment = .center
    }
    
    func setupReviewTextConstraints() {
        reviewText.snp.makeConstraints { make in
            make.top.equalTo(reviewLabel.snp.bottom).offset(10)
            make.leading.equalTo(reviewLabel.snp.leading)
            make.centerX.equalTo(contentView.snp.centerX)
            make.height.greaterThanOrEqualTo(237)
        }
    }
    
    func setupCompleteButton() {
        contentView.addSubview(completeButton)
        completeButton.backgroundColor = UIColor(hex: "FA735B")
        completeButton.setTitle("완성하기", for: .normal)
        completeButton.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 20)
        completeButton.titleLabel?.textColor = .white
        completeButton.layer.cornerRadius = 16
        completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
    }
    
    @objc func completeButtonTapped() {
        let nextVC = CheckNoteViewController()
        postNewNoteAPI()
        patchNoteAPI(noteId: 270)
        nextVC.dataList = dataList
        nextVC.selectedOptions = selectedOptions
        nextVC.reviewString = reviewText.text ?? ""
        nextVC.value = value
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func setupCompleteButtonConstraints() {
        completeButton.snp.makeConstraints { make in
            make.top.equalTo(reviewText.snp.bottom).offset(30)
            make.leading.equalTo(reviewText.snp.leading).offset(17)
            make.centerX.equalTo(reviewText.snp.centerX)
            make.height.greaterThanOrEqualTo(60)
        }
    }
    
    func postNewNoteAPI() {
        let wineId = selectedWineId // 수정필요
        let color = receivedColor
        let satisfaction = Int(value)
        let memo = reviewText.text ?? ""
        let scentAroma = selectedOptions["Aroma"] ?? []
        let scentTaste = selectedOptions["Taste"] ?? []
        let scentFinish = selectedOptions["Finish"] ?? []
        
        var sugarContent: Int?
        var acidity: Int?
        var tannin: Int?
        var bodied: Int?
        var alcohol: Int?
        
        for data in dataList {
            switch data.type {
            case .sweetness:
                sugarContent = data.value
            case .acid:
                acidity = data.value
            case .tannin:
                tannin = data.value
            case .bodied:
                bodied = data.value
            case .alcohol:
                alcohol = data.value
            }
        }
        
        provider.request(.postNewNote(
            wineId: wineId!,
            color: color,
            sugarContent: sugarContent ?? 0,
            acidity: acidity ?? 0,
            tannin: tannin ?? 0,
            body: bodied ?? 0,
            alcohol: alcohol ?? 0,
            scentAroma: scentAroma,
            scentTaste: scentTaste,
            scentFinish: scentFinish,
            satisfaction: satisfaction,
            memo: memo)) { result in
                switch result {
                case .success(let response):
                    print("Note successfully posted with response: \(response)")
                    // Navigate to the next screen
                    let nextVC = CheckNoteViewController()
                    nextVC.dataList = self.dataList
                    nextVC.selectedOptions = self.selectedOptions
                    nextVC.reviewString = memo
                    nextVC.value = self.value
                    self.navigationController?.pushViewController(nextVC, animated: true)
                case .failure(let error):
                    print("Failed to post note: \(error)")
                }
            }
    }
    
    func patchNoteAPI(noteId: Int) {
        let wineId = selectedWineId // 수정 필요
        let color = receivedColor
        let satisfaction = Int(value)
        let memo = reviewText.text ?? ""
        let scentAroma = selectedOptions["Aroma"] ?? []
        let scentTaste = selectedOptions["Taste"] ?? []
        let scentFinish = selectedOptions["Finish"] ?? []
        
        var sugarContent: Int?
        var acidity: Int?
        var tannin: Int?
        var bodied: Int?
        var alcohol: Int?
        
        for data in dataList {
            switch data.type {
            case .sweetness:
                sugarContent = data.value
            case .acid:
                acidity = data.value
            case .tannin:
                tannin = data.value
            case .bodied:
                bodied = data.value
            case .alcohol:
                alcohol = data.value
            }
        }
        
        provider.request(.patchNote(
            noteId: noteId,
            wineId: wineId!,
            color: color,
            sugarContent: sugarContent ?? 0,
            acidity: acidity ?? 0,
            tannin: tannin ?? 0,
            body: bodied ?? 0,
            alcohol: alcohol ?? 0,
            scentAroma: scentAroma,
            scentTaste: scentTaste,
            scentFinish: scentFinish,
            satisfaction: satisfaction,
            memo: memo)) { result in
                switch result {
                case .success(let response):
                    print("Note successfully patched with response: \(response)")
                    // 수정이 성공하면 다음 화면으로 이동
                    let nextVC = CheckNoteViewController()
                    nextVC.dataList = self.dataList
                    nextVC.selectedOptions = self.selectedOptions
                    nextVC.reviewString = memo
                    nextVC.value = self.value
                    self.navigationController?.pushViewController(nextVC, animated: true)
                case .failure(let error):
                    print("Failed to patch note: \(error)")
                }
            }
    }
}
