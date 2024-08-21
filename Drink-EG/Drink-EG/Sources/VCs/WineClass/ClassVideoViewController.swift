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
    let tempString : String = "93sUSWbBnf0"
    
    let youtubePlayer : YTPlayerView = YTPlayerView(frame: CGRect())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        youtubePlayer.load(withVideoId: tempString)
        view.addSubview(youtubePlayer)
        youtubePlayer.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
