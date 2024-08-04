//
//  SearchHomeViewController.swift
//  Drink-EG
//
//  Created by 김도연 on 7/20/24.
//

import UIKit
import SnapKit

class SearchHomeViewController : UIViewController, UISearchBarDelegate {

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
        s.searchTextField.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0.89, alpha: 1.0)
        
        return s
    }()
    
//    private let label: UILabel = {
//        let l = UILabel()
//        l.text = "와인 검색"
//        l.font = .systemFont(ofSize: 28, weight: .bold)
//        l.textColor = .black
//        l.numberOfLines = 0
//        return l
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named:"icon_back")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named:"icon_back")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor = .black
        
        self.navigationController?.navigationBar.topItem?.title = "와인 검색"
        self.navigationItem.largeTitleDisplayMode = .always
        
        view.backgroundColor = .white

        setupUI()
    }
    
    private func setupUI() {
        
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view).offset(155)
            make.leading.equalTo(view).offset(16)
            make.height.equalTo(34)
            make.width.equalTo(361)
        }
        
//        view.addSubview(label)
//        label.snp.makeConstraints { make in
//            make.top.equalTo(view).offset(76)
//            make.leading.equalTo(view).offset(16)
//        }
    }
    
    // UISearchBarDelegate 메서드 구현
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        searchBar.resignFirstResponder()
    }
}
