//
//  CarouselLayout.swift
//  Drink-EG
//
//  Created by 김도연 on 8/20/24.
//

import UIKit

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
