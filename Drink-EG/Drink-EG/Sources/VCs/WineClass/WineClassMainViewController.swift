//
//  WineClassMainViewController.swift
//  Drink-EG
//
//  Created by 김도연 on 7/21/24.
//

import UIKit
import SnapKit

class WineClassMainViewController : UIViewController {
    
    // "VINO 클래스" 타이틀
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "VINO 클래스"
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textColor = .black
        return label
    }()
    
    // 검색창
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "제목, 연관내용 검색"
        searchBar.backgroundImage = UIImage()  // 배경을 없앰
        return searchBar
    }()
    
    // "내 보관함" 버튼
    private let myCollectionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("내 보관함", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 15
        button.addTarget(WineClassMainViewController.self, action: #selector(didTapMyCollectionButton), for: .touchUpInside)
        return button
    }()
    
    
    
    // "15초만에 알아가는 와인 지식" 카드 뷰
    private let wineKnowledgeCardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        let tapGesture = UITapGestureRecognizer(target: WineClassMainViewController.self, action: #selector(didTapWineKnowledgeCard))
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    // 카드 이미지뷰
    private let cardImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "ClassSampleImage"))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    // "15초만에 알아가는 와인 지식" 라벨
    private let wineKnowledgeLabel: UILabel = {
        let label = UILabel()
        label.text = "15초만에 알아가는 와인 지식"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    // "이번 달 와인뉴스" 카드 뷰
    private let wineNewsCardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        let tapGesture = UITapGestureRecognizer(target: WineClassMainViewController.self, action: #selector(didTapWineNewsCard))
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    // "이번 달 와인뉴스" 카드 이미지뷰
    private let newsImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "ClassSampleImage"))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    // "이번 달 와인뉴스" 라벨
    private let wineNewsLabel: UILabel = {
        let label = UILabel()
        label.text = "이번 달 와인뉴스"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        // Add subviews
        view.addSubview(titleLabel)
        view.addSubview(searchBar)
        view.addSubview(wineKnowledgeCardView)
        view.addSubview(myCollectionButton)
        view.addSubview(wineNewsCardView)
        
        wineKnowledgeCardView.addSubview(cardImageView)
        wineKnowledgeCardView.addSubview(wineKnowledgeLabel)
        
        wineNewsCardView.addSubview(newsImageView)
        wineNewsCardView.addSubview(wineNewsLabel)
        
        // Layout constraints using SnapKit
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(16)
        }
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        wineKnowledgeCardView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(200)
        }
        
        cardImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        wineKnowledgeLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(10)
            make.leading.equalToSuperview().offset(10)
        }
        
        myCollectionButton.snp.makeConstraints { make in
            make.trailing.equalTo(wineKnowledgeCardView.snp.trailing).inset(16)
            make.centerY.equalTo(wineKnowledgeCardView.snp.centerY)
            make.height.equalTo(30)
            make.width.equalTo(100)
        }
        
        wineNewsCardView.snp.makeConstraints { make in
            make.top.equalTo(wineKnowledgeCardView.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(200)
        }
        
        newsImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        wineNewsLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(10)
            make.leading.equalToSuperview().offset(10)
        }
    }
    
    // MARK: - Actions
    
    @objc private func didTapMyCollectionButton() {
        let myCollectionViewController = MyCollectionViewController()
        navigationController?.pushViewController(myCollectionViewController, animated: true)
    }
    
    @objc private func didTapWineKnowledgeCard() {
        let wineKnowledgeViewController = WineKnowledgeViewController()
        navigationController?.pushViewController(wineKnowledgeViewController, animated: true)
    }
    
    @objc private func didTapWineNewsCard() {
        let wineNewsViewController = WineNewsViewController()
        navigationController?.pushViewController(wineNewsViewController, animated: true)
    }
}
