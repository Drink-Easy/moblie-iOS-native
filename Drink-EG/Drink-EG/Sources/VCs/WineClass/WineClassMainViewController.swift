//
//  WineClassMainViewController.swift
//  Drink-EG
//
//  Created by 김도연 on 7/21/24.
//

import Foundation

import UIKit
import SnapKit

class VideoViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var mainClassView: UICollectionView! // UICollectionView로 변경
    var subClassView: UICollectionView! // UICollectionView로 변경
    let titleclassLabel = UILabel()
    let subtitleclassLabel = UILabel()

    //let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        setupMainClassView() // UICollectionView 설정
        setupTitleClassLabel()
        setupTitleClassLabelConstraints()
        //setupMainVideoViewConstraints() // 이미지뷰 제약 조건 설정
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
        mainClassView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
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
        subClassView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        // mainClassView를 슈퍼뷰에 추가
        view.addSubview(subClassView)
        
        subClassView.snp.makeConstraints { make in
            make.top.equalTo(subtitleclassLabel.snp.bottom).offset(20) // 이미지뷰 하단에 위치
            make.trailing.equalToSuperview().offset(-10)
            make.leading.equalToSuperview().offset(10)
            make.height.equalTo(300)
        }
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10 // 임의로 10개의 아이템을 설정
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .lightGray // 셀의 배경색 설정
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

//위는 carousel 뷰
//하단은 검색 창


/*
import Foundation
import UIKit
import SnapKit

class ClassViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    let vinoclassLabel = UILabel()
    let searchButton = UIButton(type: .system)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupView()
        setupVinoClassLabel()
        setupVinoClassLabelConstraints()
        
        setupSearchButton()
        setupSearchButtonConstraints()

        
    }
    
    func setupView() { // 뷰 설정 함수
        //view.addSubview(noteListLabel)
        view.addSubview(vinoclassLabel)
        view.addSubview(searchButton)

        
        
    }
    
    
    
    
    func setupVinoClassLabel() { // Label의 기본 속성을 설정하는 함수
        vinoclassLabel.text = "VINO 클래스"
        vinoclassLabel.font = .boldSystemFont(ofSize: 28)
        vinoclassLabel.textAlignment = .center
        vinoclassLabel.textColor = .black
    }
    
    func setupVinoClassLabelConstraints() { // Label의 제약 조건을 설정하는 함수
        vinoclassLabel.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
        }
    }
    
    func setupSearchButton() {
        searchButton.setTitle("연관 내용 검색", for: .normal)
        searchButton.setTitleColor(UIColor(hex: "767676"), for: .normal)
        searchButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        searchButton.contentHorizontalAlignment = .left
        searchButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 17, bottom: 0, right: 0)
    }
    
    func setupSearchButtonConstraints() {
        searchButton.snp.makeConstraints{ make in
            make.top.equalTo(vinoclassLabel.snp.bottom).offset(22)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16) // Left margin
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-16) // Right margin
            make.height.equalTo(34) // Set a fixed height if needed or adjust as required


        }
        
        searchButton.backgroundColor = UIColor(hex: "E5E5E5")
        searchButton.layer.cornerRadius = 8
        searchButton.layer.masksToBounds = true
        searchButton.layer.borderWidth = 0

        // 돋보기 이미지 설정
        let searchImage = UIImage(systemName: "magnifyingglass")
        searchButton.setImage(searchImage, for: .normal)
                              
        searchButton.tintColor = UIColor(hex: "767676")
        searchButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        // 버튼 액션 추가
        //searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    func setupSecLabel() {
        
    }
    
    
   
    
    
    
    
    
}
*/
