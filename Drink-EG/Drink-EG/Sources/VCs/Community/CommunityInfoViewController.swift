//
//  CommunityInfoViewController.swift
//  Drink-EG
//
//  Created by 김도연 on 7/21/24.
//

import Foundation
import UIKit
import SnapKit

struct Comment {
    var id: Int
    var text: String
    var author: String
    var timestamp: String
    var replies: [Comment] // 대댓글을 담을 배열
}

class CommunityInfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var comments: [Comment] = []
    let commentTableView = UITableView()
    let commentTextField = UITextField()
    let submitButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // 테이블 뷰 설정
        commentTableView.dataSource = self
        commentTableView.delegate = self
        commentTableView.register(UITableViewCell.self, forCellReuseIdentifier: "CommentCell")
        
        view.addSubview(commentTableView)
        view.addSubview(commentTextField)
        view.addSubview(submitButton)
        
        setupUI()
    }
    
    func setupUI() {
        commentTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalTo(view)
            make.bottom.equalTo(commentTextField.snp.top).offset(-10)
        }
        
        commentTextField.borderStyle = .roundedRect
        commentTextField.placeholder = "댓글을 입력하세요"
        commentTextField.layer.cornerRadius = 100
        
        submitButton.setTitle("등록", for: .normal)
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.backgroundColor = .systemBlue
        submitButton.layer.cornerRadius = 5
        submitButton.addTarget(self, action: #selector(addComment), for: .touchUpInside)
        
        commentTextField.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(16)
            make.trailing.equalTo(submitButton.snp.leading).offset(-8)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.height.equalTo(40)
        }
        
        submitButton.snp.makeConstraints { make in
            make.trailing.equalTo(view).offset(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.height.equalTo(40)
            make.width.equalTo(60)
        }
    }
    
    @objc func addComment() {
        guard let text = commentTextField.text, !text.isEmpty else { return }
        
        let newComment = Comment(id: comments.count + 1, text: text, author: "사용자", timestamp: "방금", replies: [])
        comments.append(newComment)
        commentTableView.reloadData()
        commentTextField.text = ""
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments[section].replies.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath)
        
        let comment = comments[indexPath.section]
        if indexPath.row == 0 {
            // 댓글 표시
            cell.textLabel?.text = "\(comment.author): \(comment.text)"
        } else {
            // 대댓글 표시
            let reply = comment.replies[indexPath.row - 1]
            cell.textLabel?.text = "↳ \(reply.author): \(reply.text)"
            cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
            cell.textLabel?.textColor = .gray
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            // 댓글 클릭 시 대댓글 추가 로직
            let alertController = UIAlertController(title: "대댓글 달기", message: nil, preferredStyle: .alert)
            alertController.addTextField { textField in
                textField.placeholder = "대댓글을 입력하세요"
            }
            let submitAction = UIAlertAction(title: "등록", style: .default) { [unowned self] _ in
                guard let text = alertController.textFields?.first?.text, !text.isEmpty else { return }
                let reply = Comment(id: self.comments[indexPath.section].replies.count + 1, text: text, author: "사용자", timestamp: "방금", replies: [])
                self.comments[indexPath.section].replies.append(reply)
                self.commentTableView.reloadSections([indexPath.section], with: .automatic)
            }
            alertController.addAction(submitAction)
            alertController.addAction(UIAlertAction(title: "취소", style: .cancel))
            present(alertController, animated: true)
        }
    }
}
