//
//  ContentViewController.swift
//  Drink-EG
//
//  Created by 김도연 on 10/7/24.
//

import UIKit
import SnapKit
import Then

class ContentViewController: UIViewController {
    
    var filterType : String?
    
    // 테이블 뷰 생성
    let tableView = UITableView().then {
        $0.backgroundColor = .white
        $0.separatorStyle = .singleLine // 구분선 스타일
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "cell") // 셀 등록
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 뷰 설정
        setupView()
    }
    
    // 뷰 설정 및 레이아웃 정의
    private func setupView() {
        view.backgroundColor = .white
        
        // 테이블 뷰 추가
        view.addSubview(tableView)
        
        // SnapKit을 사용한 오토레이아웃 설정
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview() // 부모 뷰 전체에 맞춤
        }
        
        // Delegate와 DataSource 설정
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension ContentViewController: UITableViewDataSource, UITableViewDelegate {
    
    // 섹션 내 셀의 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20 // 예시로 20개의 셀
    }
    
    // 각 셀에 표시할 내용 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(filterType ?? "non")Row \(indexPath.row + 1) " // 셀에 텍스트 설정
        return cell
    }
    
    // 셀이 선택되었을 때 동작
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Row \(indexPath.row + 1) selected")
        tableView.deselectRow(at: indexPath, animated: true) // 선택 해제
    }
}

