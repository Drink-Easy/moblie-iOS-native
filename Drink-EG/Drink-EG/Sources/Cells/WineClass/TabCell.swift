//
//  TabCell.swift
//  Drink-EG
//
//  Created by 김도연 on 10/9/24.
//

import UIKit
import SnapKit
import Then

//MARK: - TabCell Custom CollectionViewCell
class TabCell: UICollectionViewCell {
    private let titleLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Regular", size: 17)
        $0.textAlignment = .center
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // 선택된 상태에 따라 텍스트 색상 변경
    func configure(text: String, isSelected: Bool) {
        titleLabel.text = text
        titleLabel.textColor = isSelected ? UIColor(hex: "#5813B1") : .gray
    }
}
