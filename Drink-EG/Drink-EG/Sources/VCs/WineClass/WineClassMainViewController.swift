//
//  WineClassMainViewController.swift
//  Drink-EG
//
//  Created by 김도연 on 7/21/24.
//

import UIKit
import SnapKit
import SwiftUI

class WineClassMainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var mainClassView: UICollectionView! // UICollectionView로 변경
    var subClassView: UICollectionView! // UICollectionView로 변경
    let titleclassLabel = UILabel()
    let subtitleclassLabel = UILabel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupMainClassView() // UICollectionView 설정
        setupTitleClassLabel()
        setupTitleClassLabelConstraints()
        setupSubClassView()
        setupSubTitleClassLabel()
        setupSubTitleClassLabelConstraints()
    }
    
    func setupTitleClassLabel() { // Label의 기본 속성을 설정하는 함수
        titleclassLabel.text = "15초만에 알아가는 와인 지식"
        titleclassLabel.font = .boldSystemFont(ofSize: 24)
        titleclassLabel.textAlignment = .center
        titleclassLabel.textColor = .black
    }
    
    func setupTitleClassLabelConstraints() { // Label의 제약 조건을 설정하는 함수
        titleclassLabel.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
        }
    }
    
    func setupMainClassView() {
        let layout = CarouselLayout()
        layout.itemSize = CGSize(width: 200, height: 300) // 아이템 크기 설정
        
        mainClassView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        mainClassView.backgroundColor = .clear
        mainClassView.delegate = self
        mainClassView.dataSource = self
        mainClassView.register(WineClassCell.self, forCellWithReuseIdentifier: WineClassCell.reuseIdentifier)


        
        // mainClassView를 슈퍼뷰에 추가
        view.addSubview(mainClassView)
        view.addSubview(titleclassLabel)
        view.addSubview(subtitleclassLabel)
        
        mainClassView.snp.makeConstraints { make in
            make.top.equalTo(titleclassLabel.snp.bottom).offset(20)
            

            make.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
    }
    
    func setupSubTitleClassLabel() { // Label의 기본 속성을 설정하는 함수
        subtitleclassLabel.text = "이번 달 와인뉴스"
        subtitleclassLabel.font = .boldSystemFont(ofSize: 24)
        subtitleclassLabel.textAlignment = .center
        subtitleclassLabel.textColor = .black
    }
    
    func setupSubTitleClassLabelConstraints() { // Label의 제약 조건을 설정하는 함수
        subtitleclassLabel.snp.makeConstraints{ make in
            make.top.equalTo(mainClassView.snp.bottom).offset(20)
            make.leading.equalTo(mainClassView.snp.leading).offset(16)
        }
    }
    
    func setupSubClassView() {
        let layout = CarouselLayout()
        layout.itemSize = CGSize(width: 164, height: 212) // 아이템 크기 설정
        
        subClassView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        subClassView.backgroundColor = .clear
        subClassView.delegate = self
        subClassView.dataSource = self
        subClassView.register(WineClassCell.self, forCellWithReuseIdentifier: WineClassCell.reuseIdentifier)
        
        // mainClassView를 슈퍼뷰에 추가
        view.addSubview(subClassView)
        
        subClassView.snp.makeConstraints { make in
            make.top.equalTo(subtitleclassLabel.snp.bottom).offset(20) // 이미지뷰 하단에 위치
            make.trailing.equalToSuperview().offset(-10)
            make.leading.equalToSuperview().offset(10)
            make.height.equalTo(300)
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10 // 임의로 10개의 아이템을 설정
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WineClassCell.reuseIdentifier, for: indexPath) as! WineClassCell
        
        // 예시로, 이미지 설정
        let imageName = "Dos Copas" // 실제 이미지 이름으로 교체
        cell.configure(with: UIImage(named: imageName)!)
        
        return cell
    }

}


class CarouselLayout: UICollectionViewFlowLayout {
    
    public var sideItemScale: CGFloat = 0.4
    public var sideItemAlpha: CGFloat = 0.8
    public var spacing: CGFloat = -90

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
        
        // 중앙에서 떨어진 최대 거리, 2개의 아이템까지 떨어질 수 있도록
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


class WineClassCell: UICollectionViewCell {
    
    static let reuseIdentifier = "WineClassCell"
    
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 이미지뷰 설정
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        
        // 이미지뷰 제약 설정
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // 셀의 모서리를 둥글게 설정하고 그림자 효과 추가 (선택 사항)
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.3
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 이미지를 설정하는 함수
    func configure(with image: UIImage) {
        imageView.image = image
    }
}

