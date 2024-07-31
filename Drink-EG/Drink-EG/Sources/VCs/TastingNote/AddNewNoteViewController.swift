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
    
    let wineSearchBar = UITextField()
    let suggestionTableView = UITableView()
    var suggestion: [String] = []
    var allSuggestion: [String] = ["Apple", "Banana", "Grape", "Orange", "Watermelon", "Strawberry"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        setupWineSearchBar()
        setupWineSearchBarConstraints()
        setupSuggestionTableView()
        setupSuggestionTableViewConstraints()
    }
    
    func setupView() {
        view.addSubview(wineSearchBar)
        view.addSubview(suggestionTableView)
    }
    
    func setupWineSearchBar() {
        wineSearchBar.delegate = self
        wineSearchBar.placeholder = "와인 이름 입력 검색"
        wineSearchBar.backgroundColor = .lightGray
        wineSearchBar.tintColor = .blue
    }
    
    func setupWineSearchBarConstraints() {
        wineSearchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.height.equalTo(50)
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
