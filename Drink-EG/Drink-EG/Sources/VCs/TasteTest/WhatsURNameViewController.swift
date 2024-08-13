//
//  WhatsURNameViewController.swift
//  Drink-EG
//
//  Created by 이현주 on 8/13/24.
//

import UIKit
import Moya
import CoreLocation

class WhatsURNameViewController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate {
    let nextButton = UIButton(type: .system)
    var locationManager = CLLocationManager()
    var memberInfoDTO : MemberInfoRequest?
    
    
    private let titleLabel: UILabel = {
        let l = UILabel()
        l.text = "제 이름은..."
        l.textColor = .black
        l.textAlignment = .left
        l.font = UIFont.systemFont(ofSize: 32, weight: UIFont.Weight(rawValue: 700))
        
        return l
    }()
    
    private let nameTextField: UITextField = {
        let t = UITextField()
        t.layer.cornerRadius = 16
        t.layer.masksToBounds = true
        t.backgroundColor = UIColor(hex: "E2E2E2")
        t.placeholder = "입력..."
        t.returnKeyType = .done
        t.clearButtonMode = .always
        t.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        t.leftViewMode = .always
        return t
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named:"icon_back")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named:"icon_back")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor = .black
        
        nameTextField.delegate = self
        
        // nameTextField의 값이 변경될 때 updateNextButtonState를 호출하도록 설정
        nameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            
        // 초기 상태 업데이트
        updateNextButtonState()
        
        // Location
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        view.backgroundColor = .white
        setupUI()
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        updateNextButtonState()
    }
    
    private func setupUI() {
        configureNextButton()
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(view).offset(727)
            make.centerX.equalToSuperview()
            make.leading.equalTo(view).offset(33)
            make.height.equalTo(60)
            make.width.equalTo(327)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view).offset(125)
            make.leading.equalToSuperview().offset(18)
            make.width.equalTo(338)
            make.height.equalTo(44)
        }
        
        view.addSubview(nameTextField)
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(46)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(17)
            make.height.greaterThanOrEqualTo(60)
        }
    }
    
    private func configureNextButton() {
        nextButton.setTitle("다음", for: .normal)
        nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.contentHorizontalAlignment = .center
        
        nextButton.setImage(UIImage(named: "icon_next"), for: .normal)
        nextButton.imageView?.contentMode = .center
        nextButton.tintColor = .white
        nextButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 105, bottom: 0, right: 0)
        
        nextButton.backgroundColor = UIColor(hex: "#E2E2E2")
        nextButton.layer.cornerRadius = 16
        nextButton.layer.borderWidth = 0
    }
    
    private func updateNextButtonState() {
        if let name = nameTextField.text {
            if name.isEmpty { // 이름 입력 안된 경우
                nextButton.isEnabled = false
                nextButton.backgroundColor = UIColor(hex: "#E2E2E2")
                nextButton.removeTarget(nil, action: nil, for: .allEvents)
            } else {
                nextButton.setTitleColor(.white, for: .normal)
                nextButton.tintColor = .white
                nextButton.isEnabled = true
                nextButton.backgroundColor = UIColor(hex: "FA735B")
                nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
                
                // 이름 정보 전달
                SelectionManager.shared.setName(answer: name)
            }
        }
    }
    
    @objc private func nextButtonTapped() {
        let firstTasteTestViewController = FirstTasteTestViewController()
        navigationController?.pushViewController(firstTasteTestViewController, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.nameTextField {
            self.nameTextField.resignFirstResponder()
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)  //firstresponder가 전부 사라짐
    }
    
    //MARK: - Location parts
    func checkAuthorizationStatus() {
        if #available(iOS 14.0, *) {
            
            if locationManager.authorizationStatus == .authorizedAlways
                || locationManager.authorizationStatus == .authorizedWhenInUse {
                print("==> 위치 서비스 On 상태")
                locationManager.startUpdatingLocation() //위치 정보 받아오기 시작 - 사용자의 현재 위치를 보고하는 업데이트 생성을 시작
            } else if locationManager.authorizationStatus == .notDetermined {
                print("==> 위치 서비스 Off 상태")
                locationManager.requestWhenInUseAuthorization()
            } else if locationManager.authorizationStatus == .denied {
                print("==> 위치 서비스 Deny 상태")
            }
            
        } else {
            
            // Fallback on earlier versions
            if CLLocationManager.locationServicesEnabled() {
                print("위치 서비스 On 상태")
                locationManager.startUpdatingLocation() //위치 정보 받아오기 시작 - 사용자의 현재 위치를 보고하는 업데이트 생성을 시작
                print("LocationViewController >> checkPermission() - \(locationManager.location?.coordinate)")
            } else {
                print("위치 서비스 Off 상태")
                locationManager.requestWhenInUseAuthorization()
            }
        }
    }
    
    func getAddress() {
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let geocoder = CLGeocoder.init()
        let location = self.locationManager.location
        
        if location != nil {
            geocoder.reverseGeocodeLocation(location!) { (placemarks, error) in
                if error != nil {
                    return
                }
                if let placemark = placemarks?.first {
                    var address = ""
                    if let administrativeArea = placemark.administrativeArea {
                        address += administrativeArea
                    }
                    
                    if let locality = placemark.locality {
                        
                    }
                }
            }
        }
        
    }
    
    //MARK: - API parts
    
    func assignRequestDTO() {
        let selectionMng = SelectionManager.shared
        self.memberInfoDTO = MemberInfoRequest(isNewbie: selectionMng.isNewbie, monthPrice: selectionMng.monthPrice, wineSort: selectionMng.wineSort, wineNation: selectionMng.wineNation, wineVariety: selectionMng.wineVariety, region: , userName: selectionMng.userName)
        
    }
}

