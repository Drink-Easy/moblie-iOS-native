//
//  WishListViewController.swift
//  Drink-EG
//
//  Created by 이호연 on 8/16/24.
//

import UIKit
import SnapKit


   
class MyPageWishListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

        private let items = [
            ["title": "Castello Monaci", "imageName": "Castello Monaci", "rating": "4.5", "price": "165,000원"],
            ["title": "Dos Copas", "imageName": "Dos Copas", "rating": "4.5", "price": "34,000 ₩"],
            ["title": "Loxton", "imageName": "Loxton", "rating": "4.5", "price": "12,800 ₩"],
            ["title": "Red Label", "imageName": "Red Label", "rating": "4.5", "price": "56,000 ₩"],
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
            navigationController?.isNavigationBarHidden = false

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
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(46)
                make.leading.equalTo(view).offset(16)
            }
        }

        @objc func backButtonTapped() {
            navigationController?.popViewController(animated: true)
        }

        func setupWishCommunityLowerCollectionView() {
            for item in items {
                let cellView = WishCustomCellView()
                cellView.configure(title: item["title"]!, imageName: item["imageName"]!, rating: item["rating"]!, price: item["price"]!)
                cellView.layer.cornerRadius = 10
                cellView.layer.masksToBounds = true
                
                lowerCollectionStackView.addArrangedSubview(cellView)
    //여기 수정함
                cellView.snp.makeConstraints { make in
                    make.height.equalTo(94)
                    make.trailing.equalTo(view).offset(-16)
                    make.leading.equalTo(view).offset(16)

                }
            }
        }

        func setupStackViewConstraints() {
            lowerCollectionStackView.snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(24)
                make.leading.equalTo(contentView.snp.leading).offset(16)
                make.centerX.equalTo(contentView.snp.centerX)
            }
        }



    }

    class WishCustomCellView: UIView {
        let titleLabel = UILabel()
        let imageView = UIImageView()
        let ratingLabel = UILabel()
        let priceLabel = UILabel() // Price label
        let likeButton = UIButton(type: .custom)
        
        private let likeImage = UIImage(systemName: "heart.circle")
        private let nlikeImage = UIImage(systemName: "heart.fill")

        override init(frame: CGRect) {
            super.init(frame: frame)

            layer.cornerRadius = 10
            layer.masksToBounds = true
            backgroundColor = UIColor(hex: "E5E5E5")

            
        

            addSubview(imageView)
            addSubview(titleLabel)
            addSubview(ratingLabel)
            addSubview(priceLabel) // Add the price label
            addSubview(likeButton)

            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 10

            titleLabel.textColor = .black
            titleLabel.font = UIFont.boldSystemFont(ofSize: 18)

            ratingLabel.textColor = .gray
            ratingLabel.font = UIFont.systemFont(ofSize: 12)
            
            priceLabel.textColor = .gray
            priceLabel.font = UIFont.systemFont(ofSize: 14)
            
            configureLikeButton()
            setupConstraints()
        }

        func setupConstraints() {
            imageView.snp.makeConstraints { make in
                make.width.height.equalTo(80)
                make.leading.equalTo(snp.leading).offset(10)
                make.centerY.equalTo(snp.centerY)
            }

            titleLabel.snp.makeConstraints { make in
                make.leading.equalTo(imageView.snp.trailing).offset(8)
                make.top.equalTo(snp.top).offset(15)
            }

            ratingLabel.snp.makeConstraints { make in
                make.trailing.equalTo(snp.trailing).offset(-8)
                make.top.equalTo(titleLabel.snp.top)
            }
            
            priceLabel.snp.makeConstraints { make in
                make.leading.equalTo(titleLabel.snp.leading)
                make.top.equalTo(titleLabel.snp.bottom).offset(8)
            }
            
            likeButton.snp.makeConstraints { make in
                make.trailing.equalTo(snp.trailing).offset(-8)
                make.bottom.equalTo(snp.bottom).offset(-15)
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
