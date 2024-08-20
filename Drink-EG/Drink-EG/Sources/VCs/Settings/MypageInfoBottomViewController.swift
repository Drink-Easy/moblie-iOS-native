//
//  MypageInfoBottomViewController.swift
//  Drink-EG
//
//  Created by 이호연 on 8/16/24.
//

import UIKit

class MyPageBottomSheetViewController: UIViewController {
    
    private let contentViewController: UIViewController
    init(contentViewController: MypageInfoViewController) {
        self.contentViewController = contentViewController
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.7)
        return view
    }()
    // 1
    var defaultHeight: CGFloat = 661

    private let bottomSheetView: UIView = {
            let view = UIView()
            view.backgroundColor = .white

            view.layer.cornerRadius = 10
            view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            view.clipsToBounds = true
            return view
        }()
    
    // 2
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showBottomSheet()
    }

    private var bottomSheetViewTopConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        let dimmedTap = UITapGestureRecognizer(target: self, action: #selector(dimmedViewTapped(_:)))
            dimmedView.addGestureRecognizer(dimmedTap)
            dimmedView.isUserInteractionEnabled = true
    }
    @objc private func dimmedViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
        hideBottomSheetAndGoBack()
    }
    // 3
    private func setupUI() {
        view.addSubview(dimmedView)
        view.addSubview(bottomSheetView)
        dimmedView.alpha = 0.0
        addChild(contentViewController)
            bottomSheetView.addSubview(contentViewController.view)
            contentViewController.didMove(toParent: self)
            bottomSheetView.clipsToBounds = true
            dimmedView.alpha = 0.0
            
 
        setupLayout()
    }
    
    // 4
    private func showBottomSheet() {
        let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding: CGFloat = view.safeAreaInsets.bottom
        
        bottomSheetViewTopConstraint.constant = (safeAreaHeight + bottomPadding) - defaultHeight
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.dimmedView.alpha = 0.7
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    private func hideBottomSheetAndGoBack() {
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding = view.safeAreaInsets.bottom
        bottomSheetViewTopConstraint.constant = safeAreaHeight + bottomPadding
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.dimmedView.alpha = 0.0
            self.view.layoutIfNeeded()
        }) { _ in
            if self.presentingViewController != nil {
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    private func setupLayout() {
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
            bottomSheetView.translatesAutoresizingMaskIntoConstraints = false
        let topConstant = view.safeAreaInsets.bottom + view.safeAreaLayoutGuide.layoutFrame.height

            bottomSheetViewTopConstraint = bottomSheetView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstant)
            NSLayoutConstraint.activate([
                bottomSheetView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                bottomSheetView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                bottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                bottomSheetViewTopConstraint,
        ])
        contentViewController.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                contentViewController.view.topAnchor.constraint(equalTo: bottomSheetView.topAnchor),
                contentViewController.view.leadingAnchor.constraint(equalTo: bottomSheetView.leadingAnchor),
                contentViewController.view.trailingAnchor.constraint(equalTo: bottomSheetView.trailingAnchor),
                contentViewController.view.bottomAnchor.constraint(equalTo: bottomSheetView.bottomAnchor)
            ])
    }
    
    
}


class MypageInfoViewController: UIViewController {

    let mypageLabel = UILabel()
    let myinfoLabel = UILabel()
    let mynameLabel = UILabel()
    let myinfobutton = UIButton(type: .system)
    
    
    let imageView = UIImageView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        setupNavigationBarButton()
        setupMyImageView()
        setupMyImageViewConstraints()
        setupMyinfoLabel()
        setupMyinfoLabelConstraints()
        setupMynameLabel()
        setupMynameLabelConstraints()
        setupMyinfoButton()
        
    }
    
    func setupView() {
        view.addSubview(mypageLabel)
        view.addSubview(myinfoLabel)
        view.addSubview(imageView)
        view.addSubview(mynameLabel)
        view.addSubview(myinfobutton)

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
    
    
    func setupMyinfoLabel() {
        myinfoLabel.text = "내 정보"
        myinfoLabel.font = .boldSystemFont(ofSize: 24)
        myinfoLabel.textAlignment = .center
        myinfoLabel.textColor = .black
    }
    
    func setupMyinfoLabelConstraints() {
        myinfoLabel.snp.makeConstraints{ make in
            make.top.equalTo(mypageLabel.snp.top).offset(30)
            make.leading.equalTo(mypageLabel.snp.leading).offset(16)
        }
    }
    
    
    
    
    func setupMyImageView() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 40
        imageView.image = UIImage(named: "SampleImage") 
    }

    func setupMyImageViewConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(myinfoLabel.snp.bottom).offset(60)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(134)
        }
    }

    
    func setupMynameLabel() {
        let selectedManager = SelectionManager.shared
        mynameLabel.text = "안녕하세요, \(selectedManager.userName) 님!"
        mynameLabel.font = .boldSystemFont(ofSize: 24)
        mynameLabel.textAlignment = .center
        mynameLabel.textColor = .black
    }
    
    func setupMynameLabelConstraints() {
        mynameLabel.snp.makeConstraints{ make in
            make.top.equalTo(imageView.snp.bottom).offset(18)
            make.centerX.equalToSuperview()
            
        }
    }
    
    
    func setupMyinfoButton() {
        myinfobutton.setTitle("내 정보 수정", for: .normal)
        myinfobutton.setTitleColor(.black, for: .normal)
        myinfobutton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        myinfobutton.backgroundColor = UIColor(hex: "FA735B")
        myinfobutton.layer.cornerRadius = 20
        myinfobutton.addTarget(self, action: #selector(myinfoButtonTapped), for: .touchUpInside)
        myinfobutton.snp.makeConstraints { make in
            make.top.equalTo(mynameLabel.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(101)

        }
    }
        
        @objc func myinfoButtonTapped() {
            navigationController?.popViewController(animated: true)
        }
        
    }
    

     
    
    
    
    
    
