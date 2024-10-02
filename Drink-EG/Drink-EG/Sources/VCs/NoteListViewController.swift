//
//  NoteListViewController.swift
//  Drink-EG
//
//  Created by 김도연 on 7/21/24.
//

import Foundation
import UIKit
import SnapKit
import Moya

class NoteListViewController: UIViewController {
    
    var wineCount: Int = 0
    
    // Source -> cells -> TastingNote
    private let noteListView = NoteListView()
    // Source -> cells -> TastingNote
    private let wineImageStackView = WineImageStackView()
    private let myTastingNote = MyTastingNote()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(hex: ColorHex().background)
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(noteListView)
        noteListView.updateTotalWineCount(count: wineCount)
        noteListView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(106)
            make.leading.equalTo(view.snp.leading).offset(24)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(100) // 수정 필요
        }
        
        view.addSubview(wineImageStackView)
        wineImageStackView.snp.makeConstraints { make in
            make.top.equalTo(noteListView.snp.bottom).offset(24)
            make.leading.equalTo(noteListView.snp.leading)
            make.centerX.equalTo(noteListView.snp.centerX)
        }
        
        view.addSubview(myTastingNote)
        myTastingNote.snp.makeConstraints { make in
            make.top.equalTo(wineImageStackView.snp.bottom).offset(24)
            make.leading.equalTo(wineImageStackView.snp.leading)
            make.centerX.equalToSuperview()
        }
    }
    
    
    
    
}
