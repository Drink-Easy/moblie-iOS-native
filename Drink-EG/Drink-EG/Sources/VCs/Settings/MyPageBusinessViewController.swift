//
//  MyPageBusinessViewController.swift
//  Drink-EG
//
//  Created by 이호연 on 8/16/24.
//

import UIKit

class MyPageBusinessViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let myPageMenu = ["제휴 문의", "판매자 입점 문의"]
    let cellID = "MyPageSettingsCellID"
    let tableView = UITableView(frame: .zero, style: .grouped)
    

    private let label: UILabel = {
        let l = UILabel()
        l.text = "제휴,입점 문의"
        l.font = .systemFont(ofSize: 28, weight: .bold)
        l.textColor = .black
        l.numberOfLines = 0
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBarButton()
        configureUI()
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
    
    func configureUI() {
        
        view.backgroundColor = .white
        
        view.addSubview(label)
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(MyPageBusinessCell.self, forCellReuseIdentifier: cellID)
        

        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPageMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? MyPageBusinessCell else {
            fatalError("Failed to dequeue MyPageSettingsCell")
        }
        cell.menuLabel.text = myPageMenu[indexPath.row]
        cell.backgroundColor = UIColor(hex: "D9D9D9")
        return cell
    }
    
    
}

class MyPageBusinessCell: UITableViewCell {
    
    let menuLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        addSubview(menuLabel)
        menuLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            menuLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            menuLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 12)
        ])
    }
}

