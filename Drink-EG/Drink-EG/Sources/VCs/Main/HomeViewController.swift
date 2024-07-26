//
//  HomeViewController.swift
//  Drink-EG
//
//  Created by 김도연 on 7/20/24.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    let searchButton = UIButton(type: .system)
    let cartButton = UIButton(type: .system)
    let firstLine = UILabel()
    let secondLine = UILabel()
    
    private var AdContents: [String] = ["red.png", "orange.png", "yellow.png", "green.png", "blue.png"]
    private var RecomContents: [String] = ["Red Label", "Castello Monaci", "Loxton"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        // 검색 버튼 설정
        configureSearchButton()
        // 장바구니 버튼 설정
        configureCartButton()
        // label 설정
        configureLabel()
                
        // StackView 설정
        let stackView = UIStackView(arrangedSubviews: [searchButton, cartButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
                
        view.addSubview(stackView)
                
        // SnapKit을 사용하여 제약 조건 설정
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(38)
        }
                
        searchButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.85)
        }
                
        cartButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.15)
        }
                
        view.addSubview(AdImageCollectionView)
        view.addSubview(pageControl)
                
        let edge = view.frame.width - 50
                
        AdImageCollectionView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(18)
            make.centerX.equalToSuperview()
            make.width.equalTo(edge)
            make.height.equalTo(229)
        }
                
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(AdImageCollectionView.snp.bottom).offset(-30)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(firstLine)
        
        firstLine.snp.makeConstraints {make in
            make.top.equalTo(AdImageCollectionView.snp.bottom).offset(20)
            make.leading.trailing.equalTo(AdImageCollectionView)
        }
        
        view.addSubview(secondLine)
        
//        firstLine.snp.makeConstraints { make in
//            make.top.equalTo(firstLine.snp.bottom).offset(10)
//            make.leading.trailing.equalTo(firstLine)
//        }
        
        view.addSubview(RecomCollectionView)
        
        RecomCollectionView.snp.makeConstraints { make in
            make.top.equalTo(firstLine.snp.bottom).offset(13)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalTo(AdImageCollectionView)
            make.height.equalTo(166)
        }
        
        
    }
    
    private func configureSearchButton() {
        searchButton.setTitle(" 관심있는 와인을 검색해 보세요!", for: .normal)
        searchButton.setTitleColor(.gray, for: .normal)
        searchButton.contentHorizontalAlignment = .left
        searchButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 13, bottom: 0, right: 0)
        
        // 검색 버튼의 레이아웃 설정
        searchButton.backgroundColor = .systemGray6
        searchButton.layer.cornerRadius = 10
        searchButton.layer.borderWidth = 1
        searchButton.layer.borderColor = UIColor.systemGray4.cgColor
        
        // 돋보기 이미지 설정
        let magnifyingGlassImage = UIImage(systemName: "magnifyingglass")
        searchButton.setImage(magnifyingGlassImage, for: .normal)
        searchButton.tintColor = .gray
        searchButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        
        // 버튼 액션 추가
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    private func configureCartButton() {
        cartButton.setTitle("", for: .normal)
            
        // 장바구니 이미지 설정
        let cartImage = UIImage(systemName: "cart")
        cartButton.setImage(cartImage, for: .normal)
        cartButton.tintColor = .black
            
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
        firstLine.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        guard let text = self.firstLine.text else { return }
        
        let attributedStr = NSMutableAttributedString(string: text)
        attributedStr.addAttribute(.font, value: UIFont.systemFont(ofSize: 27, weight: .bold), range: (text as NSString).range(of: "션/위승주"))
        attributedStr.addAttribute(.foregroundColor, value: UIColor.orange, range: (text as NSString).range(of: "션/위승주"))
        self.firstLine.attributedText = attributedStr
        
//        secondLine.text = "최근 스파클링 와인을 자주 즐기고, 한 주에 5만원 이하로 쓰셨군요!"
//        secondLine.font = UIFont.systemFont(ofSize: 10)
//        guard let text1 = self.secondLine.text else { return }
        
//        let attributedStr1 = NSMutableAttributedString(string: text1)
//        attributedStr1.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 10), range: (text1 as NSString).range(of: "스파클링 와인"))
//        attributedStr1.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 10), range: (text1 as NSString).range(of: "5만원 이하"))
//        self.secondLine.attributedText = attributedStr1
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
        cv.backgroundColor = UIColor.black
        cv.layer.cornerRadius = 16
                
        return cv
    }()
    
    lazy var pageControl = UIPageControl()
    
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
    
    

