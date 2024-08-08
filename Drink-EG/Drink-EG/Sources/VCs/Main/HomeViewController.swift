//
//  HomeViewController.swift
//  Drink-EG
//
//  Created by 김도연 on 7/20/24.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
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
    
    private var AdContents: [String] = ["1", "2"]
    private var RecomContents: [String] = ["Red Label", "Castello Monaci", "Loxton"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named:"icon_back")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named:"icon_back")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor = .black
        
        view.backgroundColor = .white
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
            
        // 버튼 하단에 노란색으로 칠하는 layer 추가
        let yellowLayer = CALayer()
        yellowLayer.frame = CGRect(x: 0, y: 72, width: goToNoteButton.frame.width, height: goToNoteButton.frame.height - 72)
        yellowLayer.backgroundColor = UIColor(hue: 0.1528, saturation: 0.16, brightness: 1, alpha: 0.8).cgColor
                    
        // 버튼에 layer 추가
        goToNoteButton.layer.addSublayer(yellowLayer)
        
        //layer 위에 label 추가
        let titleLabel = UILabel()
        titleLabel.text = "테이스팅 노트 바로가기"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        goToNoteButton.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(86)
            make.leading.equalToSuperview().offset(18)
        }
        
        let goToIcon = UIImageView()
        goToIcon.image = UIImage(named: "icon_goTo")
        goToNoteButton.addSubview(goToIcon)
        goToIcon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(86)
            make.trailing.equalToSuperview().inset(12)
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
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(34)
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
            make.width.equalTo(356)
            make.height.equalTo(247)
        }
                
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(AdImageCollectionView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        contentView.addSubview(firstLine)
        
        firstLine.snp.makeConstraints {make in
            make.top.equalTo(pageControl.snp.bottom).offset(12)
            make.leading.trailing.equalTo(AdImageCollectionView)
        }
        
        contentView.addSubview(RecomCollectionView)
        
        RecomCollectionView.snp.makeConstraints { make in
            make.top.equalTo(firstLine.snp.bottom).offset(13)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalTo(AdImageCollectionView)
            make.height.equalTo(166)
        }
        
        contentView.addSubview(NoteLabel)
        NoteLabel.snp.makeConstraints { make in
            make.top.equalTo(RecomCollectionView.snp.bottom).offset(35)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(23)
        }
        
        contentView.addSubview(goToNoteButton)
        goToNoteButton.snp.makeConstraints { make in
            make.top.equalTo(NoteLabel.snp.bottom).offset(22)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(23)
            make.height.greaterThanOrEqualTo(119)
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
        firstLine.text = "션/위승주 님이 좋아할 만한 와인"
        firstLine.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        guard let text = self.firstLine.text else { return }
        let attributedStr = NSMutableAttributedString(string: text)
        attributedStr.addAttribute(.font, value: UIFont.systemFont(ofSize: 24, weight: .bold), range: (text as NSString).range(of: "션/위승주"))
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
        
        goToNoteButton.addTarget(self, action: #selector(noteButtonTapped), for: .touchUpInside)

    }
    
    @objc private func noteButtonTapped() {
        let noteListViewController = NoteListViewController()
        navigationController?.pushViewController(noteListViewController, animated: true)
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
                
        return cv
    }()
    
    lazy var pageControl: UIPageControl = {
        let p = UIPageControl()
        p.pageIndicatorTintColor = UIColor(hue: 0, saturation: 0, brightness: 0.85, alpha: 1.0)
        p.currentPageIndicatorTintColor = UIColor(hue: 0, saturation: 0, brightness: 0.46, alpha: 1.0)
        return p
    }()
    
    lazy var RecomCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
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
            
            cell.configure(imageName: RecomContents[indexPath.item])
            return cell
            
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 2 {
            let wineInfoViewController = WineInfoViewController()
            navigationController?.pushViewController(wineInfoViewController, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 1 {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
        else if collectionView.tag == 2 {
            return CGSize(width: collectionView.frame.height - 4, height: collectionView.frame.height)
        }
        return CGSize.zero
    }
}
    
    

