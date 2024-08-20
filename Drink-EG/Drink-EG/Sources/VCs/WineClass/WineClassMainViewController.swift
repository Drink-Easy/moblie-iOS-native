//
//  WineClassMainViewController.swift
//  Drink-EG
//
//  Created by 김도연 on 7/21/24.
//

import UIKit
import SnapKit

class WineClassMainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    
    var mainClassView: UICollectionView!
    var subClassView: UICollectionView!
    
    let titleclassLabel = UILabel()
    let subtitleclassLabel = UILabel()
    
    var containerView = UIView()
    
    private let bottomView = UIView()
    
    let ImageName: [String] = ["Castello Monaci", "Dos Copas", "Loxton", "Red Label", "Samos", "Vendredi"]
    
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
        l.text = "VINO 클래스"
        l.font = .systemFont(ofSize: UIConstants.labelFontSize, weight: .bold)
        l.textColor = .black
        l.numberOfLines = 0
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupAllUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        setGradientColor(containerView)
        roundTopRightCorner(view: containerView, cornerRadius: 30)
        roundTopRightCorner(view: bottomView, cornerRadius: 30)
        
    }
    
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
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
        
        // SearchBar 설정
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(10)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(UIConstants.searchBarHeight)
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
        
        let stackView = UIStackView(arrangedSubviews: [titleclassLabel, button])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillProportionally
        
        containerView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(16)
            make.leading.trailing.equalTo(containerView).inset(20)
        }
        
        setupMainClassView()
        containerView.addSubview(mainClassView)
        mainClassView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(10)
            make.leading.trailing.equalTo(containerView).inset(10)
            make.height.equalTo(UIConstants.classViewHeight) // 원하는 높이로 설정
        }
        
        bottomView.backgroundColor = .white // 원하는 배경색으로 변경
        roundTopRightCorner(view: bottomView, cornerRadius: 30)
        bottomView.applyTopShadow()
        
        containerView.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(mainClassView.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        
        setupSubTitleClassLabel()
        bottomView.addSubview(subtitleclassLabel)
        subtitleclassLabel.snp.makeConstraints { make in
            make.top.equalTo(bottomView.snp.top).offset(20)
            make.leading.equalTo(bottomView.snp.leading).offset(10)
        }
        
        setupMainClassView()
        bottomView.addSubview(mainClassView)
        mainClassView.snp.makeConstraints { make in
            make.top.equalTo(subtitleclassLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(bottomView).inset(10)
            make.height.equalTo(UIConstants.classViewHeight) // 원하는 높이로 설정
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
        layout.itemSize = UIConstants.mainClassViewItemSize
        layout.spacing = UIConstants.mainClassViewSpacing
        
        mainClassView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        mainClassView.backgroundColor = .clear
        mainClassView.delegate = self
        mainClassView.dataSource = self
        mainClassView.register(WineClassCell.self, forCellWithReuseIdentifier: WineClassCell.reuseIdentifier)
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
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WineClassCell.reuseIdentifier, for: indexPath) as! WineClassCell
        let imageName = self.ImageName.randomElement()!
        cell.configure(with: UIImage(named: imageName)!)
        return cell
    }
}

