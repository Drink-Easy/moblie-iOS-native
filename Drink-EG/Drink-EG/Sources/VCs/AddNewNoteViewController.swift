//
//  AddNewNoteViewController.swift
//  Drink-EG
//
//  Created by 김도연 on 7/21/24.
//

import Foundation
import UIKit
import SnapKit
import Moya


class AddNewNoteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    let provider = MoyaProvider<TastingNoteAPI>()
    
    let tastingnoteLabel = UILabel()
    let suggestionTableView = UITableView()
    var suggestion: [String] = []
    var allSuggestion: [String] = ["19 Crhnes", "John Kosovich", "CNDULE", "Orange", "Watermelon", "Strawberry"]
    
    lazy var wineSearchBar: UISearchBar = {
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
                .font: UIFont(name: "Pretendard-SemiBold", size: 12)! // 크기 설정
            ]
            textField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        }
        s.searchTextField.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0.89, alpha: 1.0)
        
        return s
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupAPI()
        setupView()
        setupLabel()
        setuptastingnoteLabelConstraints()
        setupWineSearchBarConstraints()
        setupSuggestionTableView()
        setupSuggestionTableViewConstraints()
        setupNavigationBarButton()
    }
    
    func setupView() {
        view.addSubview(tastingnoteLabel)
        view.addSubview(wineSearchBar)
        view.addSubview(suggestionTableView)
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
        tastingnoteLabel.text = "테이스팅 노트"
        tastingnoteLabel.font = UIFont(name: "Pretendard-Bold", size: 28)
        tastingnoteLabel.textAlignment = .center
        tastingnoteLabel.textColor = .black
    }
    
    func setuptastingnoteLabelConstraints() { // Label의 제약 조건을 설정하는 함수
        tastingnoteLabel.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(46)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
        }
    }
    
    func setupWineSearchBarConstraints() {
        wineSearchBar.snp.makeConstraints { make in
            make.top.equalTo(tastingnoteLabel.snp.bottom).offset(46)
            make.leading.equalTo(tastingnoteLabel.snp.leading)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            make.height.equalTo(34)
        }
        
    }

    func setupSuggestionTableView() {
        suggestionTableView.dataSource = self
        suggestionTableView.delegate = self
        suggestionTableView.register(CustomSuggestionCell.self, forCellReuseIdentifier: "cell")
    }

    func setupSuggestionTableViewConstraints() {
        suggestionTableView.snp.makeConstraints{ make in
            make.top.equalTo(wineSearchBar.snp.bottom).offset(35)
            make.leading.equalTo(wineSearchBar.snp.leading).offset(13)
            make.trailing.equalTo(wineSearchBar.snp.trailing).offset(-13)
            make.height.greaterThanOrEqualTo(282)
        }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomSuggestionCell
        let imageName = "Loxton"
        let image = UIImage(named: imageName)!
        cell.backgroundColor = UIColor(hex: "E5E5E5")
        cell.layer.cornerRadius = 10
        cell.configure(image: image, text: suggestion[indexPath.row], isSelected: false)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //return 94
        let screenHeight = UIScreen.main.bounds.height
        let cellHeight = screenHeight * 0.11
        
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSuggestion = suggestion[indexPath.row]
        wineSearchBar.text = selectedSuggestion
        suggestion = []
        suggestionTableView.reloadData()
        let nextVC = WriteNoteViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }

    func setupAPI() {
        provider.request(.getWineName(wineName: "19 Crhnes")) { result in
            switch result {
            case .success(let response):
                do {
                    let data = try response.mapJSON()
                    print(data)
                } catch {
                    print(error)
                }
            case.failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
