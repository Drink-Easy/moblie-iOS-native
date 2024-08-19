//
//  MyPageOrderViewController.swift
//  Drink-EG
//
//  Created by 이호연 on 8/16/24.
//

import UIKit
import SnapKit

class MyPageOrderViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    private let items = [
        ["title": "19charles", "detail": "PODO | 165,000원", "imageName": "SampleImage"],
        ["title": "19charles", "detail": "PODO | 165,000원", "imageName": "SampleImage"],
        ["title": "19charles", "detail": "PODO | 165,000원", "imageName": "SampleImage"],
        ["title": "19charles", "detail": "PODO | 165,000원", "imageName": "SampleImage"],
    ]

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()

    lazy var OrdercontentView: UIView = {
        return UIView()
    }()
    
    lazy var OrdertitleLabel: UILabel = {
        let label = UILabel()
        label.text = "와인 주문 내역"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        return label
    }()

    lazy var OrderlowerCollectionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()

    lazy var orderDetailButton: UIButton = {
        let button = UIButton()
        button.setTitle("주문상세", for: .normal)
        button.setTitleColor(.black, for: .normal)
        let chevronIcon = UIImage(systemName: "chevron.right")
        button.setImage(chevronIcon, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.addTarget(self, action: #selector(orderDetailButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        view.backgroundColor = .white
        super.viewDidLoad()

        setupScrollView()
        setupOrderView()
        setupOrderNavigationBarButton()
        setupOrderLowerCollectionView()
        setupOrderStackViewConstraints()
        setupOrderTitleLabel()
        setupOrderDetailButton()
    }

    func setupOrderView() {
        OrdercontentView.addSubview(OrderlowerCollectionStackView)
        OrdercontentView.addSubview(OrdertitleLabel)
        OrdercontentView.addSubview(orderDetailButton)
    }

    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(OrdercontentView)

        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }

    func setupOrderNavigationBarButton() {
        navigationItem.hidesBackButton = true
        let backArrow = UIImage(systemName: "chevron.backward")
        let leftButton = UIBarButtonItem(image: backArrow, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = leftButton
        leftButton.tintColor = .black
    }

    func setupOrderTitleLabel() {
        OrdertitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(66)
            make.leading.equalTo(view).offset(16)
        }
    }
    
    func setupOrderDetailButton() {
        orderDetailButton.snp.makeConstraints { make in
            make.top.equalTo(OrdertitleLabel.snp.bottom).offset(40)
            make.trailing.equalTo(view).offset(-16)
        }
    }

    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    func setupOrderLowerCollectionView() {
        for item in items {
            let cellView = CustomCellView()
            cellView.configure(title: item["title"]!, detail: item["detail"]!, imageName: item["imageName"]!)
            
            cellView.layer.cornerRadius = 10
            cellView.layer.masksToBounds = true
            
            OrderlowerCollectionStackView.addArrangedSubview(cellView)
            
            cellView.snp.makeConstraints { make in
                make.height.equalTo(94)
                make.width.equalTo(366)
            }
        }
    }

    func setupOrderStackViewConstraints() {
        OrderlowerCollectionStackView.snp.makeConstraints { make in
            make.top.equalTo(orderDetailButton.snp.bottom).offset(24)
            make.leading.equalTo(OrdercontentView.snp.leading).offset(16)
            make.centerX.equalTo(OrdercontentView.snp.centerX)
        }
    }

    @objc func orderDetailButtonTapped() {
        
    }
}

class CustomCellView: UIView {
    let titleLabel = UILabel()
    let detailLabel = UILabel()
    let imageView = UIImageView()
    let quantityLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 10
        layer.masksToBounds = true
        backgroundColor = UIColor.lightGray

        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(detailLabel)
        addSubview(quantityLabel)

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10

        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)

        detailLabel.textColor = .gray
        detailLabel.font = UIFont.systemFont(ofSize: 12)

        quantityLabel.text = "1개"
        quantityLabel.textColor = .black
        quantityLabel.font = UIFont.systemFont(ofSize: 12)

        setupConstraints()
    }

    func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(60)
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(8)
            make.top.equalToSuperview().offset(20)
            make.trailing.lessThanOrEqualTo(quantityLabel.snp.leading).offset(-10)
        }

        detailLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.top.equalTo(quantityLabel.snp.top).offset(0)
            make.trailing.lessThanOrEqualTo(quantityLabel.snp.leading).offset(-10)
        }

        quantityLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-20)
        }
    }

    func configure(title: String, detail: String, imageName: String) {
        titleLabel.text = title
        detailLabel.text = detail
        imageView.image = UIImage(named: imageName)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
