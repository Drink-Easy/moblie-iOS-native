//
//  EnterLoginViewController.swift
//  Drink-EG
//
//  Created by 이현주 on 7/30/24.
//

import UIKit

class EnterLoginViewController: UIViewController {
    
    let startButton = UIButton(type: .system)
    
    private var StartImage: [String] = ["start1", "start2", "start2"]
    private var Label1: [String] = ["쉽게 배우는 와인 지식", "함께 즐기는 와인", "나만의 테이스팅 노트"]
    private var Label2: [String] = ["드링키지, 와인의 진입장벽을 낮추다.", "더 즐거운 시간을 공유해보세요!", "다양한 테이스팅 노트를 기록하며\n나의 취향에 대해 알아보세요!"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        setupUI()
    }
    
    private func setupUI() {
        configureStartButton()
        
        view.addSubview(startButton)
        startButton.snp.makeConstraints { make in
            make.top.equalTo(view).offset(727)
            make.centerX.equalToSuperview()
            make.leading.equalTo(view).offset(33)
            make.height.equalTo(60)
            make.width.equalTo(327)
        }
        
        view.addSubview(StartLoginCollectionView)
        StartLoginCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view)
            make.leading.equalTo(view)
            make.width.equalTo(view)
            make.height.equalTo(687)
        }
        
        view.addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(688)
            make.centerX.equalToSuperview()
        }
    }
    
    private func configureStartButton() {
        startButton.setTitle("시작하기", for: .normal)
        startButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        startButton.setTitleColor(.black, for: .normal)
        startButton.contentHorizontalAlignment = .center
        
        startButton.backgroundColor = UIColor(hue: 0.1389, saturation: 0.54, brightness: 1, alpha: 1.0)
        startButton.layer.cornerRadius = 16
        startButton.layer.borderWidth = 0
        
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    @objc private func startButtonTapped() {
        let selectLoginViewController = SelectLoginViewController()
        navigationController?.pushViewController(selectLoginViewController, animated: true)
    }
    
    lazy var StartLoginCollectionView: UICollectionView = {
        // collection view layout setting
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.footerReferenceSize = .zero
        layout.headerReferenceSize = .zero
                
        // collection view setting
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isScrollEnabled = true
        cv.isPagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        cv.register(StartLoginCollectionViewCell.self, forCellWithReuseIdentifier: "StartLoginCollectionViewCell")
        cv.delegate = self
        cv.dataSource = self
                
        // UI setting
        cv.backgroundColor = .black
                
        return cv
    }()
    
    lazy var pageControl: UIPageControl = {
        let p = UIPageControl()
        p.pageIndicatorTintColor = UIColor(hue: 0, saturation: 0, brightness: 0.46, alpha: 1.0)
        p.currentPageIndicatorTintColor = UIColor(hue: 0.1389, saturation: 0.72, brightness: 1, alpha: 1.0)
        return p
    }()

}

extension EnterLoginViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // page control 설정.
        if scrollView.frame.size.width != 0 {
            let value = (scrollView.contentOffset.x / scrollView.frame.width)
            pageControl.currentPage = Int(round(value))
        }
    }
}


extension EnterLoginViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControl.numberOfPages = 3
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StartLoginCollectionViewCell", for: indexPath) as! StartLoginCollectionViewCell
        
        cell.configure(imageName: StartImage[indexPath.item], label1: Label1[indexPath.item], label2: Label2[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
