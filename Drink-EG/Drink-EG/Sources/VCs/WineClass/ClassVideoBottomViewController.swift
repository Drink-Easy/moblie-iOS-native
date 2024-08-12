//
//  ClassVideoBottomViewController.swift
//  Drink-EG
//
//  Created by 이호연 on 8/12/24.
//

import Foundation

import UIKit
import SnapKit


class ClassVideoBottomViewController: UIViewController {
    
    let imageView = UIImageView()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        setupVideo()
        configureSheet()
        setupVideoViewConstraints()
        
    }
    
        
        private func setupVideo() {
            view.addSubview(imageView)
            
            imageView.overrideUserInterfaceStyle = .dark
            imageView.frame = view.bounds
            imageView.contentMode = .scaleAspectFill
            //imageView.clipsToBounds = true
            //imageView.layer.cornerRadius = 40
            imageView.image = UIImage(named: "SampleImage")
        }
    
    func setupVideoViewConstraints() {
        imageView.snp.makeConstraints { make in
            //make.top.equalTo(myinfoLabel.snp.bottom).offset(80) // noteListLabel의 아래에 20포인트 여백
            make.centerX.equalToSuperview() // 가로축 중앙에 배치
            make.height.equalTo(568)
            make.width.equalTo(405)

        }
    }
        
        
        private func configureSheet() {
            
            
            let vc = SecondViewController()
            
            let navVC = UINavigationController(rootViewController: vc)
            
            navVC.isModalInPresentation = true
            
            if let sheet = navVC.sheetPresentationController {
                
                sheet.preferredCornerRadius = 40
                
                
                sheet.detents = [.custom(resolver: {context in
                    0.4 * context.maximumDetentValue
                }), .large()]

                
                sheet.largestUndimmedDetentIdentifier = .large
            }
            navigationController?.present(navVC, animated: true)
        }
    }
