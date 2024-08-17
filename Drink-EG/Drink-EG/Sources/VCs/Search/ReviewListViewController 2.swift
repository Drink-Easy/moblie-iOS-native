//
//  ReviewListViewController.swift
//  Drink-EG
//
//  Created by 이현주 on 8/15/24.
//

import UIKit

class ReviewListViewController: UIViewController {
    
    private var ReviewContents: [String] = ["lhj1024", "dyk1234", "leeeSh0101", "hoooyeon56"]
    
    var score = 4.5
    private let scoreLabel = UILabel()
    
    private let label: UILabel = {
        let l = UILabel()
        l.text = "다른유저 리뷰"
        l.font = .systemFont(ofSize: 28, weight: UIFont.Weight(700))
        l.textColor = .black
        l.numberOfLines = 0
        return l
    }()
    
    private let stick: UIView = {
        let s = UIView()
        s.backgroundColor = UIColor(hex: "FA735B")
        s.layer.borderWidth = 0
        return s
    }()
    
    private let name: UILabel = {
        let l = UILabel()
        l.text = "Red Label"
        l.font = .boldSystemFont(ofSize: 22)
        l.textColor = .black
        return l
    }()
    
    private let image: UIImageView = {
        let i = UIImageView()
        i.image = UIImage(named: "Red Label")
        i.layer.cornerRadius = 10
        i.layer.masksToBounds = true
        return i
    }()
    
    lazy var reviewListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 30, left: 0, bottom: 40, right: 0)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(ReviewListCollectionViewCell.self, forCellWithReuseIdentifier: "ReviewListCollectionViewCell")
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        
        cv.decelerationRate = .fast
        cv.backgroundColor = UIColor(hex: "#E5E5E5")
        cv.layer.cornerRadius = 25
        cv.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        
        return cv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        configureScore()
        
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(27)
        }
        
        view.addSubview(stick)
        stick.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(31)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(1.5)
        }
        
        view.addSubview(image)
        image.snp.makeConstraints { make in
            make.top.equalTo(stick.snp.bottom).offset(17)
            make.leading.equalTo(stick)
            make.width.lessThanOrEqualTo(110)
            make.height.lessThanOrEqualTo(140)
        }
        
        view.addSubview(name)
        name.snp.makeConstraints { make in
            make.top.equalTo(image)
            make.leading.equalTo(image.snp.trailing).offset(16)
        }
        
        view.addSubview(scoreLabel)
        scoreLabel.snp.makeConstraints { make in
            make.centerY.equalTo(name)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        view.addSubview(reviewListCollectionView)
        reviewListCollectionView.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(22)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureScore() {
        scoreLabel.text = "★ \(score)"
        scoreLabel.font = .boldSystemFont(ofSize: 14)
        scoreLabel.textColor = UIColor(hex: "#FA735B")
    }

}

extension ReviewListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ReviewContents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewListCollectionViewCell", for: indexPath) as! ReviewListCollectionViewCell
        
        cell.configure(name: ReviewContents[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: 110)
    }
}
