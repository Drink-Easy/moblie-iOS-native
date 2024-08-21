//
//  WishListViewController.swift
//  Drink-EG
//
//  Created by 이호연 on 8/16/24.
//

import UIKit
import SnapKit
import Moya
import SwiftyToaster

class MyPageWishListViewController: UIViewController, WishListCollectionViewCellDelegate {
    
    let provider = MoyaProvider<WishListAPI>(plugins: [CookiePlugin()])
    
    var wishListResults: [WineList] = []
    
    private let label: UILabel = {
        let l = UILabel()
        l.text = "술킷 리스트"
        l.font = .systemFont(ofSize: 28, weight: UIFont.Weight(700))
        l.textColor = .black
        l.numberOfLines = 0
        return l
    }()
    
    lazy var WineListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(WishListCollectionViewCell.self, forCellWithReuseIdentifier: "WishListCollectionViewCell")
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        
        cv.decelerationRate = .fast
        cv.backgroundColor = .clear
        cv.layer.cornerRadius = 10
        
        return cv
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavigationBarButton()
 
        getWineList() { isSuccess in
            if isSuccess {
                self.WineListCollectionView.reloadData()
                self.setupUI()
            } else {
                print("GET 호출 실패")
                Toaster.shared.makeToast("400 Bad Request", .short)
            }
        }
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
    
    private func setupUI() {
        
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(27)
        }
        
        view.addSubview(WineListCollectionView)
        WineListCollectionView.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func wishDeleteButtonTapped(on cell: WishListCollectionViewCell) {
        // 1. collectionView에서 indexPath를 찾습니다.
        guard let indexPath = WineListCollectionView.indexPath(for: cell) else {
            print("IndexPath not found for the given cell.")
            return
        }
        
        // 2. 선택된 와인을 가져옵니다.
        let selectedWine = wishListResults[indexPath.row]
        
        // 3. 와인 ID를 사용하여 deleteWishWine 함수를 호출합니다.
        deleteWishWine(wineId: selectedWine.id) { success in
            if success {
                print("Successfully deleted wine \(selectedWine.id) from wishlist.")
                
                // 4. 성공 시, 위시리스트에서 해당 와인을 제거합니다.
                self.wishListResults.remove(at: indexPath.row)
                
                // 5. collectionView에서 해당 셀을 삭제합니다.
                self.WineListCollectionView.deleteItems(at: [indexPath])
                
                self.WineListCollectionView.reloadData()
            } else {
                print("Failed to delete wine \(selectedWine.id) from wishlist.")
                Toaster.shared.makeToast("와인 삭제에 실패했습니다.", .short)
            }
        }
    }
}

extension MyPageWishListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wishListResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WishListCollectionViewCell", for: indexPath) as! WishListCollectionViewCell
        
        cell.delegate = self // 델리게이트 설정
        
        let wine = wishListResults[indexPath.row]
        cell.configure(wine: wine.wine)
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, trailingSwipeActionsConfigurationForItemAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { (action, view, completionHandler) in
//            
//            self.wishListResults.remove(at: indexPath.row)
//            self.WineListCollectionView.deleteItems(at: [indexPath])
//            
//            completionHandler(true)
//        }
//        
//        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
//        configuration.performsFirstActionWithFullSwipe = true
//        return configuration
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 94)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedWine = wishListResults[indexPath.row]
        WineListCollectionView.reloadData()

        let wineInfoViewController = WineInfoViewController()
        wineInfoViewController.name.text = selectedWine.wine.name
        wineInfoViewController.wineImageURL = selectedWine.wine.imageUrl
        wineInfoViewController.wineId = selectedWine.wine.wineId
        navigationController?.pushViewController(wineInfoViewController, animated: true)
    }
    
    func getWineList(completion: @escaping (Bool) -> Void) {
        provider.request(.getWineList) { result in
            switch result {
            case .success(let response):
                do {
                    
                    if let jsonString = String(data: response.data, encoding: .utf8) {
                        print("Received JSON: \(jsonString)")
                    }
                    
                    let responseData = try JSONDecoder().decode(APIResponseWishListResponse.self, from: response.data)
                    self.wishListResults = responseData.result
                    self.WineListCollectionView.reloadData()
                    completion(true)
                } catch {
                    print("Failed to decode response: \(error)")
                    completion(false)
                }
            case.failure(let error):
                print("Error: \(error.localizedDescription)")
                if let response = error.response {
                    print("Response Body: \(String(data: response.data, encoding: .utf8) ?? "")")
                }
                completion(false)
            }
        }
    }
    
    func deleteWishWine(wineId: Int, completion: @escaping (Bool) -> Void) {
        provider.request(.deleteWineLike(wineId: wineId)) { result in
            switch result {
            case .success(let response):
                if let jsonString = String(data: response.data, encoding: .utf8) {
                    print("Received JSON: \(jsonString)")
                }
                if response.statusCode == 200 {
                    print("Wine Deleted")
                    completion(true)
                } else {
                    print("Failed to delete wine with status code: \(response.statusCode)")
                    completion(false)
                }
            case .failure(let error):
                print("Request failed: \(error)")
                completion(false)
            }
        }
    }
}
            
