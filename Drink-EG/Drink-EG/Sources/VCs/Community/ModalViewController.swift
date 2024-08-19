//
//  ModalViewController.swift
//  Drink-EG
//
//  Created by 이수현 on 8/9/24.
//

import UIKit
import SnapKit

struct Comment: Codable {
    var profileImageName: String  // 이미지 파일명만 저장
    var name: String
    var date: Date
    var comment: String
}

class ModalViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let dueDateLabel = UILabel()
    let descriptionTitleLabel = UILabel()
    let descriptonLabel = UILabel()
    let joinButton = UIButton()
    let vectorLine = UIView()
    
    // 댓글 목록을 표시할 테이블 뷰
    let tableView = UITableView()
    
    // 댓글 입력을 위한 텍스트 필드
    let commentTextField = UITextField()
    let sendButton = UIButton()
    
    // 댓글 데이터를 저장할 배열
    var comments: [Comment] = [] {
        didSet {
            saveCommentsToUserDefaults()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupDueDateLabel()
        setupDueDateLabelConstraints()
        setupDescriptionTitleLabel()
        setupDescriptionTitleLabelConstraints()
        setupDescriptionLabel()
        setupDescriptionLabelConstraints()
        setupJoinButton()
        setupJoinButtonConstraints()
        setupVectorLineView()
        setupVectorLineViewConstraints()
        setupTableView()
        setupCommentInputField()
        setupTableViewConstraints()

        loadCommentsFromUserDefaults()
        Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(updateTimeStamps), userInfo: nil, repeats: true)
        
        // 주석 해제 시 댓글 초기화
        // clearComments()
    }
    
    func clearComments() {
        UserDefaults.standard.removeObject(forKey: "savedComments")
        comments.removeAll()
        tableView.reloadData()
        print("댓글이 초기화되었습니다.")
    }
    
    @objc func updateTimeStamps() {
        tableView.reloadData()
    }
    
    func setupDueDateLabel() {
        view.addSubview(dueDateLabel)
        dueDateLabel.text = "마감일: 2024/08/20"
        dueDateLabel.textColor = UIColor(hex: "FF8585")
        dueDateLabel.font = .systemFont(ofSize: 12)
        dueDateLabel.textAlignment = .center
    }
    
    func setupDueDateLabelConstraints() {
        dueDateLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(43)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(24)
        }
    }
    
    func setupDescriptionTitleLabel() {
        view.addSubview(descriptionTitleLabel)
        descriptionTitleLabel.text = "모임 설명"
        descriptionTitleLabel.textColor = .black
        descriptionTitleLabel.font = .boldSystemFont(ofSize: 20)
        descriptionTitleLabel.textAlignment = .center
    }
    
    func setupDescriptionTitleLabelConstraints() {
        descriptionTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(dueDateLabel.snp.bottom).offset(20)
            make.leading.equalTo(dueDateLabel.snp.leading)
        }
    }
    
    func setupDescriptionLabel() {
        view.addSubview(descriptonLabel)
        descriptonLabel.text = "뚝섬역 근처에서 퇴근 후 가볍게 와인 한잔 하실 분들을 모집합니다. 참가비는 25,000이고 장소는 댓글 남기시면 대댓글로 알려드려요!"
        descriptonLabel.textColor = .black
        descriptonLabel.font = .systemFont(ofSize: 14)
        descriptonLabel.numberOfLines = 3
    }
    
    func setupDescriptionLabelConstraints() {
        descriptonLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionTitleLabel.snp.bottom).offset(10)
            make.leading.equalTo(descriptionTitleLabel.snp.leading)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
    }
    
    func setupJoinButton() {
        view.addSubview(joinButton)
        joinButton.setTitle("참가하기", for: .normal)
        joinButton.backgroundColor = UIColor(hex: "FA735B")
        joinButton.layer.cornerRadius = 15
        joinButton.setTitleColor(UIColor(hex: "FFFFFF"), for: .normal)
    }
    
    func setupJoinButtonConstraints() {
        joinButton.snp.makeConstraints { make in
            make.top.equalTo(descriptonLabel.snp.top).offset(76)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(263)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-19)
            make.height.greaterThanOrEqualTo(32)
        }
    }
    
    func setupVectorLineView() {
        view.addSubview(vectorLine)
        vectorLine.backgroundColor = UIColor(hex: "D7D7D7")
    }
    
    func setupVectorLineViewConstraints() {
        vectorLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(joinButton.snp.bottom).offset(17)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(13)
        }
    }
    
    // 테이블 뷰 설정
    func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomCell")
    }
    
    func setupTableViewConstraints() {
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(joinButton.snp.bottom).offset(66)
            make.bottom.equalToSuperview().offset(-100) // 수정 필요함
        }
    }
    
    // 댓글 입력 필드 설정
    func setupCommentInputField() {
        view.addSubview(commentTextField)
        view.addSubview(sendButton)
        
        commentTextField.attributedPlaceholder = NSAttributedString(
            string: "댓글을 입력해주세요.",
            attributes: [
                .font: UIFont.systemFont(ofSize: 14),
                .foregroundColor: UIColor(hex: "767676")
            ]
        )
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 18.48, height: commentTextField.frame.height))
        commentTextField.leftView = paddingView
        commentTextField.leftViewMode = .always
        
        commentTextField.backgroundColor = UIColor(hex: "E5E5E5")
        commentTextField.layer.cornerRadius = 10
        
        sendButton.setTitle("등록하기", for: .normal)
        sendButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        sendButton.setTitleColor(UIColor(hex: "FFFFFF"), for: .normal)
        sendButton.backgroundColor = UIColor(hex: "FA735B")
        sendButton.layer.cornerRadius = 10
        sendButton.addTarget(self, action: #selector(sendComment), for: .touchUpInside)
        
        commentTextField.snp.makeConstraints { make in
            make.leading.equalTo(descriptonLabel.snp.leading).offset(-9)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.height.equalTo(44)
            make.trailing.equalTo(sendButton.snp.leading).offset(-10)
        }
        
        sendButton.snp.makeConstraints { make in
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-16)
            make.height.equalTo(commentTextField.snp.height)
            make.centerY.equalTo(commentTextField.snp.centerY)
            make.width.equalTo(60)
        }
    }
    
    func saveCommentsToUserDefaults() {
        let encodedComments = comments.map { comment -> Comment in
            var modifiedComment = comment
            modifiedComment.profileImageName = comment.profileImageName
            return modifiedComment
        }
        UserDefaults.standard.saveComments(encodedComments)
    }
    
    func loadCommentsFromUserDefaults() {
        comments = UserDefaults.standard.loadComments()
    }
    
    // 댓글 전송 버튼
    @objc func sendComment() {
        guard let commentText = commentTextField.text, !commentText.isEmpty else { return }
        
        // 새로운 댓글 추가
        let newComment = Comment(profileImageName: "Profile", name: "작성자", date: Date(), comment: commentText)
        comments.append(newComment)
        commentTextField.text = ""
        tableView.reloadData()
    }
    
    func calculateElapsedTime(from date: Date) -> String {
        let elapsedTime = Int(Date().timeIntervalSince(date))
        
        if elapsedTime < 60 {
            return "방금 전"
        } else if elapsedTime < 3600 {
            return "\(elapsedTime / 60)분 전"
        } else if elapsedTime < 86400 {
            return "\(elapsedTime / 3600)시간 전"
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy.MM.dd"
            return formatter.string(from: date)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
        
        let commentData = comments[indexPath.row]
        cell.configure(profileImage: UIImage(named: commentData.profileImageName), name: commentData.name, date: "작성일자: \(calculateElapsedTime(from: commentData.date))", comment: commentData.comment)
        
        return cell
    }
}
