//
//  SearchHomeViewController.swift
//  Drink-EG
//
//  Created by 김도연 on 7/20/24.
//

import UIKit
import SnapKit

class SearchHomeViewController : UIViewController, UISearchBarDelegate {
    
    var selectedWine: String?
    var suggestion: [String] = []
    var allSuggestion: [String] = ["Castello Monaci", "Dos Copas", "Loxton", "Red Label", "Samos", "Vendredi"]

    lazy var searchBar: UISearchBar = {
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
            let placeholderText = "와인 이름 검색"
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor(hue: 0, saturation: 0, brightness: 0.45, alpha: 1.0), // 색상 설정
                .font: UIFont.boldSystemFont(ofSize: 12) // 크기 설정
            ]
            textField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        }
        s.searchTextField.backgroundColor = UIColor(hex: "#E5E5E5")
        
        return s
    }()
    
    private let label: UILabel = {
        let l = UILabel()
        l.text = "와인 검색"
        l.font = .systemFont(ofSize: 28, weight: UIFont.Weight(700))
        l.textColor = .black
        l.numberOfLines = 0
        return l
    }()
    
    lazy var WineListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(WineListCollectionViewCell.self, forCellWithReuseIdentifier: "WineListCollectionViewCell")
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        
        cv.decelerationRate = .fast
        cv.backgroundColor = .clear
        cv.layer.cornerRadius = 10
        
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor = .black
        
        view.backgroundColor = .white

        setupUI()
    }
    
    private func setupUI() {
        
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(27)
        }
        
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(10)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.greaterThanOrEqualTo(34)
        }
        
        view.addSubview(WineListCollectionView)
        WineListCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // UISearchBarDelegate 메서드 구현
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard searchBar.text != nil else { return }
        searchBar.resignFirstResponder()
    }
    
    // 배경 클릭시 키보드 내림  ==> view 에 터치가 들어오면 에디팅모드를 끝냄.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)  //firstresponder가 전부 사라짐
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
        WineListCollectionView.reloadData()
    }
}

extension SearchHomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return suggestion.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WineListCollectionViewCell", for: indexPath) as! WineListCollectionViewCell
            
        cell.configure(imageName: suggestion[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedWine = suggestion[indexPath.item]
        let wineInfoViewController = WineInfoViewController()
        wineInfoViewController.wine = selectedWine
        navigationController?.pushViewController(wineInfoViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 94)
    }
    
    private func collectionView(_ collectionView: UICollectionView, didSelectRowAt indexPath: IndexPath) {
        let selectedSuggestion = suggestion[indexPath.row]
        searchBar.text = selectedSuggestion
        suggestion = []
        WineListCollectionView.reloadData()
    }
}
