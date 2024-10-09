//
//  WineCourseTableCell.swift
//  Drink-EG
//
//  Created by 김도연 on 10/9/24.
//

import UIKit
import SnapKit
import Then

class WineCourseTableCell: UITableViewCell {
    
    // UI 요소들 정의
    let customImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    let titleLabel = UILabel().then {
        $0.font = UIFont.ptdRegularFont(ofSize: 16)
        $0.textColor = .black
    }
    
    let progressBar = UIProgressView(progressViewStyle: .default).then {
        $0.progressTintColor = UIColor.appPurple()
        $0.trackTintColor = UIColor.lightGray
        $0.layer.cornerRadius = 2
        $0.clipsToBounds = true
    }
    
    let percentageLabel = UILabel().then {
        $0.font = UIFont.ptdRegularFont(ofSize: 12)
        $0.textColor = UIColor.appPurple()
    }
    
    // 원형 tip 이미지 뷰 (Circle Tip)
    let circleTipImageView = UIImageView().then {
        $0.image = UIImage(named: "circleTip") // 원형 tip 이미지 설정
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10 // 원형 모양 유지
    }

    // 셀 초기화 메서드
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout() // 레이아웃 설정
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 레이아웃 설정 메서드
    private func setupLayout() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(progressBar)
        contentView.addSubview(percentageLabel)
        contentView.addSubview(circleTipImageView) // 원형 tip 이미지 추가
        
        // SnapKit을 이용한 레이아웃 설정
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        progressBar.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(6) // 프로그레스바 높이
        }
        
        percentageLabel.snp.makeConstraints { make in
            make.top.equalTo(progressBar.snp.bottom).offset(8)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        // 원형 tip 이미지 레이아웃 (초기 위치 설정)
        circleTipImageView.snp.makeConstraints { make in
            make.centerY.equalTo(progressBar.snp.centerY) // 프로그레스바와 동일한 Y 축
            make.width.height.equalTo(20) // 원형 tip 크기
            make.left.equalTo(progressBar.snp.left) // 초기 위치는 progressBar의 왼쪽
        }
    }
    
    // 셀에 데이터를 설정하는 메서드
    func configure(image: UIImage?, title: String, progress: Float) {
        customImageView.image = image
        titleLabel.text = title
        progressBar.setProgress(progress, animated: true)
        percentageLabel.text = String(format: "%.1f%%", progress * 100)
        
        // 원형 tip 위치 업데이트
        updateCircleTipPosition(for: progress)
    }
    
    // 원형 tip 위치를 프로그레스에 맞춰 업데이트하는 메서드
    private func updateCircleTipPosition(for progress: Float) {
        layoutIfNeeded() // 레이아웃이 최신 상태인지 확인
        
        // progressBar의 width를 기준으로 progress 값을 적용한 x 위치 계산
        let progressWidth = progressBar.frame.width
        let tipPositionX = CGFloat(progress) * progressWidth
        
        // 원형 tip의 x 좌표를 progress에 맞춰 이동
        circleTipImageView.snp.updateConstraints { make in
            make.left.equalTo(progressBar.snp.left).offset(tipPositionX - circleTipImageView.frame.width / 2)
        }
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded() // 애니메이션과 함께 레이아웃 업데이트
        }
    }
}
