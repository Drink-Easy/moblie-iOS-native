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
    
    let shoppingListManager = ShoppingListManager.shared
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    
    let myPagefirstMenu = ["내 정보", "와인 주문 내역", "위시리스트"]
    let myPageSecondMenu = ["1:1 문의하기", "제휴 입점 문의하기", "개선 제안하기"]
    let myPageThirdMenu = ["서비스 이용약관", "위치정보 이용약관", "개인정보 처리방침"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupNavigationBarButton()
        setupUI()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        showBadge()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // title label
    let mypageLabel: UILabel = {
        let label = UILabel()
        label.text = "마이페이지"
        label.font = .systemFont(ofSize: UIConstants.labelFontSize, weight: UIFont.Weight(rawValue: 700))
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    // cartBtn
    let cartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("", for: .normal)
        let cartImage = UIImage(named: "icon_cart")
        button.setImage(cartImage, for: .normal)
        button.tintColor = UIColor(hue: 0, saturation: 0, brightness: 0.4, alpha: 1.0)
        button.addTarget(self, action: #selector(cartButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // badgeLabel
    lazy var badgeLabel: UILabel = {
      let label = UILabel(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
      label.translatesAutoresizingMaskIntoConstraints = false
      label.layer.cornerRadius = label.bounds.size.height / 2
      label.textAlignment = .center
      label.layer.masksToBounds = true
      label.textColor = .white
      label.font = .boldSystemFont(ofSize: 10)
      label.backgroundColor = UIColor(hex: "FF7A6D")
      return label
    }()
    
    
    @objc private func cartButtonTapped() {
        let shoppingCartListViewController = ShoppingCartListViewController()
        self.navigationController?.pushViewController(shoppingCartListViewController, animated: true)
    }
    
    func showBadge() {
        badgeLabel.text = "\(shoppingListManager.myCartWines.count)"
        
        // 장바구니가 비어 있는지 확인
        if shoppingListManager.myCartWines.isEmpty {
            // 장바구니가 비어 있으면 badgeLabel을 cartButton에서 제거
            badgeLabel.removeFromSuperview()
        } else {
            // 장바구니에 아이템이 있으면 badgeLabel을 cartButton에 추가
            if badgeLabel.superview == nil {
                cartButton.addSubview(badgeLabel)
            }
            badgeLabel.snp.makeConstraints { make in
                make.centerX.equalTo(cartButton.snp.centerX).offset(10)
                make.centerY.equalTo(cartButton.snp.centerY).offset(-8)
//                make.top.equalTo(cartButton).inset(2)
                make.width.height.equalTo(16)
            }
        }
    }
    
    func setupNavigationBarButton() {
        navigationItem.hidesBackButton = true
        let backArrow = UIImage(systemName: "")
        let leftButton = UIBarButtonItem(image: backArrow, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = leftButton
        leftButton.tintColor = .black
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func setupUI() {
        view.addSubview(mypageLabel)
        mypageLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(27)
        }
        
        view.addSubview(cartButton)
        cartButton.snp.makeConstraints { make in
            make.top.equalTo(mypageLabel.snp.top)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-27)
        }
    }
    
    func configureUI() {
        // TableView를 추가하고 TopHeader 아래에 배치
        view.addSubview(tableView)
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyPageCell.self, forCellReuseIdentifier: cellID)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(mypageLabel.snp.bottom).offset(20)
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
//            case 1:
//                let controller = MyPageSettingsViewController()
//                navigationController?.pushViewController(controller, animated: true)
            default:
                print("\(myPagefirstMenu[indexPath.row])")
            }
        case 1:
            switch indexPath.row {
//            case 0:
//                let controller = MyPageSettingsViewController()
//                navigationController?.pushViewController(controller, animated: true)
            default:
                print("\(myPageSecondMenu[indexPath.row])")
            }
        case 2:
            switch indexPath.row {
//            case 0:
//                
//                let controller = MypageViewController()
//                navigationController?.pushViewController(controller, animated: true)
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
