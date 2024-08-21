//
//  HomeViewController.swift
//  Drink-EG
//
//  Created by 김도연 on 7/20/24.
//

import UIKit
import SnapKit
import Moya
import SDWebImage
import SafariServices
import SwiftyToaster

class HomeViewController: UIViewController {
    
    let provider = MoyaProvider<SearchAPI>(plugins: [CookiePlugin()])
    let shoppingListManager = ShoppingListManager.shared
    
    private var AdContents: [String] = ["ad1", "ad2", "ad3"]
    private var AdLinks: [String] = ["https://www.instagram.com/drinkeg.official?igsh=eGoyYzkxNmh5bXR5","https://www.7-eleven.co.kr/event/eventList.asp", "https://github.com/Drink-Easy/moblie-iOS-native"]
    private var RecomContents: [RecommendWineResponse] = []
    var name: String = ""
    
    var selectedWine: String?
    
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
    
    let searchButton = UIButton(type: .system)
    let cartButton = UIButton(type: .system)
    let goToNoteButton = UIButton(type: .system)
    let firstLine = UILabel()
    let NoteLabel = UILabel()
    
    lazy var badgeLabel: UILabel = {
      let label = UILabel(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
      label.translatesAutoresizingMaskIntoConstraints = false
      label.layer.cornerRadius = label.bounds.size.height / 2
      label.textAlignment = .center
      label.layer.masksToBounds = true
      label.textColor = .white
      label.font = .boldSystemFont(ofSize: 10)
      label.backgroundColor = UIColor(hex: "FF7A6D")
      return label
    }()
    
    private func showBadge() {
        badgeLabel.text = "\(shoppingListManager.myCartWines.count)"
        
        // 장바구니가 비어 있는지 확인
        if shoppingListManager.myCartWines.isEmpty {
            // 장바구니가 비어 있으면 badgeLabel을 cartButton에서 제거
            badgeLabel.removeFromSuperview()
        } else {
            // 장바구니에 아이템이 있으면 badgeLabel을 cartButton에 추가
            if badgeLabel.superview == nil {
                cartButton.addSubview(badgeLabel)
            }
            badgeLabel.snp.makeConstraints { make in
                make.centerX.equalTo(cartButton.snp.centerX).offset(10)
                make.top.equalTo(cartButton).inset(2)
                make.width.height.equalTo(16)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        view.backgroundColor = .white
        getHomeInfo { [weak self] isSuccess in
            if isSuccess {
                self?.RecomCollectionView.reloadData()
                self?.setupUI()
            } else {
                print("GET 호출 실패")
                Toaster.shared.makeToast("503 Service Unavailable", .short)
            }
        }
        
        // 버튼 하단에 붉은색으로 칠하는 layer 추가
        let Layer = CALayer()
        Layer.name = "redLayer" // 레이어 식별용 이름 설정
        Layer.backgroundColor = UIColor(hue: 0.0417, saturation: 0.19, brightness: 1, alpha: 0.8).cgColor
        goToNoteButton.layer.addSublayer(Layer)
        
        // layer 위에 label 추가
        let titleLabel = UILabel()
        titleLabel.text = "테이스팅 노트 작성하기"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        goToNoteButton.addSubview(titleLabel)
        
        let goToIcon = UIImageView()
        goToIcon.image = UIImage(named: "icon_goTo")
        goToNoteButton.addSubview(goToIcon)
        
        // 초기 레이아웃 설정
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(86) // 초기 위치 (임시 값)
            make.leading.equalToSuperview().offset(18)
        }
        
        goToIcon.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel) // 초기 위치 (임시 값)
            make.trailing.equalToSuperview().inset(12)
        }
    }
    
    // 홈으로 갈 때마다 쇼핑카트 badge의 상태가 업데이트
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // badgeLabel 업데이트
        showBadge()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Layer의 크기 및 위치 조정
        if let Layer = goToNoteButton.layer.sublayers?.first(where: { $0.name == "redLayer" }) {
            let width = goToNoteButton.frame.width
            let height = width * (47.0 / 353.0)
            Layer.frame = CGRect(x: 0, y: goToNoteButton.bounds.height - height, width: width, height: height)
        }
        
        // titleLabel의 위치 조정
        if let titleLabel = goToNoteButton.subviews.compactMap({ $0 as? UILabel }).first {
            titleLabel.snp.updateConstraints { make in
                make.top.equalTo(goToNoteButton.bounds.height - (goToNoteButton.frame.width * (47.0 / 353.0)) + 14)
            }
        }
    }
    
    private func setupUI() {
        // 검색 버튼 설정
        configureSearchButton()
        // 장바구니 버튼 설정
        configureCartButton()
        // label 설정
        configureLabel()
        // 노트 바로가기 버튼 설정
        configureNoteButton()
        
        // StackView 설정
        let stackView = UIStackView(arrangedSubviews: [searchButton, cartButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        
        view.addSubview(stackView)
        
        // SnapKit을 사용하여 제약 조건 설정
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.greaterThanOrEqualTo(34)
        }
        
        searchButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.88)
        }
        
        cartButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.12)
        }
        
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.height.greaterThanOrEqualTo(scrollView.snp.height).priority(.low)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        contentView.addSubview(AdImageCollectionView)
        contentView.addSubview(pageControl)
        
        AdImageCollectionView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalTo(stackView)
            make.height.equalTo(AdImageCollectionView.snp.width).multipliedBy(247.0/356.0)
        }
        
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(AdImageCollectionView.snp.bottom).offset(8)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.addSubview(firstLine)
        
        firstLine.snp.makeConstraints {make in
            make.top.equalTo(pageControl.snp.bottom).offset(12)
            make.leading.equalTo(AdImageCollectionView)
        }
        
        contentView.addSubview(RecomCollectionView)
        
        RecomCollectionView.snp.makeConstraints { make in
            make.top.equalTo(firstLine.snp.bottom).offset(13)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(AdImageCollectionView)
            make.height.greaterThanOrEqualTo(166)
            
        }
        
        contentView.addSubview(NoteLabel)
        NoteLabel.snp.makeConstraints { make in
            make.top.equalTo(RecomCollectionView.snp.bottom).offset(35)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(23)
        }
        
        contentView.addSubview(goToNoteButton)
        goToNoteButton.snp.makeConstraints { make in
            make.top.equalTo(NoteLabel.snp.bottom).offset(20)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(23)
            make.height.equalTo(AdImageCollectionView.snp.width).multipliedBy(119.0/353.0)
            make.bottom.equalToSuperview().inset(20)
        }
        
        contentView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(20)
        }
    }
    
    private func configureSearchButton() {
        searchButton.setTitle(" 관심있는 와인을 검색해 보세요!", for: .normal)
        searchButton.setTitleColor(UIColor(hue: 0, saturation: 0, brightness: 0.45, alpha: 1.0), for: .normal)
        searchButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        searchButton.contentHorizontalAlignment = .left
        searchButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 17, bottom: 0, right: 0)
        
        // 검색 버튼의 레이아웃 설정
        searchButton.backgroundColor = UIColor(hue: 0/360, saturation: 0/100, brightness: 89/100, alpha: 1.0)
        searchButton.layer.cornerRadius = 8
        searchButton.layer.masksToBounds = true
        searchButton.layer.borderWidth = 0
        
        // 돋보기 이미지 설정
        searchButton.setImage(UIImage(named: "icon_search"), for: .normal)
        searchButton.tintColor = UIColor(hue: 0, saturation: 0, brightness: 0.4, alpha: 1.0)
        searchButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        
        // 버튼 액션 추가
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    private func configureCartButton() {
        cartButton.setTitle("", for: .normal)
        
        // 장바구니 이미지 설정
        let cartImage = UIImage(named: "icon_cart")
        cartButton.setImage(cartImage, for: .normal)
        cartButton.tintColor = UIColor(hue: 0, saturation: 0, brightness: 0.4, alpha: 1.0)
        
        // 장바구니 버튼의 레이아웃 설정
        cartButton.backgroundColor = .clear  // 배경색 제거
        cartButton.layer.cornerRadius = 0   // 모서리 반경 제거
        cartButton.layer.borderWidth = 0    // 테두리 제거
        
        // 버튼 액션 추가
        cartButton.addTarget(self, action: #selector(cartButtonTapped), for: .touchUpInside)
    }
    
    @objc private func searchButtonTapped() {
        let searchHomeViewController = SearchHomeViewController()
        navigationController?.pushViewController(searchHomeViewController, animated: true)
    }
    
    @objc private func cartButtonTapped() {
        let shoppingCartListViewController = ShoppingCartListViewController()
        navigationController?.pushViewController(shoppingCartListViewController, animated: true)
    }
    
    private func configureLabel() {
        firstLine.text = "\(name) 님이 좋아할 만한 와인"
        firstLine.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        guard let text = self.firstLine.text else { return }
        let attributedStr = NSMutableAttributedString(string: text)
        attributedStr.addAttribute(.font, value: UIFont.systemFont(ofSize: 24, weight: .bold), range: (text as NSString).range(of: "\(name)"))
        self.firstLine.attributedText = attributedStr
        
        NoteLabel.text = "테이스팅 노트"
        NoteLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
    }
    
    private func configureNoteButton() {
        goToNoteButton.backgroundColor = UIColor(hue: 0/360, saturation: 0/100, brightness: 89/100, alpha: 1.0)
        goToNoteButton.layer.cornerRadius = 10
        goToNoteButton.layer.masksToBounds = true
        goToNoteButton.layer.borderWidth = 0
        
        goToNoteButton.setImage(UIImage(named: "HomeGoToTastingNote")?.withRenderingMode(.alwaysOriginal), for: .normal)
        goToNoteButton.contentVerticalAlignment = .fill
        goToNoteButton.contentHorizontalAlignment = .fill
        
        goToNoteButton.addTarget(self, action: #selector(noteButtonTapped), for: .touchUpInside)
        
    }
    
    @objc private func noteButtonTapped() {
        let addNewNoteViewController = AddNewNoteViewController()
        navigationController?.pushViewController(addNewNoteViewController, animated: true)
    }
    
    lazy var AdImageCollectionView: UICollectionView = {
        // collection view layout setting
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.footerReferenceSize = .zero
        layout.headerReferenceSize = .zero
        
        // collection view setting
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isScrollEnabled = true
        cv.isPagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        cv.register(AdImageCollectionViewCell.self, forCellWithReuseIdentifier: "AdImageCollectionViewCell")
        cv.delegate = self
        cv.dataSource = self
        cv.tag = 1
        
        // UI setting
        cv.backgroundColor = .clear
        cv.layer.cornerRadius = 16
        cv.layer.shadowOpacity = 0.3
        cv.layer.shadowColor = UIColor.black.cgColor
        cv.layer.shadowOffset = CGSize(width: 0, height: 2)
        cv.layer.shadowRadius = 5
        cv.layer.masksToBounds = false
        
        return cv
    }()
    
    lazy var pageControl: UIPageControl = {
        let p = UIPageControl()
        p.pageIndicatorTintColor = UIColor(hex: "#D9D9D9")
        p.currentPageIndicatorTintColor = UIColor(hex: "#FF7A6D")
        return p
    }()
    
    lazy var RecomCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10 // 셀 사이의 간격
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // 컬렉션뷰의 양 끝에 패딩 추가
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(RecomCollectionViewCell.self, forCellWithReuseIdentifier: "RecomCollectionViewCell")
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        cv.tag = 2
        
        cv.decelerationRate = .fast
        cv.backgroundColor = .clear
        cv.layer.cornerRadius = 10
        
        return cv
    }()
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // page control 설정.
        if scrollView.frame.size.width != 0 {
            let value = (scrollView.contentOffset.x / scrollView.frame.width)
            pageControl.currentPage = Int(round(value))
        }
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            pageControl.numberOfPages = AdContents.count
            return self.AdContents.count
        }
        else if collectionView.tag == 2 {
            return self.RecomContents.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdImageCollectionViewCell", for: indexPath) as! AdImageCollectionViewCell
            
            cell.configure(image: AdContents[indexPath.item])
            return cell
        }
        else if collectionView.tag == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecomCollectionViewCell", for: indexPath) as! RecomCollectionViewCell
            
            let recom = RecomContents[indexPath.row]
            cell.configure(recom: recom)
            return cell
            
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 1 {
            let adURL = NSURL(string: AdLinks[indexPath.row])
            let adSafariView: SFSafariViewController = SFSafariViewController(url: adURL! as URL)
            self.present(adSafariView, animated: true, completion: nil)
        }
        if collectionView.tag == 2 {
            let selectedWine = RecomContents[indexPath.row]
            let wineInfoViewController = WineInfoViewController()
            wineInfoViewController.name.text = selectedWine.wineName
            wineInfoViewController.wineImageURL = selectedWine.imageUrl
            wineInfoViewController.wineId = selectedWine.wineId
            navigationController?.pushViewController(wineInfoViewController, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 1 {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
        else if collectionView.tag == 2 {
            return CGSize(width: ((collectionView.frame.height)*0.9), height: ((collectionView.frame.height)*0.9))
        }
        return CGSize.zero
    }
    
    func getHomeInfo(completion: @escaping (Bool) -> Void) {
        provider.request(.getHomeInfo) { result in
            switch result {
            case .success(let response):
                do {
                    if let jsonString = String(data: response.data, encoding: .utf8) {
//                        print("Received JSON: \(jsonString)")
                    }
                    let responseData = try JSONDecoder().decode(APIResponseHomeResponse.self, from: response.data)
                    self.name = responseData.result.name
                    SelectionManager.shared.userName = responseData.result.name
                    self.RecomContents = responseData.result.recommendWineDTOs
                    self.RecomCollectionView.reloadData()
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



