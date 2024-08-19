//
//  MyPageQnaViewController.swift
//  Drink-EG
//
//  Created by 이호연 on 8/16/24.
//

import UIKit
import SnapKit

class MyPageQnaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let myPageQnaFirstMenu = ["메일 문의", "채팅 문의", "전화 문의"]
    let myPageQnaSecondMenu = ["문의 내역 조회"]
    let myPageQnaFirstMenuIcons = [
            UIImage(systemName: "envelope.fill"),
            UIImage(systemName: "message"),
            UIImage(systemName: "phone")      
        ]
    
    let cellID = "MyPageSettingsCellID"
    let tableView = UITableView(frame: .zero, style: .grouped)
    

    private let label: UILabel = {
        let l = UILabel()
        l.text = "1:1 문의하기"
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
        
        tableView.register(MyPageQnaCell.self, forCellReuseIdentifier: cellID)


        
        label.snp.makeConstraints { make in
                    make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
                    make.leading.equalTo(view.snp.leading).offset(20)
                }
                
        tableView.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(20)
            make.left.right.bottom.equalTo(view)
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return myPageQnaFirstMenu.count
        }
        else {
            return myPageQnaSecondMenu.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? MyPageQnaCell else {
            fatalError("Failed to dequeue MyPageQnaCell")
        }
        
        cell.backgroundColor = UIColor(hex: "D9D9D9")
        if indexPath.section == 0{
            cell.menuLabel.text = myPageQnaFirstMenu[indexPath.row]
            cell.iconImageView.image = myPageQnaFirstMenuIcons[indexPath.row]
            cell.imageView?.tintColor = .black
            
        }
        else {
            cell.menuLabel.text = myPageQnaSecondMenu[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return 10 // 원하는 섹션 간 간격으로 설정
        }

        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
            headerView.backgroundColor = .clear
            return headerView
        }

        func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
            let footerView = UIView()
            footerView.backgroundColor = .clear
            return footerView
        }
}



class MyPageQnaCell: UITableViewCell {
    
    let menuLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        contentView.addSubview(menuLabel)
        contentView.addSubview(iconImageView)

        iconImageView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.equalTo(contentView.snp.leading).offset(20)
            make.width.height.equalTo(17)
        }
        
        menuLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.equalTo(iconImageView.snp.trailing).offset(10)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-16)
        }
    }
}
