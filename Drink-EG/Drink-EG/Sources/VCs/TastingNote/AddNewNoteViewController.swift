//
//  AddNewNoteViewController.swift
//  Drink-EG
//
//  Created by 김도연 on 7/21/24.
//

import Foundation
import UIKit
import SnapKit


class AddNewNoteViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    
    let tastingnoteLabel = UILabel()
    let wineSearchBar = UITextField()
    let suggestionTableView = UITableView()
    var suggestion: [String] = []
    var allSuggestion: [String] = ["Apple", "Banana", "Grape", "Orange", "Watermelon", "Strawberry"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        setupLabel()
        setuptastingnoteLabelConstraints()
        setupWineSearchBar()
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
        tastingnoteLabel.font = .boldSystemFont(ofSize: 30)
        tastingnoteLabel.textAlignment = .center
        tastingnoteLabel.textColor = .black
    }
    
    func setuptastingnoteLabelConstraints() { // Label의 제약 조건을 설정하는 함수
        tastingnoteLabel.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(46)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
        }
    }
    
    func setupWineSearchBar() {
        wineSearchBar.isUserInteractionEnabled = true
        let searchIcon = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        searchIcon.tintColor = UIColor(hex: "767676")
        searchIcon.contentMode = .scaleAspectFit
        
        let iconContainer = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 34))
        iconContainer.addSubview(searchIcon)
        
        wineSearchBar.delegate = self
        wineSearchBar.placeholder = "와인 이름 입력 검색"
        wineSearchBar.textColor = UIColor(hex: "767676")
        wineSearchBar.backgroundColor = UIColor(hex: "E5E5E5")
        wineSearchBar.layer.cornerRadius = 10
        wineSearchBar.leftView = iconContainer
        wineSearchBar.leftViewMode = .always
        
        searchIcon.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(13)
            make.width.equalTo(18)
            make.height.equalTo(17)
        }
        
    }
    
    func setupWineSearchBarConstraints() {
        wineSearchBar.snp.makeConstraints { make in
            make.top.equalTo(tastingnoteLabel.snp.bottom).offset(55)
            make.leading.equalTo(tastingnoteLabel.snp.leading)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            make.height.equalTo(34)
        }
        
    }
    
    func setupSuggestionTableView() {
        suggestionTableView.dataSource = self
        suggestionTableView.delegate = self
        suggestionTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func setupSuggestionTableViewConstraints() {
        suggestionTableView.snp.makeConstraints{ make in
            make.top.equalTo(wineSearchBar.snp.bottom).offset(0)
            make.width.equalTo(wineSearchBar.snp.width)
            make.height.equalTo(200)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let currentText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
            filterSuggestions(with: currentText)
            return true
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
        wineSearchBar.text = selectedSuggestion
        suggestion = []
        suggestionTableView.reloadData()
    }
}
