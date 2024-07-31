import UIKit
import SnapKit

class WriteNoteViewController: UIViewController {
    
    let tastingnoteLabel = UILabel()
    let categories = ["당도", "산도", "타닌", "바디", "알코올"]
    var categoryLabels: [UILabel] = []
    var buttonGroups: [[UIButton]] = []
    var connectingLinesGroups: [[UIView]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "EAEAEA")
        
        setupCategories()
        setupConstraints()
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
            view.addSubview(label)
            
            var buttons: [UIButton] = []
            for buttonIndex in 0..<5 {
                let button = UIButton()
                button.layer.cornerRadius = 10
                button.backgroundColor = UIColor(hex: "B3B3B3")
                button.tag = categoryIndex * 5 + buttonIndex
                button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
                buttons.append(button)
                view.addSubview(button)
            }
            buttonGroups.append(buttons)
            
            var connectingLines: [UIView] = []
            for _ in 0..<4 {
                let line = UIView()
                line.backgroundColor = UIColor.gray
                connectingLines.append(line)
                view.addSubview(line)
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
                make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
                make.width.equalTo(70)
                make.height.equalTo(40)
                if i == 0 {
                    make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
                } else {
                    make.top.equalTo(categoryLabels[i - 1].snp.bottom).offset(75)
                }
            }
            
            for (index, button) in buttons.enumerated() {
                button.snp.makeConstraints { make in
                    make.centerY.equalTo(label.snp.centerY)
                    if index == 0 {
                        make.leading.equalTo(label.snp.trailing).offset(20)
                    } else {
                        make.leading.equalTo(buttons[index - 1].snp.trailing).offset(20)
                    }
                    make.width.height.equalTo(20)
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
    
    @objc func buttonTapped(_ sender: UIButton) {
        let tag = sender.tag % 5 // 각 줄에서 몇 번째 버튼인지 계산
        let row = sender.tag / 5 // 몇 번째 줄인지 계산
        print("Row: \(row + 1), Button: \(tag + 1)번째 버튼")
        
        for button in buttonGroups[row] {
            button.backgroundColor = .lightGray
        }
        sender.backgroundColor = .red
    }
}
