//
//  NewNoteFooter.swift
//  Drink-EG
//
//  Created by 김도연 on 8/27/24.
//

import UIKit
import SnapKit
import Moya

class NewNoteFooter: UICollectionReusableView {
    let button = UIButton(type: .system)
    weak var delegate: NewNoteFooterDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(button)

        button.setTitle("+ 새로 적기", for: .normal)
        button.setTitleColor(UIColor(hex: "FFFFFF"), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = UIColor(hex: "FA735B")
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(newNoteButtonTapped), for: .touchUpInside)
        button.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.height.greaterThanOrEqualTo(61)
            // make.bottom.equalToSuperview().offset(-10)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func newNoteButtonTapped() {
        delegate?.didTapNewNoteButton()
    }
}
