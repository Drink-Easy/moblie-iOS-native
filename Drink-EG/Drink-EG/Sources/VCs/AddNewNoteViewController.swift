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
import SDWebImage

class AddNewNoteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    let provider = MoyaProvider<TastingNoteAPI>(plugins: [CookiePlugin()])
    
    let tastingnoteLabel = UILabel()
    let suggestionTableView = UITableView()

    var wineResults: [Wine] = []
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        setupLabel()
        setuptastingnoteLabelConstraints()
        setupWineSearchBarConstraints()
        setupSuggestionTableView()
        setupSuggestionTableViewConstraints()
        setupNavigationBarButton()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)  //firstresponder가 전부 사라짐
    }
    
    func setupView() {
        view.addSubview(tastingnoteLabel)
        view.addSubview(wineSearchBar)
        view.addSubview(suggestionTableView)
    }
    
    func setupNavigationBarButton() {
        navigationItem.hidesBackButton = false
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
        tastingnoteLabel.font = .systemFont(ofSize: UIConstants.labelFontSize, weight: UIFont.Weight(rawValue: 700))
        tastingnoteLabel.textAlignment = .center
        tastingnoteLabel.textColor = .black
    }
    
    func setuptastingnoteLabelConstraints() { // Label의 제약 조건을 설정하는 함수
        tastingnoteLabel.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(27)
        }
    }
    
    func setupWineSearchBarConstraints() {
        wineSearchBar.snp.makeConstraints { make in
            make.top.equalTo(tastingnoteLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.greaterThanOrEqualTo(UIConstants.searchBarHeight)
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
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-188)
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            wineResults = []
            suggestionTableView.reloadData()
        } else {
            fetchWineSuggestion(with: searchText)
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8 // 섹션 간의 간격
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wineResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomSuggestionCell
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05).cgColor
        cell.layer.cornerRadius = 10
        cell.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        
        let wine = wineResults[indexPath.row]
        cell.configure(with: wine, isSelected: false)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //return 94
        let screenHeight = UIScreen.main.bounds.height
        let cellHeight = screenHeight * 0.11
        
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedWine = wineResults[indexPath.row]
        wineSearchBar.text = selectedWine.name
        wineResults = []
        suggestionTableView.reloadData()
        // 다음 화면으로 이동
        let nextVC = WriteNoteViewController()
        nextVC.selectedWineName = selectedWine.name
        nextVC.selectedWineImage = selectedWine.imageUrl
        nextVC.selectedWineId = selectedWine.wineId
        nextVC.selectedWineSort = selectedWine.sort
        nextVC.selectedWineArea = selectedWine.area
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func fetchWineSuggestion(with query: String) {
        provider.request(.getWineName(wineName: query)) { result in
            switch result {
            case .success(let response):
                do {
                    let responseData = try JSONDecoder().decode(APIResponseWineSearchResponse.self, from: response.data)
                    print(responseData)
                    self.wineResults = responseData.result
                    self.suggestionTableView.reloadData()
                } catch {
                    print("Failed to decode response: \(error)")
                }
            case.failure(let error):
                print("Error: \(error.localizedDescription)")
                if let response = error.response {
                    print("Response Body: \(String(data: response.data, encoding: .utf8) ?? "")")
                }
            }
        }
    }
}
