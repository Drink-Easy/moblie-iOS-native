//
//  MyPageNoticeViewController.swift
//  Drink-EG
//
//  Created by 이호연 on 8/16/24.
//

import UIKit
import SnapKit

private let cellID = "MyPageNoticeCellID"

class MyPageNoticeViewController: UIViewController {

    let myPageNoticeFirstMenu = ["[공지] 개인정보 처리방침 변경 안내", "[공지] 구매, 판매처 관련 안내", "[공지] 업데이트 안내", "[공지] 주의사항 안내", "모두보기"]
    let myPageNoticeSecondMenu = ["[공지] 클래스 이벤트 당첨자 안내", "[공지] 8월의 할인 혜택 안내", "모두보기"]
    
    let tableView = UITableView(frame: .zero, style: .grouped)

    private let label: UILabel = {
        let l = UILabel()
        l.text = "공지사항"
        l.font = .systemFont(ofSize: 28, weight: .bold)
        l.textColor = .black
        l.numberOfLines = 0
        return l
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarButton()
        setupUI()
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

    func setupUI() {
        view.backgroundColor = .white

        // Label 추가
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(27)
        }

        view.addSubview(tableView)
        tableView.backgroundColor = .white

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyPageNoticeCell.self, forCellReuseIdentifier: cellID)


        tableView.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(20)
            make.left.right.bottom.equalTo(view)
        }


    }
}

extension MyPageNoticeViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return myPageNoticeFirstMenu.count
        } else {
            return myPageNoticeSecondMenu.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! MyPageNoticeCell
        cell.backgroundColor = UIColor(hex: "D9D9D9")
        cell.menuLabel.textColor = .black
        cell.iconImageView.image = nil


        if indexPath.section == 0 {
            let menuTitle = myPageNoticeFirstMenu[indexPath.row]
            cell.menuLabel.text = menuTitle
            if menuTitle == "모두보기" {
                cell.backgroundColor = .white
                tableView.separatorStyle = .none

                cell.menuLabel.textColor = UIColor(hex: "FA735B")
                cell.iconImageView.image = UIImage(systemName: "arrowtriangle.down.fill")?.withRenderingMode(.alwaysTemplate)
                cell.iconImageView.tintColor = UIColor(hex: "FA735B")

                
            }
        } else {
            let menuTitle = myPageNoticeSecondMenu[indexPath.row]
            cell.menuLabel.text = menuTitle
            if menuTitle == "모두보기" {
                cell.backgroundColor = .white
                cell.menuLabel.textColor = UIColor(hex: "FA735B")
                cell.iconImageView.image = UIImage(systemName: "arrowtriangle.down.fill")?.withRenderingMode(.alwaysTemplate)
                cell.iconImageView.tintColor = UIColor(hex: "FA735B")
            }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return FirstNoticeSectionHeader()
        } else {
            return SecondNoticeSectionHeader()
        }
    }
}

extension MyPageNoticeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

class FirstNoticeSectionHeader: UIView {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "일반공지"
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1.0

        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SecondNoticeSectionHeader: UIView {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "이벤트 안내"
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1.0

        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



class MyPageNoticeCell: UITableViewCell {


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

        
        
        menuLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.equalTo(contentView.snp.leading).offset(20)
        }
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.equalTo(menuLabel.snp.trailing).offset(10)
            make.width.height.equalTo(17) 
        }
    }
}
