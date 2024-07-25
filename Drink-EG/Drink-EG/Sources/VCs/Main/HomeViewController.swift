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
    typealias ImageCell = AdImageCollectionViewCell
    
    private var cardContents: [String] = ["red.png", "orange.png", "yellow.png", "green.png", "blue.png"]

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
            make.center.equalToSuperview()
            make.width.equalTo(edge)
        }
                
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(AdImageCollectionView.snp.bottom).offset(-30)
            make.left.right.equalToSuperview()
        }
        
        view.addSubview(firstLine)
        
        firstLine.snp.makeConstraints {make in
            make.top.equalTo(AdImageCollectionView.snp.bottom).offset(23)
            make.leading.trailing.equalTo(AdImageCollectionView)
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
        firstLine.numberOfLines = 0  // 여러 줄을 지원하도록 설정
        firstLine.text = "션/위승주 님이 좋아할 만한 술"
        firstLine.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        guard let text = self.firstLine.text else { return }
        
        let attributedStr = NSMutableAttributedString(string: text)
        attributedStr.addAttribute(.font, value: UIFont.systemFont(ofSize: 27, weight: .bold), range: (text as NSString).range(of: "션/위승주"))
        attributedStr.addAttribute(.foregroundColor, value: UIColor.orange, range: (text as NSString).range(of: "션/위승주"))
        self.firstLine.attributedText = attributedStr
    }
    
    lazy var AdImageCollectionView: UICollectionView = {
        // collection view layout setting
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.footerReferenceSize = .zero
        layout.headerReferenceSize = .zero
                
        // collection view setting
        let x = UICollectionView(frame: .zero, collectionViewLayout: layout)
        x.isScrollEnabled = true
        x.isPagingEnabled = true
        x.showsHorizontalScrollIndicator = false
        x.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
        x.delegate = self
        x.dataSource = self
                
        // UI setting
        x.backgroundColor = UIColor.black
        x.layer.cornerRadius = 16
                
        return x
    }()
    
    lazy var pageControl = UIPageControl()
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
        pageControl.numberOfPages = cardContents.count
        return self.cardContents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        
        cell.configure(image: cardContents[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
    
    

