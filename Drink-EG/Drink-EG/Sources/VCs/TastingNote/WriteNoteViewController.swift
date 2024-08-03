import UIKit
import SnapKit

class WriteNoteViewController: UIViewController {
    
    let tastingnoteLabel = UILabel()
    let categoriesView = UIView()
    let wineView = UIView()
    let wineImageView = UIImageView()
    let wineName = UILabel()
    let showPentagonButton = UIButton()
    let categories = ["당도", "산도", "타닌", "바디", "알코올"]
    var categoryLabels: [UILabel] = []
    var buttonGroups: [[UIButton]] = []
    var connectingLinesGroups: [[UIView]] = []
    var selectedValues: [CharacteristicType: Int] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupWineView()
        setupWineViewConstraints()
        setupWineImageView()
        setupWineImageViewConstraints()
        setupShowPentagonButton()
        setupShowPentagonButtonConstraints()
        setupWineName()
        setupWineNameConstraints()
        setupCategories()
        setupConstraints()
        setupCatagoriesView()
        setupCategoriesViewConstraints()
        showPentagonButton.isHidden = true
    }
    
    func setupWineView() {
        view.addSubview(wineView)
        wineView.backgroundColor = UIColor(hex: "FFD73880")
        wineView.layer.cornerRadius = 10
    }
    
    func setupWineViewConstraints() {
        wineView.snp.makeConstraints{ make in
            make.top.equalTo(view.snp.top).offset(156)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(361)
            make.height.equalTo(94)
        }
    }
    
    func setupWineImageView() {
        wineView.addSubview(wineImageView)
        wineImageView.contentMode = .scaleAspectFit
        wineImageView.layer.cornerRadius = 10
        wineImageView.layer.masksToBounds = true
        wineImageView.image = UIImage(named: "SampleImage")
    }
    
    func setupWineImageViewConstraints() {
        wineImageView.snp.makeConstraints{ make in
            make.leading.equalTo(wineView.snp.leading).offset(8)
            make.top.equalTo(wineView.snp.top).offset(7)
            make.bottom.equalTo(wineView.snp.bottom).offset(-7)
            make.width.height.equalTo(80)
            
        }
    }
    
    func setupWineName() {
        wineView.addSubview(wineName)
        wineName.text = "19 Crhnes"
        
    }
    
    func setupWineNameConstraints() {
        wineName.snp.makeConstraints{ make in
            make.centerY.equalTo(wineImageView.snp.centerY)
            make.leading.equalTo(wineImageView.snp.trailing).offset(25)
            make.top.equalTo(wineView.snp.top).offset(36)
            make.bottom.equalTo(wineView.snp.bottom).offset(-36)
        }
    }
    
    func setupShowPentagonButton() {
        categoriesView.addSubview(showPentagonButton)
        showPentagonButton.layer.cornerRadius = 10
        showPentagonButton.setTitle("Next", for: .normal)
        showPentagonButton.setTitleColor(.black, for: .normal)
        showPentagonButton.backgroundColor = UIColor(hex: "FFD73880")
        showPentagonButton.addTarget(self, action: #selector(showPentagonButtonTapped), for: .touchUpInside)
    }
    
    func setupShowPentagonButtonConstraints() {
        showPentagonButton.snp.makeConstraints{ make in
            make.bottom.equalTo(categoriesView.snp.bottom).offset(-20)
            make.centerX.equalTo(categoriesView.snp.centerX)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
    }
    
    func setupCatagoriesView() {
        view.addSubview(categoriesView)
        categoriesView.backgroundColor = UIColor(hex: "EAEAEA")
        categoriesView.layer.cornerRadius = 10
    }
    
    func setupCategoriesViewConstraints() {
        categoriesView.snp.makeConstraints{ make in
            make.top.equalTo(wineView.snp.bottom).offset(10)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(361)
            make.height.equalTo(543)
        }
    }
    
    func setupCategories() {
        for (categoryIndex, category) in categories.enumerated() {
            let label = UILabel()
            label.text = category
            label.backgroundColor = UIColor(hex: "FFEA75")
            label.textAlignment = .center
            label.font = UIFont.boldSystemFont(ofSize: 18)
            label.layer.cornerRadius = 10
            label.layer.masksToBounds = true
            categoryLabels.append(label)
            categoriesView.addSubview(label)
            
            var buttons: [UIButton] = []
            for buttonIndex in 0..<5 {
                let button = UIButton()
                button.layer.cornerRadius = 8
                button.backgroundColor = UIColor(hex: "B3B3B3")
                button.tag = categoryIndex * 5 + buttonIndex
                button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
                buttons.append(button)
               categoriesView.addSubview(button)
            }
            buttonGroups.append(buttons)
            
            var connectingLines: [UIView] = []
            for _ in 0..<4 {
                let line = UIView()
                line.backgroundColor = UIColor.gray
                connectingLines.append(line)
                categoriesView.addSubview(line)
            }
            connectingLinesGroups.append(connectingLines)
        }
    }
    
    func setupConstraints() {
        for i in 0..<categories.count {
            let label = categoryLabels[i]
            let buttons = buttonGroups[i]
            let connectingLines = connectingLinesGroups[i]
            
            label.snp.makeConstraints { make in
                make.width.equalTo(71)
                make.height.equalTo(39)
                make.leading.equalTo(categoriesView.snp.leading).offset(17)
                if i == 0 {
                    make.top.equalTo(categoriesView.snp.top).offset(23)
                } else {
                    make.top.equalTo(categoryLabels[i-1].snp.bottom).offset(48)
                }
            }
            
            for (index, button) in buttons.enumerated() {
                button.snp.makeConstraints { make in
                    make.centerY.equalTo(label.snp.centerY)
                    if index == 0 {
                        make.leading.equalTo(categoryLabels[i].snp.trailing).offset(15)
                    } else {
                        make.leading.equalTo(buttons[index - 1].snp.trailing).offset(40)
                    }
                    make.width.equalTo(16)
                    make.height.equalTo(16)
                }
                
                if index < buttons.count - 1 {
                    connectingLines[index].snp.makeConstraints { make in
                        make.centerY.equalTo(button.snp.centerY)
                        make.leading.equalTo(button.snp.trailing)
                        make.trailing.equalTo(buttons[index + 1].snp.leading)
                        make.height.equalTo(2)
                    }
                }
            }
        }
    }
    
    func checkIfAllSelected() {
        if selectedValues.count == categories.count {
            showPentagonButton.isHidden = false
        } else {
            showPentagonButton.isHidden = true
        }
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        let tag = sender.tag % 5 // 각 줄에서 몇 번째 버튼인지 계산
        let row = sender.tag / 5 // 몇 번째 줄인지 계산
        print("Row: \(row + 1), Button: \((tag + 1)*20)")
        
        for button in buttonGroups[row] {
            button.backgroundColor = .lightGray
        }
        sender.backgroundColor = .red
        
        let selectedValue = (tag + 1) * 20
        let characteristic = categories[row]
        selectedValues[CharacteristicType(rawValue: characteristic)!] = selectedValue
        
        checkIfAllSelected()
    }
    
    @objc func showPentagonButtonTapped() {
        let polygonVC = NoteInfoViewController()
        var dataList: [RadarChartData] = []
        for (type, value) in selectedValues {
            dataList.append(RadarChartData(type: type, value: value))
        }
        polygonVC.dataList = dataList
        navigationController?.pushViewController(polygonVC, animated: true)
    }
}
