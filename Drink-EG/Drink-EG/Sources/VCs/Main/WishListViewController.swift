//
//  WishListViewController.swift
//  Drink-EG
//
//  Created by 이호연 on 8/16/24.
//

import Foundation
import UIKit

class WishListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private let items = [
        ["title": "19charles", "imageName": "SampleImage", "rating": "4.5", "price": "165,000원"],
        ["title": "19charles", "imageName": "SampleImage", "rating": "4.5", "price": "165,000원"],
        ["title": "19charles", "imageName": "SampleImage", "rating": "4.5", "price": "165,000원"],
        ["title": "19charles", "imageName": "SampleImage", "rating": "4.5", "price": "165,000원"],
    ]

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()

    lazy var contentView: UIView = {
        return UIView()
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "위시리스트"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        return label
    }()

    lazy var lowerCollectionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.layer.cornerRadius = 10
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupScrollView()
        setupView()
        setupNavigationBarButton()
        setupWishCommunityLowerCollectionView()
        setupStackViewConstraints()
        setupTitleLabel()
    }

    func setupView() {
        contentView.addSubview(lowerCollectionStackView)
        contentView.addSubview(titleLabel)
    }

    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.height.greaterThanOrEqualTo(view.snp.height).offset(500)
        }
    }

    func setupNavigationBarButton() {
        navigationItem.hidesBackButton = true
        let backArrow = UIImage(systemName: "chevron.backward")
        let leftButton = UIBarButtonItem(image: backArrow, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = leftButton
        leftButton.tintColor = .black
    }

    func setupTitleLabel() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(66)
            make.leading.equalTo(view).offset(16)
        }
    }

    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    func setupWishCommunityLowerCollectionView() {
        for item in items {
            let collectionView = WishCustomCollectionViewCell(frame: .zero)
            collectionView.backgroundColor = UIColor.lightGray
            collectionView.configure(title: item["title"]!, imageName: item["imageName"]!, rating: item["rating"]!, price: item["price"]!)
            collectionView.layer.cornerRadius = 10
            collectionView.layer.masksToBounds = true
            collectionView.contentView.layer.cornerRadius = 10
            collectionView.contentView.layer.masksToBounds = true
            collectionView.snp.makeConstraints { make in
                make.height.equalTo(120) // Increased height to accommodate price
                make.width.equalTo(366)
            }
            lowerCollectionStackView.addArrangedSubview(collectionView)
        }
    }

    func setupStackViewConstraints() {
        lowerCollectionStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.centerX.equalTo(contentView.snp.centerX)
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WishCustomCollectionViewCell", for: indexPath) as! WishCustomCollectionViewCell
        let item = items[indexPath.item]
        cell.configure(title: item["title"]!, imageName: item["imageName"]!, rating: item["rating"]!, price: item["price"]!)
        return cell
    }
}

class WishCustomCollectionViewCell: UICollectionViewCell {
    let titleLabel = UILabel()
    let imageView = UIImageView()
    let ratingLabel = UILabel()
    let priceLabel = UILabel() // Price label
    let likeButton = UIButton(type: .custom)
    
    private let likeImage = UIImage(systemName: "heart.circle.fill")
    private let nlikeImage = UIImage(systemName: "heart.circle.fill")

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        contentView.clipsToBounds = true
        
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true

        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(priceLabel) // Add the price label
        contentView.addSubview(likeButton)

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10

        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)

        ratingLabel.textColor = .black
        ratingLabel.font = UIFont.systemFont(ofSize: 12)
        
        priceLabel.textColor = .black
        priceLabel.font = UIFont.systemFont(ofSize: 16) // Set font size for price label
        
        configureLikeButton()
        setupConstraints()
    }

    func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(80)
            make.leading.equalTo(contentView.snp.leading).offset(8)
            make.centerY.equalTo(contentView.snp.centerY)
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(8)
            make.top.equalTo(contentView.snp.top).offset(10)
        }

        ratingLabel.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.snp.trailing).offset(-8)
            make.top.equalTo(titleLabel.snp.top)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
        likeButton.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.snp.trailing).offset(-8)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
            make.width.height.equalTo(24) // Set size for the like button
        }
    }

    func configure(title: String, imageName: String, rating: String, price: String) {
        titleLabel.text = title
        imageView.image = UIImage(named: imageName)
        ratingLabel.text = rating
        priceLabel.text = price // Configure price label
    }

    private func configureLikeButton() {
        likeButton.setImage(nlikeImage?.withRenderingMode(.alwaysOriginal), for: .normal)
        likeButton.backgroundColor = .clear
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }

    @objc private func likeButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected {
            sender.setImage(likeImage?.withRenderingMode(.alwaysOriginal), for: .selected)
        } else {
            sender.setImage(nlikeImage?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
