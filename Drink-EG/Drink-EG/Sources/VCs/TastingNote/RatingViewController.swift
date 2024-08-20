//
//  RatingViewController.swift
//  Drink-EG
//
//  Created by 이수현 on 8/13/24.
//

import UIKit
import SnapKit
import Moya
import Cosmos

class RatingViewController: UIViewController, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
    var selectedWineSort: String?
    var selectedWineArea: String?
    var textValue = CGFloat(0)
    var aromaCollectionView : UICollectionView!
    var tasteCollectionView: UICollectionView!
    var finishCollectionView: UICollectionView!
    
    let provider = MoyaProvider<TastingNoteAPI>(plugins: [CookiePlugin()])
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        reviewText.delegate = self
        
        setupNavigationBarButton()
        setupView()
        setupLabel()
        setuptastingnoteLabelConstraints()
        setupTasteView()
        setupTasteViewConstraints()
        setupAromaLabel()
        setupAromaCollectionView()
        setupTasteLabel()
        setupTasteCollectionView()
        setupFinishLabel()
        setupFinishCollectionView()
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
        
        setupKeyboardEvent()
    }
    
    func setupKeyboardEvent() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        // keyboardFrame: 현재 동작하고 있는 이벤트에서 키보드의 frame을 받아옴
        // currentTextField: 현재 응답을 받고있는 UITextField를 알아냅니다.
        guard let keyboardFrame = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentResponder as? UITextField else { return }
        
        // Y축으로 키보드의 상단 위치
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        // 현재 선택한 텍스트 필드의 Frame 값
        let convertedTextFieldFrame = view.convert(currentTextField.frame,
                                                  from: currentTextField.superview)
        // Y축으로 현재 텍스트 필드의 하단 위치
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
        
        // Y축으로 텍스트필드 하단 위치가 키보드 상단 위치보다 클 때 (즉, 텍스트필드가 키보드에 가려질 때가 되겠죠!)
        if textFieldBottomY > keyboardTopY {
            let textFieldTopY = convertedTextFieldFrame.origin.y
            // 노가다를 통해서 모든 기종에 적절한 크기를 설정함.
            let newFrame = textFieldTopY - keyboardTopY/1.6
            view.frame.origin.y -= newFrame
        }
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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
            make.height.greaterThanOrEqualTo(1600)
        }
    }
    
    func setupLabel() { // Label의 기본 속성을 설정하는 함수
        contentView.addSubview(tastingnoteLabel)
        tastingnoteLabel.text = "테이스팅 노트"
        tastingnoteLabel.font = .systemFont(ofSize: UIConstants.labelFontSize, weight: UIFont.Weight(rawValue: 700))
        tastingnoteLabel.textAlignment = .center
        tastingnoteLabel.textColor = .black
    }
    
    func setuptastingnoteLabelConstraints() { // Label의 제약 조건을 설정하는 함수
        tastingnoteLabel.snp.makeConstraints{ make in
            make.top.equalTo(contentView.snp.top).offset(20)
            make.leading.equalTo(contentView.snp.leading).offset(27)
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
            make.height.greaterThanOrEqualTo(870)
        }
    }
    
    func setupAromaLabel() {
        tasteView.addSubview(aromaLabel)
        aromaLabel.text = "Aroma"
        aromaLabel.textAlignment = .center
        aromaLabel.font = UIFont(name: "Pretendard-SemiBold", size: 20)
        aromaLabel.textColor = .black
        
        aromaLabel.snp.makeConstraints { make in
            make.leading.equalTo(tasteView.snp.leading).offset(15)
            make.top.equalTo(tasteView.snp.top).offset(25)
        }
    }
    
    func setupAromaCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 92, height: 33)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        aromaCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        aromaCollectionView.backgroundColor = .clear
        aromaCollectionView.delegate = self
        aromaCollectionView.dataSource = self
        aromaCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "AromaOptionCell")
        
        tasteView.addSubview(aromaCollectionView)
        aromaCollectionView.snp.makeConstraints { make in
            make.top.equalTo(aromaLabel.snp.bottom).offset(9)
            make.leading.trailing.equalTo(tasteView).inset(16)
            make.height.greaterThanOrEqualTo(230)
        }
    }
    
    func setupTasteLabel() {
        tasteView.addSubview(tasteLabel)
        tasteLabel.text = "Taste"
        tasteLabel.textAlignment = .center
        tasteLabel.font = UIFont(name: "Pretendard-SemiBold", size: 20)
        tasteLabel.textColor = .black
        
        tasteLabel.snp.makeConstraints { make in
            make.leading.equalTo(aromaLabel.snp.leading)
            make.top.equalTo(aromaCollectionView.snp.bottom).offset(20)
        }
    }
    
    func setupTasteCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 92, height: 33)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        tasteCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        tasteCollectionView.backgroundColor = .clear
        tasteCollectionView.delegate = self
        tasteCollectionView.dataSource = self
        tasteCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "TasteOptionCell")
        
        tasteView.addSubview(tasteCollectionView)
        tasteCollectionView.snp.makeConstraints { make in
            make.top.equalTo(tasteLabel.snp.bottom).offset(9)
            make.leading.trailing.equalTo(tasteView).inset(16)
            make.height.greaterThanOrEqualTo(230)
        }
    }
    
    func setupFinishLabel() {
        tasteView.addSubview(finishLabel)
        finishLabel.text = "Finish"
        finishLabel.textAlignment = .center
        finishLabel.font = UIFont(name: "Pretendard-SemiBold", size: 20)
        finishLabel.textColor = .black
        
        finishLabel.snp.makeConstraints { make in
            make.leading.equalTo(tasteLabel.snp.leading)
            make.top.equalTo(tasteCollectionView.snp.bottom).offset(20)
        }
    }
    
    func setupFinishCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 92, height: 33)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        finishCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        finishCollectionView.backgroundColor = .clear
        finishCollectionView.delegate = self
        finishCollectionView.dataSource = self
        finishCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "FinishOptionCell")
        
        tasteView.addSubview(finishCollectionView)
        finishCollectionView.snp.makeConstraints { make in
            make.top.equalTo(finishLabel.snp.bottom).offset(9)
            make.leading.trailing.equalTo(tasteView).inset(16)
            make.height.greaterThanOrEqualTo(230)
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
        reviewText.resignFirstResponder()
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
        patchNoteAPI(wineId: selectedWineId!)
        nextVC.dataList = dataList
        nextVC.selectedOptions = selectedOptions
        nextVC.reviewString = reviewText.text ?? ""
        nextVC.value = value
        nextVC.selectedWineName = selectedWineName
        nextVC.selectedWineImage = selectedWineImage
        nextVC.area = selectedWineArea
        nextVC.sort = selectedWineSort
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
        let wineId = selectedWineId
        let color = receivedColor
        let satisfaction = Int(value)
        let memo = reviewText.text ?? ""
        let scentAroma = selectedOptions["scentAroma"] ?? []
        let scentTaste = selectedOptions["scentTaste"] ?? []
        let scentFinish = selectedOptions["scentFinish"] ?? []
        
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
                    // self.navigationController?.pushViewController(nextVC, animated: true)
                case .failure(let error):
                    print("Failed to post note: \(error)")
                }
            }
    }
    
    func patchNoteAPI(wineId: Int) {
        let color = receivedColor
        let satisfaction = Int(value)
        let review = reviewText.text ?? ""
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
            wineId: wineId,
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
            review: review)) { result in
                switch result {
                case .success(let response):
                    print("Note successfully patched with response: \(response)")
                    // 수정이 성공하면 다음 화면으로 이동
                    let nextVC = CheckNoteViewController()
                    nextVC.dataList = self.dataList
                    nextVC.selectedOptions = self.selectedOptions
                    nextVC.reviewString = review
                    nextVC.value = self.value
                    // self.navigationController?.pushViewController(nextVC, animated: true)
                case .failure(let error):
                    print("Failed to patch note: \(error)")
                }
            }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if collectionView == aromaCollectionView {
                return selectedOptions["scentAroma"]?.count ?? 0
            } else if collectionView == tasteCollectionView {
                return selectedOptions["scentTaste"]?.count ?? 0
            } else if collectionView == finishCollectionView {
                return selectedOptions["scentFinish"]?.count ?? 0
            }
            return 0
        }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseIdentifier: String
        var option: String?
        
        if collectionView == aromaCollectionView {
            reuseIdentifier = "AromaOptionCell"
            option = selectedOptions["scentAroma"]?[indexPath.row]
        } else if collectionView == tasteCollectionView {
            reuseIdentifier = "TasteOptionCell"
            option = selectedOptions["scentTaste"]?[indexPath.row]
        } else {
            reuseIdentifier = "FinishOptionCell"
            option = selectedOptions["scentFinish"]?[indexPath.row]
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        let button = UIButton(type: .system)
        button.setTitle(option, for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(hex: "FBCBC4")
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(hex: "FA8D7B")?.cgColor
        button.layer.cornerRadius = 10
        button.frame = cell.contentView.bounds
        button.layer.masksToBounds = true
        
        cell.contentView.addSubview(button)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let option: String
        
        if collectionView == aromaCollectionView {
            option = selectedOptions["scentAroma"]?[indexPath.row] ?? ""
        } else if collectionView == tasteCollectionView {
            option = selectedOptions["scentTaste"]?[indexPath.row] ?? ""
        } else {
            option = selectedOptions["scentFinish"]?[indexPath.row] ?? ""
        }
        
        // Calculate width based on the title size
        let titleSize = option.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)])
        return CGSize(width: titleSize.width + 37, height: 33)
    }
}



extension UIView {
    func selectedTextField() -> UITextField? {
        for subview in subviews {
            if let textField = subview as? UITextField, textField.isFirstResponder {
                return textField
            } else if let nestedSubview = subview.selectedTextField() {
                return nestedSubview
            }
        }
        return nil
    }
}
