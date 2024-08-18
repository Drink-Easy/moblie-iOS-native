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

class CarouselLayout: UICollectionViewFlowLayout {
    
    public var sideItemScale: CGFloat = UIConstants.sideItemScale
    public var sideItemAlpha: CGFloat = UIConstants.sideItemAlpha
    public var spacing: CGFloat = UIConstants.carouselSpacing
    
    public var isPagingEnabled: Bool = false
    
    private var isSetup: Bool = false
    
    override public func prepare() {
        super.prepare()
        if isSetup == false {
            setupLayout()
            isSetup = true
        }
    }
    
    private func setupLayout() {
        guard let collectionView = self.collectionView else { return }
        
        let collectionViewSize = collectionView.bounds.size
        let xInset = (collectionViewSize.width - self.itemSize.width) / 2
        let yInset = (collectionViewSize.height - self.itemSize.height) / 2
        
        self.sectionInset = UIEdgeInsets(top: yInset, left: xInset, bottom: yInset, right: xInset)
        let itemWidth = self.itemSize.width
        let scaledItemOffset = (itemWidth - (itemWidth * (self.sideItemScale + (1 - self.sideItemScale) / 2))) / 2
        self.minimumLineSpacing = spacing - scaledItemOffset
        
        self.scrollDirection = .horizontal
    }
    
    public override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let superAttributes = super.layoutAttributesForElements(in: rect),
              let attributes = NSArray(array: superAttributes, copyItems: true) as? [UICollectionViewLayoutAttributes]
        else { return nil }
        
        return attributes.map({ self.transformLayoutAttributes(attributes: $0) })
    }
    
    private func transformLayoutAttributes(attributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        guard let collectionView = self.collectionView else { return attributes }
        
        let collectionCenter = collectionView.frame.size.width / 2
        let contentOffset = collectionView.contentOffset.x
        let center = attributes.center.x - contentOffset
        
        let maxDistance = 8 * (self.itemSize.width + self.minimumLineSpacing)
        let distance = min(abs(collectionCenter - center), maxDistance)
        let ratio = (maxDistance - distance) / maxDistance
        
        let alpha = ratio * (1 - self.sideItemAlpha) + self.sideItemAlpha
        let scale = ratio * (1 - self.sideItemScale) + self.sideItemScale
        
        attributes.alpha = alpha
        if abs(collectionCenter - center) > maxDistance + 1 {
            attributes.alpha = 0
        }
        
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let dist = attributes.frame.midX - visibleRect.midX
        var transform = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
        transform = CATransform3DTranslate(transform, 0, 0, -abs(dist / 1000))
        attributes.transform3D = transform
        
        return attributes
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = self.collectionView else {
            let latestOffset = super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
            return latestOffset
        }
        
        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.frame.width, height: collectionView.frame.height)
        guard let rectAttributes = super.layoutAttributesForElements(in: targetRect) else { return .zero }
        
        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        let horizontalCenter = proposedContentOffset.x + collectionView.frame.width / 2
        
        for layoutAttributes in rectAttributes {
            let itemHorizontalCenter = layoutAttributes.center.x
            if (itemHorizontalCenter - horizontalCenter).magnitude < offsetAdjustment.magnitude {
                offsetAdjustment = itemHorizontalCenter - horizontalCenter
            }
        }
        
        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    }
}

//class CarouselLayout: UICollectionViewFlowLayout {
//    
//    public var sideItemScale: CGFloat = 0.8 // 측면 아이템의 크기 비율
//    public var sideItemAlpha: CGFloat = 0.6 // 측면 아이템의 투명도
//    public var spacing: CGFloat = -80 // 셀 간의 간격 (겹치도록 음수로 설정)
//
//    public var isPagingEnabled: Bool = false
//    
//    private var isSetup: Bool = false
//    
//    override public func prepare() {
//        super.prepare()
//        if isSetup == false {
//            setupLayout()
//            isSetup = true
//        }
//    }
//    
//    private func setupLayout() {
//        guard let collectionView = self.collectionView else { return }
//        
//        let collectionViewSize = collectionView.bounds.size
//        let xInset = (collectionViewSize.width - self.itemSize.width) / 2
//        let yInset = (collectionViewSize.height - self.itemSize.height) / 2
//        
//        self.sectionInset = UIEdgeInsets(top: yInset, left: xInset, bottom: yInset, right: xInset)
//        
//        // 셀 간의 간격 계산 (절반씩 겹치도록 설정)
//        self.minimumLineSpacing = spacing
//        
//        self.scrollDirection = .horizontal
//    }
//    
//    public override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
//        return true
//    }
//    
//    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        guard let superAttributes = super.layoutAttributesForElements(in: rect),
//              let attributes = NSArray(array: superAttributes, copyItems: true) as? [UICollectionViewLayoutAttributes]
//        else { return nil }
//        
//        return attributes.map({ self.transformLayoutAttributes(attributes: $0) })
//    }
//    
//    private func transformLayoutAttributes(attributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        guard let collectionView = self.collectionView else { return attributes }
//        
//        let collectionCenter = collectionView.frame.size.width / 2
//        let contentOffset = collectionView.contentOffset.x
//        let center = attributes.center.x - contentOffset
//        
//        // 중앙에서 떨어진 거리 계산
//        let maxDistance = collectionView.frame.size.width / 2
//        let distance = min(abs(collectionCenter - center), maxDistance)
//        let ratio = (maxDistance - distance) / maxDistance
//        
//        // 투명도 및 크기 조정
//        let alpha = ratio * (1 - self.sideItemAlpha) + self.sideItemAlpha
//        let scale = ratio * (1 - self.sideItemScale) + self.sideItemScale
//        
//        attributes.alpha = alpha
//        attributes.transform3D = CATransform3DMakeScale(scale, scale, 1)
//        
//        // 3D 효과 추가 (회전 효과)
//        let rotationAngle = (1 - ratio) * (.pi / 8) // 최대 22.5도 회전
//        attributes.transform3D = CATransform3DRotate(attributes.transform3D, rotationAngle, 0, 1, 0)
//        
//        // 중앙에서 멀어지면 투명하게
//        if abs(collectionCenter - center) > maxDistance {
//            attributes.alpha = 0
//        }
//        
//        return attributes
//    }
//    
//    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
//        guard let collectionView = self.collectionView else {
//            let latestOffset = super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
//            return latestOffset
//        }
//        
//        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.frame.width, height: collectionView.frame.height)
//        guard let rectAttributes = super.layoutAttributesForElements(in: targetRect) else { return .zero }
//        
//        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
//        let horizontalCenter = proposedContentOffset.x + collectionView.frame.width / 2
//        
//        for layoutAttributes in rectAttributes {
//            let itemHorizontalCenter = layoutAttributes.center.x
//            if abs(itemHorizontalCenter - horizontalCenter) < abs(offsetAdjustment) {
//                offsetAdjustment = itemHorizontalCenter - horizontalCenter
//            }
//        }
//        
//        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
//    }
//}


class WineClassCell: UICollectionViewCell {
    static let reuseIdentifier = "WineClassCell"
    
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.layer.cornerRadius = UIConstants.cellCornerRadius
        contentView.layer.masksToBounds = true
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = UIConstants.cellShadowOpacity
        contentView.layer.shadowOffset = UIConstants.cellShadowOffset
        contentView.layer.shadowRadius = UIConstants.cellShadowRadius
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with image: UIImage) {
        imageView.image = image
    }
}



struct UIConstants {
    static let searchBarHeight: CGFloat = 34
    static let searchBarCornerRadius: CGFloat = 8
    static let labelFontSize: CGFloat = 28
    static let titleClassLabelFontSize: CGFloat = 24
    static let labelTopOffset: CGFloat = 10
    static let viewSideInset: CGFloat = 16
    static let classViewHeight: CGFloat = 250
    static let mainClassViewItemSize = CGSize(width: 100, height: 180)
    static let mainClassViewSpacing: CGFloat = 20
    static let carouselSpacing: CGFloat = -90
    static let sideItemScale: CGFloat = 0.4
    static let sideItemAlpha: CGFloat = 0.8
    static let cellCornerRadius: CGFloat = 10
    static let cellShadowOpacity: Float = 0.3
    static let cellShadowOffset = CGSize(width: 0, height: 2)
    static let cellShadowRadius: CGFloat = 5
}

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    private func setupButton() {
        // 버튼 타이틀 설정
        self.setTitle("내 보관함", for: .normal)
        self.setTitleColor(.lightGray, for: .normal)
        
        // 버튼 배경색 설정
        self.backgroundColor = .white
        
        // 버튼의 둥근 모서리 설정
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = false
        
        // 그림자 설정
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.25
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 5
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 버튼의 크기가 결정된 후에 그림자 경로 설정
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
    }
}


extension UIView {
    
    func applyTopShadow(shadowColor: UIColor = .black, shadowOpacity: Float = 0.25, shadowRadius: CGFloat = 5, shadowOffset: CGSize = CGSize(width: 0, height: -3)) {
        // 그림자 색상
        self.layer.shadowColor = shadowColor.cgColor
        
        // 그림자 투명도
        self.layer.shadowOpacity = shadowOpacity
        
        // 그림자 퍼짐 정도
        self.layer.shadowRadius = shadowRadius
        
        // 그림자 오프셋 (상단에만 그림자가 보이도록 설정)
        self.layer.shadowOffset = shadowOffset

        // 레이아웃이 완료된 후에 shadowPath 설정
        DispatchQueue.main.async {
            let shadowPath = UIBezierPath()
            shadowPath.move(to: CGPoint(x: 0, y: 0))
            shadowPath.addLine(to: CGPoint(x: self.bounds.width, y: 0))
            shadowPath.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height / 4))
            shadowPath.addLine(to: CGPoint(x: 0, y: self.bounds.height / 4))
            shadowPath.close()
            
            self.layer.shadowPath = shadowPath.cgPath
        }
    }
}


