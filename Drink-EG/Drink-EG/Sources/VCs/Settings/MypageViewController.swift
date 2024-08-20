//
//  MypageViewController.swift
//  Drink-EG
//
//  Created by 이호연 on 8/16/24.
//

import Foundation
import UIKit
import SnapKit


private let cellID = "Cell"
class MypageViewController: UIViewController {
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    
    let myPagefirstMenu = ["내 정보", "와인 주문 내역", "위시리스트"]
    let myPageSecondMenu = ["1:1 문의하기", "제휴 입점 문의하기", "개선 제안하기"]
    let myPageThirdMenu = ["서비스 이용약관", "위치정보 이용약관", "개인정보 처리방침"]
    
    let topHeader = TopHeader()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureUI()
    }
    
    func configureUI() {
        
        // TopHeader를 먼저 추가
        view.addSubview(topHeader)
        topHeader.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(100) // TopHeader의 높이를 설정합니다.
        }
        
        // TableView를 추가하고 TopHeader 아래에 배치
        view.addSubview(tableView)
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyPageCell.self, forCellReuseIdentifier: cellID)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(topHeader.snp.bottom) // TopHeader 아래에 배치
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension MypageViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return myPagefirstMenu.count
        } else if section == 1 {
            return myPageSecondMenu.count
        } else {
            return myPageThirdMenu.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! MyPageCell
        cell.backgroundColor = UIColor(hex: "D9D9D9")
        
        if indexPath.section == 0 {
            cell.textLabel?.text = myPagefirstMenu[indexPath.row]
        } else if indexPath.section == 1 {
            cell.textLabel?.text = myPageSecondMenu[indexPath.row]
        } else if indexPath.section == 2 {
            cell.textLabel?.text = myPageThirdMenu[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let header = FirstSectionHeader()
            return header
        } else if section == 1 {
            let header = SecondSectionHeader()
            return header
        } else {
            let header = ThirdSectionHeader()
            return header
        }
    }
}

extension MypageViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.contentView.backgroundColor = UIColor(hex: "#FF9F8E")
        }
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let bottomSheetContent = MypageInfoViewController()
                let bottomSheetVC = MyPageBottomSheetViewController(contentViewController: bottomSheetContent)
                bottomSheetVC.modalPresentationStyle = .overFullScreen
                bottomSheetVC.modalTransitionStyle = .crossDissolve
                present(bottomSheetVC, animated: true, completion: nil)
            case 1:
                let controller = MyPageSettingsViewController()
                navigationController?.pushViewController(controller, animated: true)
            default:
                print("\(myPagefirstMenu[indexPath.row])")
            }
        case 1:
            switch indexPath.row {
            case 0:
                let controller = MyPageSettingsViewController()
                navigationController?.pushViewController(controller, animated: true)
            default:
                print("\(myPageSecondMenu[indexPath.row])")
            }
        case 2:
            switch indexPath.row {
            case 0:
                let controller = MypageViewController()
                navigationController?.pushViewController(controller, animated: true)
            default:
                print("\(myPageThirdMenu[indexPath.row])")
            }
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.contentView.backgroundColor = UIColor(hex: "D9D9D9")
        }
    }
}




class FirstSectionHeader: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "기본 정보"
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    override init (frame: CGRect) {
        super.init (frame: frame)
        backgroundColor = .white
        
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented" )
    }
    
}

class SecondSectionHeader: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "고객센터"
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    override init (frame: CGRect) {
        super.init (frame: frame)
        
        backgroundColor = .white
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented" )
    }
    
}

class ThirdSectionHeader: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "이용약관"
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    override init (frame: CGRect) {
        super.init (frame: frame)
        backgroundColor = .white
        
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented" )
    }
    
}

class TopHeader: UIView {
    
    // UI 요소들
    let topView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("", for: .normal)
        let searchImage = UIImage(systemName: "magnifyingglass")
        button.setImage(searchImage, for: .normal)
        button.tintColor = UIColor(hue: 0, saturation: 0, brightness: 0.4, alpha: 1.0)
        return button
    }()
    
    let cartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("", for: .normal)
        let cartImage = UIImage(systemName: "cart")
        button.setImage(cartImage, for: .normal)
        button.tintColor = UIColor(hue: 0, saturation: 0, brightness: 0.4, alpha: 1.0)
        return button
    }()
    
    let mypageLabel: UILabel = {
        let label = UILabel()
        label.text = "마이페이지"
        label.font = .boldSystemFont(ofSize: 28)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    let stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(topView)
        addSubview(stackView)
        
        setupStackView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupStackView() {
        let leftStackView = UIStackView(arrangedSubviews: [mypageLabel])
        leftStackView.axis = .horizontal
        leftStackView.alignment = .leading
        
        let rightStackView = UIStackView(arrangedSubviews: [searchButton, cartButton])
        rightStackView.axis = .horizontal
        rightStackView.alignment = .trailing
        rightStackView.spacing = 20
        
        stackView.addArrangedSubview(leftStackView)
        stackView.addArrangedSubview(UIView())
        stackView.addArrangedSubview(rightStackView)
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 5
    }
    
    func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(34)
        }
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        
        topView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        topView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        topView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
}

class MyPageCell: UITableViewCell {
    
    let menuLable = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier reuseIdenfitifer: String?) {
        super.init(style: style, reuseIdentifier: reuseIdenfitifer)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configureUI() {
        addSubview(menuLable)
        menuLable.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            menuLable.centerYAnchor.constraint(equalTo: centerYAnchor),
            menuLable.leftAnchor.constraint(equalTo: leftAnchor, constant: 12)
        ])
    }
    
}
