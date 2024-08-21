//
//  WineClassMainViewController.swift
//  Drink-EG
//
//  Created by 김도연 on 7/21/24.
//

import UIKit
import SnapKit
import Moya
import SDWebImage

class WineClassMainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate, UICollectionViewDelegateFlowLayout {
    
    let provider = MoyaProvider<WineClassAPI>(plugins: [CookiePlugin()])
    
    var mainClassView: UICollectionView!
    var subClassView: UICollectionView!
    
    let titleclassLabel = UILabel()
    let subtitleclassLabel = UILabel()
    
    var containerView = UIView()
    
    private let bottomView = UIView()
    
    var videoInfo : [WineClassResponse] = []
    
//    let ImageName: [String] = ["Castello Monaci", "Dos Copas", "Loxton", "Red Label", "Samos", "Vendredi"]
    
    lazy var searchBar: UISearchBar = {
        let s = UISearchBar()
        s.delegate = self
        s.searchBarStyle = .minimal
        s.layer.cornerRadius = UIConstants.searchBarCornerRadius
        s.layer.masksToBounds = true
        
        if let searchIcon = UIImage(named: "icon_search") {
            s.setImage(searchIcon, for: .search, state: .normal)
        }
        if let textField = s.value(forKey: "searchField") as? UITextField {
            let placeholderText = "제목, 연관 내용 검색"
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor(hue: 0, saturation: 0, brightness: 0.45, alpha: 1.0),
                .font: UIFont.boldSystemFont(ofSize: 12)
            ]
            textField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        }
        s.searchTextField.backgroundColor = UIColor(hex: "#E5E5E5")
        
        return s
    }()
    
    private let label: UILabel = {
        let l = UILabel()
        l.text = "와인 클래스"
        l.font = .systemFont(ofSize: UIConstants.labelFontSize, weight: UIFont.Weight(rawValue: 700))
        l.textColor = .black
        l.numberOfLines = 0
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavigationBarButton()
        callGetAllClass { isSucess in
            if isSucess {
                self.setupAllUI()
            } else {
                print("400 서버 에러")
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        setGradientColor(containerView)
        roundTopRightCorner(view: containerView, cornerRadius: 30)
        roundTopRightCorner(view: bottomView, cornerRadius: 30)
//        viewOuterShadow(view: containerView)
        viewOuterShadow(view: bottomView)
    }
    
    private func callGetAllClass(completion: @escaping (Bool) -> Void) {
        provider.request(.getAllWineClass) { result in
            switch result {
            case .success(let response):
                do {
                    let data = try response.map(APIResponseWineClassResponse.self)
//                    print(data)
                    self.videoInfo = data.result
                }
                catch {
                    completion(false)
                }
                completion(true)
            case .failure(let error):
                print("Request failed: \(error)")
                completion(false)
            }
        }
    }
    
    func setupNavigationBarButton() {
        navigationItem.hidesBackButton = false
        let backArrow = UIImage(systemName: "")
        let leftButton = UIBarButtonItem(image: backArrow, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = leftButton
        leftButton.tintColor = .black
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    // 첫번째 뷰 그라데이션
    func setGradientColor(_ view: UIView) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(hex: "#FA735B")?.cgColor ?? UIColor.red.cgColor,
            UIColor.white.cgColor,
            UIColor.clear.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0) // 그라데이션 시작점 (좌상단)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)   // 그라데이션 끝점 (우하단)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    fileprivate func setupAllUI() {
        // Label 설정
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(27)
        }
        
        // SearchBar 설정
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(10)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.greaterThanOrEqualTo(UIConstants.searchBarHeight)
        }
        
        // 새로운 UIView 추가
        containerView.applyTopShadow()
        setGradientColor(containerView)
        roundTopRightCorner(view: containerView, cornerRadius: 30)
        
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        setupTitleClassLabel()
        
        let button = CustomButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(titleclassLabel)
        containerView.addSubview(button)
        titleclassLabel.snp.makeConstraints { l in
            l.top.equalTo(containerView.snp.top).offset(20)
            l.leading.equalTo(containerView.snp.leading).offset(20)
            l.width.greaterThanOrEqualTo(30)
        }
        
        button.snp.makeConstraints { b in
            b.top.equalTo(titleclassLabel.snp.top)
            b.trailing.equalTo(containerView.snp.trailing).inset(20)
            b.height.greaterThanOrEqualTo(16)
            b.width.greaterThanOrEqualTo(30)
        }
        
        setupMainClassView()
        containerView.addSubview(mainClassView)
        mainClassView.snp.makeConstraints { make in
            make.top.equalTo(button.snp.bottom).offset(10)
            make.leading.trailing.equalTo(containerView).inset(10)
            make.height.equalTo(containerView.snp.height).multipliedBy(0.33)
        }
        
        bottomView.backgroundColor = .white // 원하는 배경색으로 변경
        roundTopRightCorner(view: bottomView, cornerRadius: 30)
        viewOuterShadow(view: bottomView)
//        bottomView.applyTopShadow()
        
        containerView.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.height.equalTo(containerView.snp.height).multipliedBy(0.55)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        setupSubTitleClassLabel()
        bottomView.addSubview(subtitleclassLabel)
        subtitleclassLabel.snp.makeConstraints { make in
            make.top.equalTo(bottomView.snp.top).offset(20)
            make.leading.equalTo(bottomView.snp.leading).offset(20)
        }
        
        setupMain2ClassView()
        bottomView.addSubview(subClassView)
        subClassView.snp.makeConstraints { make in
            make.top.equalTo(subtitleclassLabel.snp.bottom).offset(7)
            make.leading.trailing.equalTo(bottomView).inset(10)
            make.height.equalTo(mainClassView.snp.height)
        }
    }
    
    
    func setupTitleClassLabel() {
        titleclassLabel.text = "15초만에 알아가는 와인 지식"
        titleclassLabel.font = .boldSystemFont(ofSize: UIConstants.titleClassLabelFontSize)
        titleclassLabel.textAlignment = .center
        titleclassLabel.textColor = .black
    }
    
    func setupMainClassView() {
        let layout = CarouselLayout()
//        layout.itemSize = UIConstants.mainClassViewItemSize
        layout.spacing = UIConstants.mainClassViewSpacing
        
        mainClassView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        mainClassView.backgroundColor = .clear
        mainClassView.delegate = self
        mainClassView.dataSource = self
        mainClassView.showsHorizontalScrollIndicator = false
        mainClassView.showsVerticalScrollIndicator = false
        mainClassView.register(WineClassCell.self, forCellWithReuseIdentifier: WineClassCell.reuseIdentifier)
    }
    
    func setupMain2ClassView() {
        let layout = CarouselLayout()
//        layout.itemSize = UIConstants.mainClassViewItemSize
        layout.spacing = UIConstants.mainClassViewSpacing
        
        subClassView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        subClassView.backgroundColor = .clear
        subClassView.delegate = self
        subClassView.dataSource = self
        subClassView.showsHorizontalScrollIndicator = false
        subClassView.showsVerticalScrollIndicator = false
        subClassView.register(WineClassCell.self, forCellWithReuseIdentifier: WineClassCell.reuseIdentifier)
    }
    
    func setupSubTitleClassLabel() {
        subtitleclassLabel.text = "이번 달 와인뉴스"
        subtitleclassLabel.font = .boldSystemFont(ofSize: UIConstants.titleClassLabelFontSize)
        subtitleclassLabel.textAlignment = .center
        subtitleclassLabel.textColor = .black
    }
    
    func setupSubClassView() {
        let layout = CarouselLayout()
        layout.itemSize = UIConstants.mainClassViewItemSize
        layout.spacing = UIConstants.mainClassViewSpacing
        
        subClassView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        subClassView.backgroundColor = .clear
        subClassView.delegate = self
        subClassView.dataSource = self
        subClassView.showsHorizontalScrollIndicator = false
        subClassView.showsVerticalScrollIndicator = false
        subClassView.register(WineClassCell.self, forCellWithReuseIdentifier: WineClassCell.reuseIdentifier)
    }
    
    func roundTopRightCorner(view: UIView, cornerRadius: CGFloat) {
        let path = UIBezierPath(
            roundedRect: view.bounds,
            byRoundingCorners: [.topRight], // 둥글게 만들 모서리 설정
            cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
        )
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        view.layer.mask = mask
    }
    
    func viewOuterShadow(view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowRadius = 30
        view.layer.shadowOpacity = 1
    }
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WineClassCell.reuseIdentifier, for: indexPath) as! WineClassCell
        
        let urlString = "https://img.youtube.com/vi/\(videoInfo[indexPath.row].video)/0.jpg"
        cell.configure(with: urlString)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = ClassVideoViewController()
        let video = videoInfo[indexPath.row]
        ClassVideoViewController.videoData = [video.video, video.title, video.description]
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 동적으로 계산된 크기를 반환합니다.
        let height = collectionView.frame.height * 0.95
        
        return CGSize(width: height*0.6, height: height)
    }
}

