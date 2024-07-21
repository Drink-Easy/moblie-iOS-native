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
}
