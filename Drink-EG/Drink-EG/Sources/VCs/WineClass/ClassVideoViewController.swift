//
//  ClassVideoViewController.swift
//  Drink-EG
//
//  Created by 김도연 on 7/21/24.
//

import UIKit
import Moya
import SnapKit
import YouTubeiOSPlayerHelper

class ClassVideoViewController: UIViewController {
    public static var videoData : [String] = []
    
    let youtubePlayer : YTPlayerView = YTPlayerView(frame: CGRect())
    
    private let bottomView = UIView()
    let xButton: UIButton = UIButton(type: .system)
    
    private let videoTitleLabel = UILabel()
    private let videoDespTitleLabel = UILabel()
    private let videoDescriptionLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // 레이아웃이 확정된 후 코너를 둥글게 설정
        bottomView.layoutIfNeeded()
        roundTopCorner(view: bottomView, cornerRadius: 30)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // youtubePlayer 설정
        youtubePlayer.load(withVideoId: ClassVideoViewController.videoData[0], playerVars: ["playsinline": 0])
        view.addSubview(youtubePlayer)
        view.addSubview(bottomView)
        
        youtubePlayer.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view.snp.height).multipliedBy(0.8)
        }
        
        // bottomView 설정
        bottomView.backgroundColor = UIColor.white
        bottomView.snp.makeConstraints { v in
            v.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            v.height.equalTo(view.snp.height).multipliedBy(0.2)
        }
        
        // xButton 설정
        xButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        xButton.tintColor = .black
        xButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        bottomView.addSubview(xButton)
        xButton.snp.makeConstraints { b in
            b.top.equalTo(bottomView.snp.top).offset(36)
            b.trailing.equalTo(bottomView).inset(16)
        }

        // videoTitleLabel 설정
        videoTitleLabel.text = ClassVideoViewController.videoData[1]
        videoTitleLabel.font = .boldSystemFont(ofSize: 22)
        videoTitleLabel.textColor = .black
        videoTitleLabel.numberOfLines = 0
        bottomView.addSubview(videoTitleLabel)
        videoTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(bottomView.snp.top).offset(36)
            make.leading.equalTo(bottomView).inset(16)
            make.trailing.equalTo(xButton.snp.leading)
        }
        
        videoDespTitleLabel.text = "영상 설명"
        videoDespTitleLabel.font = .systemFont(ofSize: 16)
        videoDespTitleLabel.textColor = .black
        bottomView.addSubview(videoDespTitleLabel)
        videoDespTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(videoTitleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalTo(bottomView).inset(16)
        }
        
        // videoDescriptionLabel 설정
        videoDescriptionLabel.text = ClassVideoViewController.videoData[2]
        videoDescriptionLabel.font = .systemFont(ofSize: 16)
        videoDescriptionLabel.textColor = .darkGray
        videoDescriptionLabel.numberOfLines = 0
        bottomView.addSubview(videoDescriptionLabel)
        videoDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(videoDespTitleLabel.snp.bottom).offset(4)
            make.leading.trailing.equalTo(bottomView).inset(16)
        }
    }
    
    @objc private func dismissViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func roundTopCorner(view: UIView, cornerRadius: CGFloat) {
        let path = UIBezierPath(
            roundedRect: view.bounds,
            byRoundingCorners: [.topRight, .topLeft], // 둥글게 만들 모서리 설정
            cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
        )
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        view.layer.mask = mask
    }

}
