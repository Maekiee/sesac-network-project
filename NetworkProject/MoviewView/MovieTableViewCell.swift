
import UIKit
import SnapKit

class MovieTableViewCell: UITableViewCell {
    static let identifier: String = "MovieTableViewCell"
    let rankingLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .black
        label.textColor = .white
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configCellData(row: Movie, index: Int) {
        rankingLabel.text = "\(index + 1)"
        titleLabel.text = row.title
        dateLabel.text = row.releaseDate
        print(row.title)
    }
}

extension MovieTableViewCell: ViewdesignProtocol {
    func configureHierarchy() {
        contentView.addSubview(rankingLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
    }
    
    func configureLayout() {
        rankingLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).inset(4)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(28)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).inset(4)
            make.leading.equalTo(rankingLabel.snp.trailing).offset(4)
            make.height.equalTo(22)
            make.centerY.equalTo(contentView)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).inset(4)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(16)
        }
    }
    
    func configureView() {
    }
    
    
}
