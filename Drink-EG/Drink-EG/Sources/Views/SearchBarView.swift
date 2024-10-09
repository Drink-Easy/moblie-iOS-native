//
//  SearchBarView.swift
//  Drink-EG
//
//  Created by 김도연 on 10/7/24.
//

import UIKit
import SnapKit
import Then

class SearchBarView: UIView {

    // 돋보기 버튼 생성
    let searchButton = UIButton().then {
        $0.setImage(UIImage(systemName: "magnifyingglass"), for: .normal) // 돋보기 아이콘
        $0.tintColor = .gray // 버튼의 색상
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    // 뷰 설정
    private func setupView() {
        backgroundColor = .white // 배경색 설정
        addSubview(searchButton) // 버튼 추가
        
        searchButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview() // 오른쪽 끝에서 8pt 여유
            make.centerY.equalToSuperview()           // 버튼을 수직 중앙에 배치
            make.width.height.equalTo(32)             // 버튼 크기 설정
        }
    }
}

