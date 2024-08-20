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
    var categorySliders: [UISlider] = []
    var selectedValues: [CharacteristicType: Int] = [:]
    var selectedWineName: String?
    var selectedWineImage: String?
    var selectedWineId: Int?
    var selectedWineSort: String?
    var selectedWineArea: String?
    
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    let nextButton = UIButton()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupScrollView()
        setupNavigationBarButton()
        setupLabel()
        setuptastingnoteLabelConstraints()
        setupWineView()
        setupWineViewConstraints()
        setupWineImageView()
        setupWineImageViewConstraints()
        setupWineName()
        setupWineNameConstraints()
        setupCategories()
        setupConstraints()
        setupCatagoriesView()
        setupCategoriesViewConstraints()
        setupNextButton()
        setupNextButtonConstraints()
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.backgroundColor = .clear
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.height.equalTo(UIScreen.main.bounds.height * 1.1)
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
    
    func setupLabel() { // Label의 기본 속성을 설정하는 함수
        contentView.addSubview(tastingnoteLabel)
        tastingnoteLabel.text = "테이스팅 노트"
        tastingnoteLabel.font = .systemFont(ofSize: UIConstants.labelFontSize, weight: UIFont.Weight(rawValue: 700))
        tastingnoteLabel.textAlignment = .center
        tastingnoteLabel.textColor = .black
    }
    
    func setuptastingnoteLabelConstraints() { // Label의 제약 조건을 설정하는 함수
        tastingnoteLabel.snp.makeConstraints{ make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalTo(contentView.safeAreaLayoutGuide.snp.leading).offset(27)
        }
    }
    
    func setupWineView() {
        contentView.addSubview(wineView)
        wineView.backgroundColor = UIColor(hex: "FF9F8E80")
        wineView.layer.cornerRadius = 10
        wineView.layer.borderWidth = 2
        wineView.layer.borderColor = UIColor(red: 0.98, green: 0.451, blue: 0.357, alpha: 1).cgColor
    }
    
    func setupWineViewConstraints() {
        wineView.snp.makeConstraints{ make in
            make.top.equalTo(tastingnoteLabel.snp.bottom).offset(32)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            make.leading.equalTo(tastingnoteLabel.snp.leading)
            make.width.equalTo(361)
            make.height.equalTo(94)
        }
    }
    
    func setupWineImageView() {
        wineView.addSubview(wineImageView)
        wineImageView.contentMode = .scaleAspectFit
        wineImageView.layer.cornerRadius = 10
        wineImageView.layer.masksToBounds = true
        if let imageUrl = selectedWineImage, let url = URL(string: imageUrl) {
            wineImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "Loxton"))
        } else {
            wineImageView.image = UIImage(named: "Loxton")
        }
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
        wineName.text = selectedWineName ?? ""
        wineName.numberOfLines = 0
        wineName.lineBreakMode = .byWordWrapping
        wineName.font = UIFont(name: "Pretendard-SemiBold", size: 18)
    }
    
    func setupWineNameConstraints() {
        wineName.snp.makeConstraints{ make in
            make.centerY.equalTo(wineImageView.snp.centerY)
            make.leading.equalTo(wineImageView.snp.trailing).offset(25)
            make.trailing.equalTo(wineView.snp.trailing).offset(-10)
        }
    }
    
    func setupCatagoriesView() {
        contentView.addSubview(categoriesView)
        categoriesView.backgroundColor = UIColor(hex: "EAEAEA")
        categoriesView.layer.cornerRadius = 10
    }
    
    func setupCategoriesViewConstraints() {
        categoriesView.snp.makeConstraints{ make in
            make.top.equalTo(wineView.snp.bottom).offset(10)
            make.centerX.equalTo(wineView.snp.centerX)
            make.leading.equalTo(wineView.snp.leading)
            make.height.equalTo(UIScreen.main.bounds.height * 0.6)
        }
    }
    
    func setupCategories() {
        for (_, category) in categories.enumerated() {
            let label = UILabel()
            label.text = category
            label.backgroundColor = UIColor(hex: "FA735B")
            label.textAlignment = .center
            label.font = UIFont.boldSystemFont(ofSize: 18)
            label.layer.cornerRadius = 10
            label.layer.masksToBounds = true
            categoryLabels.append(label)
            categoriesView.addSubview(label)
            
            let slider = CustomSlider()
            slider.minimumValue = 0
            slider.maximumValue = 10
            slider.minimumTrackTintColor = UIColor(hex: "D3D3D3")
            slider.thumbTintColor = UIColor(hex: "FA735B")
            categorySliders.append(slider)
            categoriesView.addSubview(slider)
        }
    }
    
    func setupConstraints() {
        let labelHeight: CGFloat = UIScreen.main.bounds.height * 0.05
        let verticalSpacing: CGFloat = (UIScreen.main.bounds.height * 0.6 - labelHeight * CGFloat(categories.count)) / CGFloat(categories.count + 1)
        
        
        for i in 0..<categories.count {
            let label = categoryLabels[i]
            let slider = categorySliders[i]
            
            label.snp.makeConstraints { make in
                make.width.equalTo(categoriesView.snp.width).multipliedBy(0.23)
                make.height.equalTo(labelHeight) // Set height based on screen height
                make.leading.equalTo(categoriesView.snp.leading).offset(17)
                if i == 0 {
                    make.top.equalTo(categoriesView.snp.top).offset(verticalSpacing)
                } else {
                    make.top.equalTo(categoryLabels[i-1].snp.bottom).offset(verticalSpacing)
                }
            }
            
            slider.snp.makeConstraints { make in
                make.leading.equalTo(label.snp.trailing).offset(25)
                make.centerY.equalTo(label.snp.centerY)
                make.trailing.equalTo(categoriesView.snp.trailing).offset(-18)
            }
            
        }
    }
    
    func setupNextButton() {
        contentView.addSubview(nextButton)
        nextButton.setTitle("다음 >", for: .normal)
        nextButton.backgroundColor = UIColor(hex: "FA735B")
        nextButton.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 20)
        nextButton.titleLabel?.textColor = .white
        nextButton.layer.cornerRadius = 16
        nextButton.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
    }
    
    func setupNextButtonConstraints() {
        nextButton.snp.makeConstraints { make in
            make.leading.equalTo(categoriesView.snp.leading).offset(17)
            make.centerX.equalTo(categoriesView.snp.centerX)
            make.top.equalTo(categoriesView.snp.bottom).offset(30)
            make.height.greaterThanOrEqualTo(60)
        }
    }
    
    @objc func nextButtonTapped(_ sender: UIButton) {
        for (index, slider) in categorySliders.enumerated() {
            let value = Int(slider.value)
            if let category = CharacteristicType(rawValue: categories[index]) {
                selectedValues[category] = value
            }
        }
        
        // NoteInfoViewController로 값 전달
        let polygonVC = NoteInfoViewController()
        var dataList: [RadarChartData] = [] // 각각의 value를 전달
        for (type, value) in selectedValues {
            dataList.append(RadarChartData(type: type, value: value))
        }
        polygonVC.dataList = dataList
        polygonVC.selectedWineId = selectedWineId
        polygonVC.selectedWineImage = selectedWineImage
        polygonVC.selectedWineName = selectedWineName
        polygonVC.selectedWineArea = selectedWineArea
        polygonVC.selectedWineSort = selectedWineSort
        navigationController?.pushViewController(polygonVC, animated: true)
    }
}
