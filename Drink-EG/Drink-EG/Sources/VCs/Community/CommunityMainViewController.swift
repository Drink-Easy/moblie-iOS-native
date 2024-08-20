//
//  CommunityMainViewController.swift
//  Drink-EG
//
//  Created by 김도연 on 7/21/24.
//

import UIKit
import SnapKit

class CommunityMainViewController : UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIViewControllerTransitioningDelegate{
    
    let communityLabel = UILabel()
    let suggestionTableView = UITableView()
    let lookaroundButton = UIButton()
    let deadlineLabel = UILabel()
    let newCreate = UILabel()
    var communityLowerCollectionViews: [CustomCollectionViewCell] = []
    var suggestion: [String] = []
    var allSuggestion: [String] = [""]
    
    private let items = [
            ["title": "금요일 밤 와인모임", "subtitle": "강남역에서 가볍게 함께 즐겨요!", "detail": "7/10 | 서울특별시, 서초구 | 27,000원", "imageName": "Red Label"],
            ["title": "목요일 밤 와인모임", "subtitle": "뚝섬역에서 가볍게 함께 즐겨요!", "detail": "6/10 | 서울특별시, 용산구 | 25,000원", "imageName": "ClassSampleImage"],
            ["title": "수요일 밤 와인모임", "subtitle": "양재역에서 가볍게 함께 즐겨요!", "detail": "9/10 | 서울특별시, 서초구 | 20,000원", "imageName": "Loxton"],
            ["title": "화요일 밤 와인모임", "subtitle": "용산역에서 가볍게 함께 즐겨요!", "detail": "3/10 | 서울특별시, 용산구 | 25,000원", "imageName": "Samos"],
        ]
    
    lazy var communitySearchBar: UISearchBar = {
        let s = UISearchBar()
        s.delegate = self
        //경계선 제거
        s.searchBarStyle = .minimal
        s.layer.cornerRadius = 8
        s.layer.masksToBounds = true
        
        if let searchIcon = UIImage(named: "icon_search") {
            s.setImage(searchIcon, for: .search, state: .normal)
        }
        if let textField = s.value(forKey: "searchField") as? UITextField {
            // Placeholder 텍스트 속성 설정
            let placeholderText = "모임 검색"
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor(hue: 0, saturation: 0, brightness: 0.45, alpha: 1.0), // 색상 설정
                .font: UIFont.boldSystemFont(ofSize: 12) // 크기 설정
            ]
            textField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        }
        s.searchTextField.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0.89, alpha: 1.0)
        
        return s
    }()
    
    lazy var communityUpperCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(hex: "E5E5E5")
        collectionView.layer.cornerRadius = 10
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCollectionViewCell")
        return collectionView
    }()
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.numberOfPages = items.count
        pc.currentPage = 0
        pc.pageIndicatorTintColor = .lightGray
        pc.currentPageIndicatorTintColor = .black
        return pc
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        return UIView()
    }()
    
    lazy var lowerCollectionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.layer.cornerRadius = 10
        return stackView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        super.viewDidLoad()
        
        setupScrollView()
        setupView()
        setupNavigationBarButton()
        setupLabel()
        setupcommunityLabelConstraints()
        setupcommunitySearchBarConstraints()
        setupSuggestionTableView()
        setupSuggestionTableViewConstraints()
        setupLookAroundButton()
        setupLookAroundButtonConstraints()
        setupDeadLineLabel()
        setupDeadLineLabelConstraints()
        setupCommunityUpperCollectionViewConstraints()
        setupPageControlConstraints()
        setupNewCreateLabel()
        setupNewCreateLabelConstraints()
        setupCommunityLowerCollectionView()
        setupStackViewConstraints()
    }
    
    func setupView() {
        contentView.addSubview(communityLabel)
        contentView.addSubview(communitySearchBar)
        contentView.addSubview(suggestionTableView)
        contentView.addSubview(lookaroundButton)
        contentView.addSubview(deadlineLabel)
        contentView.addSubview(newCreate)
        contentView.addSubview(communityUpperCollectionView)
        contentView.addSubview(pageControl)
        contentView.addSubview(lowerCollectionStackView)
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.height.greaterThanOrEqualTo(view.snp.height).offset(500)
        }
        
    }
    
    func setupNavigationBarButton() {
        navigationItem.hidesBackButton = true
        let backArrow = UIImage(systemName: "chevron.backward")
        let leftButton = UIBarButtonItem(image: backArrow, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = leftButton
        leftButton.tintColor = .black
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func setupLabel() { // Label의 기본 속성을 설정하는 함수
        communityLabel.text = "와인 모임"
        communityLabel.font = UIFont(name: "Pretendard-Bold", size: 28)
        communityLabel.textAlignment = .center
        communityLabel.textColor = .black
    }
    
    func setupcommunityLabelConstraints() { // Label의 제약 조건을 설정하는 함수
        communityLabel.snp.makeConstraints{ make in
            make.top.equalTo(contentView.snp.top).offset(46)
            make.leading.equalTo(contentView.snp.leading).offset(16)
        }
    }
    
    func setupcommunitySearchBarConstraints() {
        communitySearchBar.snp.makeConstraints { make in
            make.top.equalTo(communityLabel.snp.bottom).offset(46)
            make.leading.equalTo(communityLabel.snp.leading)
            make.centerX.equalTo(contentView.snp.centerX)
            make.height.equalTo(UIConstants.searchBarHeight)
        }
    }
    
    func setupSuggestionTableView() {
        suggestionTableView.dataSource = self
        suggestionTableView.delegate = self
        suggestionTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func setupSuggestionTableViewConstraints() {
        suggestionTableView.snp.makeConstraints{ make in
            make.top.equalTo(communitySearchBar.snp.bottom).offset(0)
            make.width.equalTo(communitySearchBar.snp.width)
            make.height.equalTo(200)
        }
    }
    
    func setupLookAroundButton() {
        lookaroundButton.setTitle("모임 개설하기", for: .normal)
        lookaroundButton.backgroundColor = UIColor(hex: "FA735B")
        lookaroundButton.layer.cornerRadius = 16
        lookaroundButton.setTitleColor(.white, for: .normal)
        lookaroundButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    func setupLookAroundButtonConstraints() {
        lookaroundButton.snp.makeConstraints{ make in
            make.top.equalTo(lowerCollectionStackView.snp.bottom).offset(30)
            make.centerX.equalTo(lowerCollectionStackView.snp.centerX)
            make.leading.equalTo(lowerCollectionStackView.snp.leading).offset(16)
            make.height.greaterThanOrEqualTo(61)
        }   
    }
    
    func setupDeadLineLabel() {
        deadlineLabel.text = "마감 임박!"
        deadlineLabel.font = UIFont(name: "Pretendard-Bold", size: 20)
        deadlineLabel.textAlignment = .center
        deadlineLabel.textColor = .black
    }
    
    func setupDeadLineLabelConstraints() {
        deadlineLabel.snp.makeConstraints{ make in
            make.top.equalTo(communitySearchBar.snp.bottom).offset(55)
            make.leading.equalTo(communitySearchBar.snp.leading)
        }
    }
    
    func setupNewCreateLabel() {
        newCreate.text = "방금 생겼어요"
        newCreate.font = UIFont(name: "Pretendard-Bold", size: 20)
        newCreate.textAlignment = .center
        newCreate.textColor = .black
    }
    
    func setupNewCreateLabelConstraints() {
        newCreate.snp.makeConstraints { make in
            make.top.equalTo(communityUpperCollectionView.snp.bottom).offset(67)
            make.leading.equalTo(communityUpperCollectionView.snp.leading)
        }
    }
    
    func setupCommunityUpperCollectionViewConstraints() {
        communityUpperCollectionView.snp.makeConstraints{ make in
            make.top.equalTo(deadlineLabel.snp.bottom).offset(24)
            make.leading.equalTo(deadlineLabel.snp.leading)
            make.centerX.equalTo(contentView.snp.centerX)
            make.height.greaterThanOrEqualTo(109)
        }
    }
    
    func setupCommunityLowerCollectionView() {
        for (index, item) in items.enumerated() {
            let collectionView = CustomCollectionViewCell(frame: .zero)
            collectionView.backgroundColor = UIColor(hex: "E5E5E5")
            collectionView.configure(title: item["title"]!, subtitle: item["subtitle"]! , detail: item["detail"]!, imageName: item["imageName"]!)
            
            // 여기에 추가된 코드
            collectionView.layer.cornerRadius = 10
            collectionView.layer.masksToBounds = true
            collectionView.contentView.layer.cornerRadius = 10
            collectionView.contentView.layer.masksToBounds = true
            
            collectionView.snp.makeConstraints { make in
                make.height.equalTo(109)
            }
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(lowerCollectionCellTapped(_:)))
            collectionView.addGestureRecognizer(tapGesture)
            collectionView.tag = index
            lowerCollectionStackView.addArrangedSubview(collectionView)
            communityLowerCollectionViews.append(collectionView)
        }
    }
    
    @objc func lowerCollectionCellTapped(_ sender: UITapGestureRecognizer) {
        guard let tappedCell = sender.view as? CustomCollectionViewCell else { return }

        // 바로 모달 뷰를 프레젠트
        let modalVC = ModalViewController()
        modalVC.modalPresentationStyle = .pageSheet
        modalVC.modalTransitionStyle = .coverVertical
        self.present(modalVC, animated: true, completion: nil)
    }
    
    
    func setupStackViewConstraints() {
        lowerCollectionStackView.snp.makeConstraints { make in
            make.top.equalTo(newCreate.snp.bottom).offset(24)
            make.leading.equalTo(newCreate.snp.leading)
            make.centerX.equalTo(contentView.snp.centerX)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
        let item = items[indexPath.item]
        cell.configure(title: item["title"]!, subtitle: item["subtitle"]!, detail: item["detail"]!, imageName: item["imageName"]!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 모달 뷰
        let modalVC = ModalViewController()
        modalVC.modalPresentationStyle = .pageSheet
        modalVC.modalTransitionStyle = .coverVertical
        self.present(modalVC, animated: true, completion: nil)
    }
    
    func setupPageControlConstraints() {
        pageControl.snp.makeConstraints{ make in
            make.top.equalTo(communityUpperCollectionView.snp.bottom).offset(20)
            make.centerX.equalTo(communityUpperCollectionView.snp.centerX)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterSuggestions(with: searchText)
    }

    func filterSuggestions(with query: String) {
        if query.isEmpty {
                suggestion = []
        } else {
            suggestion = allSuggestion.filter { $0.lowercased().contains(query.lowercased()) }
        }
        suggestionTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suggestion.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = suggestion[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSuggestion = suggestion[indexPath.row]
        communitySearchBar.text = selectedSuggestion
        suggestion = []
        suggestionTableView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
