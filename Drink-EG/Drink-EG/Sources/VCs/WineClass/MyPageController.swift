//
//  MyPageController.swift
//  Drink-EG
//
//  Created by 이호연 on 8/12/24.
//

import Foundation
import UIKit
import SnapKit

class MyPageController : UIViewController {
    
    
    
    let searchButton = UIButton(type: .system)
    let cartButton = UIButton(type: .system)
    
    let stackView = UIStackView()
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let mypageLabel = UILabel()
    let suggestionTableView = UITableView()
    
    let informationLabel = UILabel()
    let myinfoButton = UIButton()
    let myorderlistButton = UIButton()
    let mywishlistButton = UIButton()
    let noticeButton = UIButton()
    
    let custumerServiceLabel = UILabel()
    let qnaButton = UIButton()
    let comeonButton = UIButton()
    let suggestButton = UIButton()
    
    let termServiceLabel = UILabel()
    let serviceButton = UIButton()
    let locationButton = UIButton()
    let personalinfoButton = UIButton()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // ScrollView 추가
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            scrollView.contentInset = .zero

            make.edges.equalToSuperview()
            
        }
        
        
        
        // ContentView 추가
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
            
        }
        
        view.addSubview(stackView)
            setupStackView()  // 호출 추가
            stackView.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                make.leading.trailing.equalToSuperview().inset(20)
                make.height.equalTo(34)
            }
        
        

        
        setupView()
        setupLabel()
        setupMypageLabelConstraints()
        setupInformationLabel()
        setupInformationLabelConstraints()
        setupMyinfoButton()
        setupMyinfoButtonConstraints()
        setupMyorderlistButton()
        setupMyorderlistButtonConstraints()
        setupMywishlistButton()
        setupMywishlistButtonConstraints()
        setupNoticeButton()
        setupNoticeButtonConstraints()
        setupCustumerServiceLabel()
        setupCustumerServiceLabelConstraints()
        setupQnaButton()
        setupQnaButtonConstraints()
        setupComeonButton()
        setupComeonButtonConstraints()
        setupSuggestButton()
        setupSuggestButtonConstraints()
        setupTermServiceLabel()
        setupTermServiceLabelConstraints()
        setupServiceButton()
        setupServiceConstraints()
        setupLocationButton()
        setupLocationButtonConstraints()
        setupPersonalinfoButton()
        setupPersonalinfotButtonConstraints()
        
        configureSearchButton()
        configureCartButton()
    }
    
    

    

    //StackView 설정
    func setupStackView() {
        // 왼쪽 스택뷰: mypageLabel만 포함
        let leftStackView = UIStackView(arrangedSubviews: [mypageLabel])
        leftStackView.axis = .horizontal
        leftStackView.alignment = .leading
        

        // 오른쪽 스택뷰: searchButton과 cartButton을 포함
        let rightStackView = UIStackView(arrangedSubviews: [searchButton, cartButton])
        rightStackView.axis = .horizontal
        rightStackView.alignment = .trailing
        rightStackView.spacing = 20

        // 메인 스택뷰: leftStackView와 rightStackView를 포함
        stackView.addArrangedSubview(leftStackView)
        stackView.addArrangedSubview(UIView()) // 중간의 flexible space를 위해 빈 뷰 추가
        stackView.addArrangedSubview(rightStackView)
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 5
    }
    
    func stackViewConstraints() {
        stackView.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(34)
            
        }
    }
    

        func setupLabel() {
            mypageLabel.text = "마이페이지"
            mypageLabel.font = .boldSystemFont(ofSize: 28)
            mypageLabel.textAlignment = .center
            mypageLabel.textColor = .black
        }
        
        func setupMypageLabelConstraints() {
            mypageLabel.snp.makeConstraints{ make in
                make.width.equalToSuperview().multipliedBy(0.50)
                make.leading.equalToSuperview().offset(-10)
                //make.top.equalTo(contentView.snp.top).offset(46)
                //make.leading.equalTo(stackView.snp.leading).offset(16)
            }
        }

    func searchButtonConstraints() {
        searchButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.12)
        }
    }

    func cartButtonConstraints() {
        cartButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.12)
        }
    }
    
    private func configureSearchButton() {
        searchButton.setTitle("", for: .normal)
            
        // 장바구니 이미지 설정
        let searchImage = UIImage(systemName: "magnifyingglass")
        searchButton.setImage(searchImage, for: .normal)
        searchButton.tintColor = UIColor(hue: 0, saturation: 0, brightness: 0.4, alpha: 1.0)
            
        
        
        // 버튼 액션 추가
        //searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    private func configureCartButton() {
        cartButton.setTitle("", for: .normal)
            
        // 장바구니 이미지 설정
        let cartImage = UIImage(systemName: "cart")
        cartButton.setImage(cartImage, for: .normal)
        cartButton.tintColor = UIColor(hue: 0, saturation: 0, brightness: 0.4, alpha: 1.0)
            
        
            
        // 버튼 액션 추가
        //cartButton.addTarget(self, action: #selector(cartButtonTapped), for: .touchUpInside)
    }
   /*
    @objc private func searchButtonTapped() {
        let searchHomeViewController = SearchHomeViewController()
        navigationController?.pushViewController(searchHomeViewController, animated: true)
    }
    
    @objc private func cartButtonTapped() {
        let shoppingCartListViewController = ShoppingCartListViewController()
        navigationController?.pushViewController(shoppingCartListViewController, animated: true)
    }
    */
    
    
    
    func setupView() {
        contentView.addSubview(mypageLabel)
        contentView.addSubview(suggestionTableView)
        contentView.addSubview(informationLabel)
        contentView.addSubview(myinfoButton)
        contentView.addSubview(myorderlistButton)
        contentView.addSubview(mywishlistButton)
        contentView.addSubview(noticeButton)

        contentView.addSubview(custumerServiceLabel)
        contentView.addSubview(qnaButton)
        contentView.addSubview(comeonButton)
        contentView.addSubview(suggestButton)
        contentView.addSubview(termServiceLabel)
        contentView.addSubview(serviceButton)
        contentView.addSubview(locationButton)
        contentView.addSubview(personalinfoButton)
    }

/*
    func setupLabel() {
        mypageLabel.text = "마이페이지"
        mypageLabel.font = .boldSystemFont(ofSize: 30)
        mypageLabel.textAlignment = .center
        mypageLabel.textColor = .black
    }
    
    func setupMypageLabelConstraints() {
        mypageLabel.snp.makeConstraints{ make in
            make.top.equalTo(contentView.snp.top).offset(46)
            make.leading.equalTo(contentView.snp.leading).offset(16)
        }
    }
*/
    func setupInformationLabel() {
        informationLabel.text = "기본정보"
        informationLabel.font = .boldSystemFont(ofSize: 14)
        informationLabel.textAlignment = .center
        informationLabel.textColor = .black
    }
    
    func setupInformationLabelConstraints() {
        informationLabel.snp.makeConstraints{ make in
            make.top.equalTo(stackView.snp.bottom).offset(42)
            make.leading.equalTo(stackView.snp.leading)
        }
    }
    
    func setupMyinfoButton() {
        myinfoButton.setTitle("내 정보", for: .normal)
        myinfoButton.backgroundColor = UIColor(hex: "D9D9D9")
        //myinfoButton.layer.cornerRadius = 16
        myinfoButton.setTitleColor(.black, for: .normal)
        
        myinfoButton.contentHorizontalAlignment = .left
        myinfoButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 0)
        
        myinfoButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        myinfoButton.layer.borderWidth = 2.0 // 테두리 두께
        myinfoButton.layer.borderColor = UIColor(hex: "CECECE")?.cgColor // 테두리 색상
        
        
    }
    
    func setupMyinfoButtonConstraints() {
        myinfoButton.snp.makeConstraints{ make in
            make.top.equalTo(informationLabel.snp.bottom).offset(14)
            make.leading.equalTo(contentView.snp.leading) // 좌측 여백 설정
            //make.trailing.equalTo(contentView.snp.trailing).offset(-16) // 우측 여백 설정
            make.width.equalTo(contentView.snp.width)
            make.height.greaterThanOrEqualTo(50)
        }
    }
    
    func setupMyorderlistButton() {
        myorderlistButton.setTitle("와인 주문 내역", for: .normal)
        myorderlistButton.backgroundColor = UIColor(hex: "D9D9D9")
        //myorderlistButton.layer.cornerRadius = 16
        
        myorderlistButton.contentHorizontalAlignment = .left
        myorderlistButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 0)
        
        myorderlistButton.setTitleColor(.black, for: .normal)
        myorderlistButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        myorderlistButton.layer.borderWidth = 2.0 // 테두리 두께
        myorderlistButton.layer.borderColor = UIColor(hex: "CECECE")?.cgColor // 테두리 색상
    }
    
    func setupMyorderlistButtonConstraints() {
        myorderlistButton.snp.makeConstraints{ make in
            make.top.equalTo(myinfoButton.snp.bottom)
            make.leading.equalTo(contentView.snp.leading)
           

            make.width.equalTo(myinfoButton.snp.width)
            make.height.greaterThanOrEqualTo(50)
            
        }
    }
    
    func setupMywishlistButton() {
        mywishlistButton.setTitle("위시리스트", for: .normal)
        mywishlistButton.backgroundColor = UIColor(hex: "D9D9D9")
        //mywishlistButton.layer.cornerRadius = 16
        
        mywishlistButton.contentHorizontalAlignment = .left
        mywishlistButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 0)
        
        mywishlistButton.setTitleColor(.black, for: .normal)
        mywishlistButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        mywishlistButton.layer.borderWidth = 2.0 // 테두리 두께
        mywishlistButton.layer.borderColor = UIColor(hex: "CECECE")?.cgColor // 테두리 색상

    }
    
    func setupMywishlistButtonConstraints() {
        mywishlistButton.snp.makeConstraints{ make in
            make.top.equalTo(myorderlistButton.snp.bottom)
            make.leading.equalTo(myorderlistButton.snp.leading)
            make.width.equalTo(myorderlistButton.snp.width)
            make.height.greaterThanOrEqualTo(50)
        }
    }
    
    func setupNoticeButton() {
        noticeButton.setTitle("공지사항", for: .normal)
        noticeButton.backgroundColor = UIColor(hex: "D9D9D9")
        //mywishlistButton.layer.cornerRadius = 16
        
        noticeButton.contentHorizontalAlignment = .left
        noticeButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 0)
        
        noticeButton.setTitleColor(.black, for: .normal)
        noticeButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        noticeButton.layer.borderWidth = 2.0 // 테두리 두께
        noticeButton.layer.borderColor = UIColor(hex: "CECECE")?.cgColor // 테두리 색상

    }
    
    func setupNoticeButtonConstraints() {
        noticeButton.snp.makeConstraints{ make in
            make.top.equalTo(mywishlistButton.snp.bottom)
            make.leading.equalTo(mywishlistButton.snp.leading)
            make.width.equalTo(mywishlistButton.snp.width)
            make.height.greaterThanOrEqualTo(50)
        }
    }
    

    
    

    
    func setupCustumerServiceLabel() {
        custumerServiceLabel.text = "고객센터"
        custumerServiceLabel.font = .boldSystemFont(ofSize: 14)
        custumerServiceLabel.textAlignment = .center
        custumerServiceLabel.textColor = .black
    }
    
    func setupCustumerServiceLabelConstraints() {
        custumerServiceLabel.snp.makeConstraints { make in
            make.top.equalTo(noticeButton.snp.bottom).offset(25)
            make.leading.equalTo(stackView.snp.leading)
        }
    }
    
    func setupQnaButton() {
        qnaButton.setTitle("1:1 문의하기", for: .normal)
        qnaButton.backgroundColor = UIColor(hex: "D9D9D9")
        //qnaButton.layer.cornerRadius = 16
        
        qnaButton.contentHorizontalAlignment = .left
        qnaButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 0)
        
        qnaButton.setTitleColor(.black, for: .normal)
        qnaButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        qnaButton.layer.borderWidth = 2.0
        qnaButton.layer.borderColor = UIColor(hex: "CECECE")?.cgColor
    }
    
    func setupQnaButtonConstraints() {
        qnaButton.snp.makeConstraints{ make in
            make.top.equalTo(custumerServiceLabel.snp.bottom).offset(14)
            make.leading.equalTo(contentView.snp.leading)
            make.width.equalTo(contentView.snp.width)
            make.height.greaterThanOrEqualTo(50)
        }
    }
    
    func setupComeonButton() {
        comeonButton.setTitle("제휴, 입점 문의하기", for: .normal)
        comeonButton.backgroundColor = UIColor(hex: "D9D9D9")
        //comeonButton.layer.cornerRadius = 16
        comeonButton.contentHorizontalAlignment = .left
        comeonButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 0)
        
        comeonButton.setTitleColor(.black, for: .normal)
        comeonButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        comeonButton.layer.borderWidth = 2.0
        comeonButton.layer.borderColor = UIColor(hex: "CECECE")?.cgColor
    }
    
    func setupComeonButtonConstraints() {
        comeonButton.snp.makeConstraints{ make in
            make.top.equalTo(qnaButton.snp.bottom)
            make.leading.equalTo(qnaButton.snp.leading)
            make.width.equalTo(qnaButton.snp.width)
            make.height.greaterThanOrEqualTo(50)
        }
    }
    
    func setupSuggestButton() {
        suggestButton.setTitle("개선 제안하기", for: .normal)
        suggestButton.backgroundColor = UIColor(hex: "D9D9D9")
        //suggestButton.layer.cornerRadius = 16
        suggestButton.contentHorizontalAlignment = .left
        suggestButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 0)
        
        suggestButton.setTitleColor(.black, for: .normal)
        suggestButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        suggestButton.layer.borderWidth = 2.0
        suggestButton.layer.borderColor = UIColor(hex: "CECECE")?.cgColor

    }
    
    func setupSuggestButtonConstraints() {
        suggestButton.snp.makeConstraints{ make in
            make.top.equalTo(comeonButton.snp.bottom)
            make.leading.equalTo(comeonButton.snp.leading)
            make.width.equalTo(comeonButton.snp.width)
            make.height.greaterThanOrEqualTo(50)
        }
    }
    

    
    
    
    func setupTermServiceLabel() {
        termServiceLabel.text = "이용약관"
        termServiceLabel.font = .boldSystemFont(ofSize: 14)
        termServiceLabel.textAlignment = .center
        termServiceLabel.textColor = .black
    }
    
    func setupTermServiceLabelConstraints() {
        termServiceLabel.snp.makeConstraints{ make in
            make.top.equalTo(suggestButton.snp.bottom).offset(25)
            make.leading.equalTo(stackView.snp.leading)
        }
    }
    
    
    func setupServiceButton() {
        serviceButton.setTitle("서비스 이용약관", for: .normal)
        serviceButton.backgroundColor = UIColor(hex: "D9D9D9")
        //serviceButton.layer.cornerRadius = 16
        
        serviceButton.contentHorizontalAlignment = .left
        serviceButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 0)
        
        serviceButton.setTitleColor(.black, for: .normal)
        serviceButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        serviceButton.layer.borderWidth = 2.0
        serviceButton.layer.borderColor = UIColor(hex: "CECECE")?.cgColor
    }
    
    func setupServiceConstraints() {
        serviceButton.snp.makeConstraints{ make in
            make.top.equalTo(termServiceLabel.snp.bottom).offset(14)
            make.leading.equalTo(contentView.snp.leading)
            make.width.equalTo(contentView.snp.width)
            make.height.greaterThanOrEqualTo(50)
        }
    }
    
    func setupLocationButton() {
        locationButton.setTitle("위치정보 이용약관", for: .normal)
        locationButton.backgroundColor = UIColor(hex: "D9D9D9")
        //locationButton.layer.cornerRadius = 16
        
        locationButton.contentHorizontalAlignment = .left
        locationButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 0)
        
        locationButton.setTitleColor(.black, for: .normal)
        locationButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        locationButton.layer.borderWidth = 2.0
        locationButton.layer.borderColor = UIColor(hex: "CECECE")?.cgColor
    }
    
    func setupLocationButtonConstraints() {
        locationButton.snp.makeConstraints{ make in
            make.top.equalTo(serviceButton.snp.bottom)
            make.leading.equalTo(serviceButton.snp.leading)
            make.width.equalTo(serviceButton.snp.width)
            make.height.greaterThanOrEqualTo(50)
        }
    }
    
    func setupPersonalinfoButton() {
        personalinfoButton.setTitle("개인정보 처리방침", for: .normal)
        personalinfoButton.backgroundColor = UIColor(hex: "D9D9D9")
        //personalinfoButton.layer.cornerRadius = 16
        
        personalinfoButton.contentHorizontalAlignment = .left
        personalinfoButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 0)
        
        personalinfoButton.setTitleColor(.black, for: .normal)
        personalinfoButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        personalinfoButton.layer.borderWidth = 2.0
        personalinfoButton.layer.borderColor = UIColor(hex: "CECECE")?.cgColor
    }
    
    func setupPersonalinfotButtonConstraints() {
        personalinfoButton.snp.makeConstraints{ make in
            make.top.equalTo(locationButton.snp.bottom)
            make.leading.equalTo(locationButton.snp.leading)
            make.width.equalTo(locationButton.snp.width)
            make.height.greaterThanOrEqualTo(50)
            //make.bottom.equalTo(contentView.snp.bottom).offset(-20) // contentView의 bottom을 personalinfoButton의 bottom에 맞춤
        }
    }
}


extension UIColor {
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }
        
        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}
