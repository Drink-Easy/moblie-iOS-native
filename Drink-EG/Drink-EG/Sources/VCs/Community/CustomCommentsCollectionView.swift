import UIKit

class CustomCommentsCollectionView: UITableViewCell {
    let profileImageView = UIImageView()
    let nameLabel = UILabel()
    let dateLabel = UILabel()
    let commentLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(commentLabel)
        
        profileImageView.layer.cornerRadius = 20
        profileImageView.clipsToBounds = true
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.textColor = .gray
        commentLabel.font = UIFont.systemFont(ofSize: 14)
        commentLabel.numberOfLines = 0
    }
    
    func setupConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(40)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(8)
            make.top.equalToSuperview().offset(8)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel.snp.trailing).offset(8)
            make.centerY.equalTo(nameLabel.snp.centerY)
        }
        
        commentLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel.snp.leading)
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
    func configure(profileImage: UIImage?, name: String, date: String, comment: String) {
        profileImageView.image = profileImage
        nameLabel.text = name
        dateLabel.text = date
        commentLabel.text = comment
    }
}
