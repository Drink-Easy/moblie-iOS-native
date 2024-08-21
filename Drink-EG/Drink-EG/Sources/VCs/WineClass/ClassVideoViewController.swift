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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        youtubePlayer.load(withVideoId: ClassVideoViewController.videoData[0])
        view.addSubview(youtubePlayer)
        youtubePlayer.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        print("title : \(ClassVideoViewController.videoData[1]) \n 설명 : \(ClassVideoViewController.videoData[2])")
    }
}
