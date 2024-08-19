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

class NewNoteFooter: UICollectionReusableView {
    let button = UIButton(type: .system)
    weak var delegate: NewNoteFooterDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(button)

        button.setTitle("+ 새로 적기", for: .normal)
        button.setTitleColor(UIColor(hex: "FFFFFF"), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = UIColor(hex: "FA735B")
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(newNoteButtonTapped), for: .touchUpInside)
        button.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.height.greaterThanOrEqualTo(61)
            // make.bottom.equalToSuperview().offset(-10)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func newNoteButtonTapped() {
        delegate?.didTapNewNoteButton()
    }
}

struct Note: Decodable {
    let noteId: Int
    let name: String
    let imageUrl: String
}

struct AllNotesResponse: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: [Note]
}

// NoteListViewController는 사용자가 작성한 테이스팅 노트를 확인 및 새로 작성할 수 있는 뷰
class NoteListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, NewNoteFooterDelegate {
   
    let provider = MoyaProvider<TastingNoteAPI>(plugins: [CookiePlugin()])
    
    let noteListLabel = UILabel() // 노트 보관함 Label
    var noteListGrid: UICollectionView! // 테이스팅 노트를 보관할 CollectionView
    var apiResult: [[String: String]] = []
    var cellCount: Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        setupAPI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCollectionView()
        setupView()
        setupNavigationBarButton()
        setupLabel()
        setupNoteListLabelConstraints()
        setupNoteCollectionViewConstraints()
    }
    
    func setupView() { // 뷰 설정 함수
        view.addSubview(noteListLabel)
        view.addSubview(noteListGrid)
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
    
    // MARK: 노트 보관함에 관한 UI
    func setupLabel() { // Label의 기본 속성을 설정하는 함수
        noteListLabel.text = "노트 보관함"
        noteListLabel.font = UIFont(name: "Pretendard-Bold", size: 28)
        noteListLabel.textAlignment = .center
        noteListLabel.textColor = .black
    }
    
    func setupNoteListLabelConstraints() { // Label의 제약 조건을 설정하는 함수
        noteListLabel.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(46)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
        }
    }
    
    // MARK: 작성한 테이스팅 노트를 보여주는 Grid에 관한 UI
    func setupCollectionView() { // CollectionView의 기본 속성을 설정하는 함수
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 65, height: 65)
        layout.minimumLineSpacing = 69
        layout.minimumInteritemSpacing = 22
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.footerReferenceSize = CGSize(width: view.frame.width, height: 60)
        
        noteListGrid = UICollectionView(frame: .zero, collectionViewLayout: layout)
        noteListGrid.backgroundColor = .clear
        noteListGrid.layer.cornerRadius = 36
        noteListGrid.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMinYCorner)
        noteListGrid.layer.borderWidth = 1
        noteListGrid.layer.borderColor = UIColor.clear.cgColor
        

        noteListGrid.dataSource = self
        noteListGrid.delegate = self
        noteListGrid.register(NoteCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        noteListGrid.register(NewNoteFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer")
        
        let backgroundView = UIView()
        backgroundView.layer.cornerRadius = 10
        backgroundView.layer.masksToBounds = false
        noteListGrid.backgroundView = backgroundView
    }
    
    func setupNoteCollectionViewConstraints() { // CollectionView의 제약 조건을 설정하는 함수
        noteListGrid.snp.makeConstraints{ make in
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(noteListLabel.snp.bottom).offset(35)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // CollectionView Cell 개수를 설정하는 함수
        return cellCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell { // 재사용 가능한 셀을 가져와서 NoteCollectionViewCell로 캐스팅
        let cell = noteListGrid.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NoteCollectionViewCell

        let wineData = apiResult[indexPath.row]
        
        cell.nameLabel.text = wineData["name"]
        cell.nameLabel.numberOfLines = 2
        cell.nameLabel.font = UIFont(name: "Pretendard-Bold", size: 14)
        cell.backgroundColor = .clear
        if let imageUrl = wineData["imageUrl"], let url = URL(string: imageUrl) {
            cell.imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        } else {
            cell.imageView.image = UIImage(named: "placeholder")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { // 각 셀의 크기를 설정하는 함수
        let numberOfItemsPerRow: CGFloat = 4
        let spacingBetweenCells: CGFloat = 22
        
        let totalSpacing = (2 * spacingBetweenCells) + ((numberOfItemsPerRow - 1) * spacingBetweenCells)
        
        let width = (collectionView.bounds.width - totalSpacing) / numberOfItemsPerRow
        let height = width * 1.6
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedNoteId = apiResult[indexPath.row]["noteId"] // noteId 가져오기
        guard let noteId = Int(selectedNoteId ?? "") else { return }
        
        fetchNoteDetails(noteId: noteId)
    }
    
    func fetchNoteDetails(noteId: Int) {
        provider.request(TastingNoteAPI.getNoteID(noteId: noteId)) { result in
            switch result {
            case .success(let response):
                do {
                    // JSON 데이터를 문자열로 변환하여 출력
                    if let jsonString = String(data: response.data, encoding: .utf8) {
                        print("Response JSON String: \(jsonString)")
                    }
                    
                    // ResponseWrap 구조체로 디코딩
                    let noteResponse = try JSONDecoder().decode(ResponseWrap.self, from: response.data)
                    self.handleNoteData(noteResponse.result)
                } catch {
                    print("Failed to decode response: \(error)")
                }
            case .failure(let error):
                print("Request failed: \(error)")
            }
        }
    }
    
    func handleNoteData(_ data: NoteResponse) {
        let scentData: [String: [String]] = [
            "scentAroma": data.scentAroma.map { $0.unescapedString },
            "scentTaste": data.scentTaste.map { $0.unescapedString },
            "scentFinish": data.scentFinish.map { $0.unescapedString }
        ]
        
        let dataList: [RadarChartData] = [
            RadarChartData(type: .acid, value: data.acidity),
            RadarChartData(type: .tannin, value: data.tannin),
            RadarChartData(type: .alcohol, value: data.alcohol),
            RadarChartData(type: .bodied, value: data.body),
            RadarChartData(type: .sweetness, value: data.sugarContent)
        ]
        
        let nextVC = CheckNoteViewController()
        nextVC.reviewString = data.review?.unescapedString ?? ""
        nextVC.value = data.satisfaction
        nextVC.dataList = dataList
        nextVC.selectedOptions = scentData
        nextVC.selectedWineName = data.wineName
        nextVC.selectedWineImage = data.imageUrl
        nextVC.area = data.area
        nextVC.sort = data.sort
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    // MARK: "새로 적기" 버튼에 관한 UI
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath) as! NewNoteFooter
            footer.delegate = self
            return footer
        }
        return UICollectionReusableView()
    }
    
    func didTapNewNoteButton() {

        let nextVC = AddNewNoteViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func setupAPI() {
        provider.request(TastingNoteAPI.getAllNotes) { result in
            switch result {
            case .success(let response):
                do {
                    let data = try response.map(AllNotesResponse.self)
                    self.cellCount = data.result.count
                    for note in data.result {
                        let wineData: [String: String] = ["noteId": "\(note.noteId)", "name": note.name, "imageUrl": note.imageUrl]
                        self.apiResult.append(wineData)
                    }
                    print(self.apiResult)
                    print(self.cellCount)
                    self.noteListGrid.reloadData()
                    print("User Data: \(data)")
                } catch {
                    print("Failed to map data: \(error)")
                }
            case .failure(let error):
                print("Request failed: \(error)")
            }
        }
    }
}
