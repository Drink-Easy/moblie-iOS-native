//
//  ClassSelectionViewController.swift
//  Drink-EG
//
//  Created by 김도연 on 10/9/24.
//

import UIKit
import Moya
import SnapKit
import Then

class ClassSelectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource {

    // 카테고리 목록
    private let categories = ["전체 클래스", "레드", "화이트", "스파클링", "기타"]
    private var selectedIndexPath = IndexPath(item: 0, section: 0)
    
    // 더미 데이터 (각 탭에 대한 테이블 뷰 데이터)
    private let tableViewData: [[String]] = [
        ["Item 1", "Item 2", "Item 3"],
        ["Red Wine 1", "Red Wine 2", "Red Wine 3"],
        ["White Wine 1", "White Wine 2", "White Wine 3"],
        ["Sparkling Wine 1", "Sparkling Wine 2", "Sparkling Wine 3"],
        ["Other 1", "Other 2", "Other 3"]
    ]
    
    private let searchBarView = SearchBarView()
    
    // 탭 바
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        $0.collectionViewLayout = layout
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .clear
    }
    
    // 그레이 밑줄 추가
    private let grayUnderlineView = UIView().then {
        $0.backgroundColor = UIColor.lightGray // 기본 그레이 밑줄 색상
    }

    // 퍼플 인디케이터 (선택된 탭 아래 위치)
    private let indicatorView = UIView().then {
        $0.backgroundColor = UIColor(hex: "#5813B1")
    }
    
    // 테이블 뷰
    private let tableView = UITableView().then {
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupCollectionView()
        setupTableView()
        setupLayout()
    }
    
    // MARK: - Setup Methods
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TabCell.self, forCellWithReuseIdentifier: "TabCell")
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupLayout() {
        view.addSubview(searchBarView)
        view.addSubview(collectionView)
        view.addSubview(grayUnderlineView) // 그레이 밑줄 추가
        view.addSubview(indicatorView) // 퍼플 인디케이터 추가
        view.addSubview(tableView)
        
        searchBarView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(50)                  // 적절한 높이 설정 (필요에 따라 조정 가능)
        }
        
        // 컬렉션 뷰 레이아웃
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBarView.snp.bottom)
            make.left.equalTo(searchBarView.snp.left)
            make.right.equalTo(searchBarView.snp.right)
            make.height.equalTo(50)
        }
        
        grayUnderlineView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.left.equalTo(searchBarView.snp.left)
            make.right.equalTo(searchBarView.snp.right)
            make.height.equalTo(2)  // 높이 2포인트
        }
        
        // 퍼플 인디케이터 초기 위치 설정 (첫 번째 탭 아래)
        indicatorView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.height.equalTo(2)
            make.width.equalTo(93) // 첫 번째 탭 길이
            make.left.equalTo(searchBarView.snp.left)
        }
        
        // 테이블 뷰 레이아웃 설정
        tableView.snp.makeConstraints { make in
            make.top.equalTo(indicatorView.snp.bottom)
            make.left.equalTo(searchBarView.snp.left)
            make.right.equalTo(searchBarView.snp.right)
            make.bottom.equalToSuperview()
        }
    }

    
    // MARK: - CollectionView DataSource & Delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TabCell", for: indexPath) as? TabCell else {
            return UICollectionViewCell()
        }
        
        let category = categories[indexPath.item]
        cell.configure(text: category, isSelected: indexPath == selectedIndexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath

        if let selectedCell = collectionView.cellForItem(at: indexPath) {
            let cellMinX = selectedCell.frame.minX
            
            if indexPath.item == categories.count - 1 {
                // 마지막 셀인 경우
                indicatorView.snp.remakeConstraints { make in
                    make.top.equalTo(collectionView.snp.bottom)
                    make.height.equalTo(2)
                    make.right.equalToSuperview().offset(-16) // 오른쪽에서 16포인트 간격
                    make.left.equalTo(grayUnderlineView.snp.left).offset(cellMinX) // 시작점은 셀의 minX에서 설정
                }
            } else {
                // 마지막 셀이 아닌 경우
                indicatorView.snp.remakeConstraints { make in
                    make.top.equalTo(collectionView.snp.bottom)
                    make.height.equalTo(2)
                    make.width.equalTo(selectedCell.frame.width) // 선택된 셀의 너비로 설정
                    make.left.equalTo(grayUnderlineView.snp.left).offset(cellMinX) // grayUnderlineView의 left에 minX 오프셋 추가
                }
            }

            // 애니메이션으로 레이아웃 업데이트
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
        
        // 테이블 뷰 데이터 업데이트
        tableView.reloadData()
        collectionView.reloadData()
    }
    
    // 셀 크기 설정 (텍스트 길이에 따라 동적 크기)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = categories[indexPath.item]
        let font = UIFont.systemFont(ofSize: 16)
        let width = text.size(withAttributes: [.font: font]).width + 20
        return CGSize(width: width, height: collectionView.frame.height)
    }
    
    // MARK: - TableView DataSource & Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData[selectedIndexPath.item].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        cell.textLabel?.text = tableViewData[selectedIndexPath.item][indexPath.row]
        return cell
    }
}


// 가로 스크롤을 시도해보았지만 망한 코드
// TODO : 나중에 수정하기
//class ClassSelectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
//
//    // 카테고리 목록
//    private let categories = ["전체 클래스", "레드", "화이트", "스파클링", "기타"]
//    private var selectedIndexPath = IndexPath(item: 0, section: 0)
//    
//    // 더미 데이터 (각 탭에 대한 테이블 뷰 데이터)
//    private let tableViewData: [[String]] = [
//        ["Item 1", "Item 2", "Item 3"],
//        ["Red Wine 1", "Red Wine 2", "Red Wine 3"],
//        ["White Wine 1", "White Wine 2", "White Wine 3"],
//        ["Sparkling Wine 1", "Sparkling Wine 2", "Sparkling Wine 3"],
//        ["Other 1", "Other 2", "Other 3"]
//    ]
//    
//    private let searchBarView = SearchBarView()
//    
//    // 탭 바 (가로 스크롤 페이징을 위한 collectionView)
//    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        layout.minimumLineSpacing = 20
//        $0.collectionViewLayout = layout
//        $0.showsHorizontalScrollIndicator = false
//        $0.backgroundColor = .clear
//    }
//    
//    // 그레이 밑줄 추가
//    private let grayUnderlineView = UIView().then {
//        $0.backgroundColor = UIColor.lightGray // 기본 그레이 밑줄 색상
//    }
//
//    // 퍼플 인디케이터 (선택된 탭 아래 위치)
//    private let indicatorView = UIView().then {
//        $0.backgroundColor = UIColor(hex: "#5813B1")
//    }
//    
//    // 테이블 뷰가 포함된 **UIScrollView** (수평 페이징)
//    private let tableViewScrollView = UIScrollView().then {
//        $0.isPagingEnabled = true // 페이징 활성화
//        $0.showsHorizontalScrollIndicator = false
//    }
//    
//    // 테이블 뷰들 (각각의 탭에 해당하는 테이블 뷰)
//    private var tableViews: [UITableView] = []
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        
//        setupCollectionView()
//        setupTableViewScrollView()
//        setupLayout()
//    }
//    
//    // MARK: - Setup Methods
//    
//    private func setupCollectionView() {
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.register(TabCell.self, forCellWithReuseIdentifier: "TabCell")
//    }
//    
//    private func setupTableViewScrollView() {
//        tableViewScrollView.delegate = self
//        
//        // 각 카테고리에 맞는 테이블 뷰 생성
//        for _ in categories {
//            let tableView = UITableView().then {
//                $0.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
//                $0.dataSource = self
//                $0.delegate = self
//            }
//            tableViews.append(tableView)
//            tableViewScrollView.addSubview(tableView)
//        }
//    }
//    
//    private func setupLayout() {
//        view.addSubview(searchBarView)
//        view.addSubview(collectionView)
//        view.addSubview(grayUnderlineView) // 그레이 밑줄 추가
//        view.addSubview(indicatorView) // 퍼플 인디케이터 추가
//        view.addSubview(tableViewScrollView) // 테이블 뷰들을 담을 스크롤 뷰 추가
//        
//        searchBarView.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide)
//            make.left.equalToSuperview().offset(16)
//            make.right.equalToSuperview().inset(16)
//            make.height.equalTo(50)
//        }
//        
//        // 컬렉션 뷰 레이아웃
//        collectionView.snp.makeConstraints { make in
//            make.top.equalTo(searchBarView.snp.bottom)
//            make.left.equalTo(searchBarView.snp.left)
//            make.right.equalTo(searchBarView.snp.right)
//            make.height.equalTo(50)
//        }
//        
//        grayUnderlineView.snp.makeConstraints { make in
//            make.top.equalTo(collectionView.snp.bottom)
//            make.left.equalTo(searchBarView.snp.left)
//            make.right.equalTo(searchBarView.snp.right)
//            make.height.equalTo(2)  // 높이 2포인트
//        }
//        
//        // 퍼플 인디케이터 초기 위치 설정 (첫 번째 탭 아래)
//        indicatorView.snp.makeConstraints { make in
//            make.top.equalTo(collectionView.snp.bottom)
//            make.height.equalTo(2)
//            make.width.equalTo(93) // 첫 번째 탭 길이
//            make.left.equalTo(searchBarView.snp.left)
//        }
//        
//        // 테이블 뷰 스크롤 뷰 레이아웃 설정
//        tableViewScrollView.snp.makeConstraints { make in
//            make.top.equalTo(indicatorView.snp.bottom)
//            make.left.equalTo(searchBarView.snp.left)
//            make.right.equalTo(searchBarView.snp.right)
//            make.bottom.equalToSuperview()
//        }
//        
//        // 각 테이블 뷰의 레이아웃 설정
//        for (index, tableView) in tableViews.enumerated() {
//            tableView.snp.makeConstraints { make in
//                make.top.bottom.equalToSuperview()
//                make.width.equalTo(view.snp.width)
//                make.left.equalToSuperview().offset(view.frame.width * CGFloat(index)) // 좌우로 스와이프 가능하도록 설정
//            }
//        }
//        
//        tableViewScrollView.contentSize = CGSize(width: view.frame.width * CGFloat(categories.count), height: 0)
//    }
//    
//    // MARK: - CollectionView DataSource & Delegate
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return categories.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TabCell", for: indexPath) as? TabCell else {
//            return UICollectionViewCell()
//        }
//        
//        let category = categories[indexPath.item]
//        cell.configure(text: category, isSelected: indexPath == selectedIndexPath)
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        selectedIndexPath = indexPath
//
//        let offsetX = CGFloat(indexPath.item) * view.frame.width
//        tableViewScrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
//        
//        // 테이블 뷰 데이터 업데이트
//        let selectedTableView = tableViews[indexPath.item]
//        selectedTableView.reloadData()
//        collectionView.reloadData()
//    }
//    
//    // MARK: - ScrollView Delegate (테이블 뷰 스크롤 시 컬렉션 뷰 동기화)
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let pageIndex = Int(scrollView.contentOffset.x / view.frame.width)
//        selectedIndexPath = IndexPath(item: pageIndex, section: 0)
//        
//        // 컬렉션 뷰도 선택된 인덱스에 맞춰 스크롤
//        collectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .centeredHorizontally)
//        
//        // 컬렉션 뷰 업데이트
//        collectionView.reloadData()
//    }
//
//    // MARK: - TableView DataSource & Delegate
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return tableViewData[selectedIndexPath.item].count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
//        cell.textLabel?.text = tableViewData[selectedIndexPath.item][indexPath.row]
//        return cell
//    }
//}

