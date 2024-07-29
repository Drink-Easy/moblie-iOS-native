//
//  StartLoginPageControl.swift
//  Drink-EG
//
//  Created by 이현주 on 7/30/24.
//

import UIKit

class StartLoginPageControl: UIPageControl {

    // 색상 설정
    var customPageIndicatorTintColor: UIColor = .lightGray
    var customCurrentPageIndicatorTintColor: UIColor = .black

    // 인디케이터의 기본 크기
    private let defaultIndicatorSize: CGSize = CGSize(width: 12, height: 12)
    // 현재 페이지를 나타내는 인디케이터의 크기
    private let currentIndicatorSize: CGSize = CGSize(width: 18, height: 12)

    override func layoutSubviews() {
        super.layoutSubviews()

        // 기존 인디케이터 서브뷰 제거
        subviews.forEach { $0.removeFromSuperview() }

        // 인디케이터 생성 및 레이아웃 설정
        for index in 0..<numberOfPages {
            let indicator = UIView()
            indicator.backgroundColor = index == currentPage ? customCurrentPageIndicatorTintColor : customPageIndicatorTintColor

            if index == currentPage {
                // 현재 페이지 인디케이터는 사각형으로 설정
                indicator.frame = CGRect(
                    x: CGFloat(index) * (currentIndicatorSize.width + 8) + (bounds.width - CGFloat(numberOfPages) * (currentIndicatorSize.width + 8)) / 2,
                    y: (bounds.height - currentIndicatorSize.height) / 2,
                    width: currentIndicatorSize.width,
                    height: currentIndicatorSize.height
                )
            }
            addSubview(indicator)
        }
    }

    override func updateCurrentPageDisplay() {
        super.updateCurrentPageDisplay()
        layoutSubviews()
    }
}
