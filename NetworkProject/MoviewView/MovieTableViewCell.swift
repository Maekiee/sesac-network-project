
import UIKit
import SnapKit

class MovieTableViewCell: UITableViewCell {
    static let identifier: String = "MovieTableViewCell"
    let rankingLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .black
        label.textAlignment = .center
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
        label.font = .systemFont(ofSize: 14)
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
    
    func configCellData(row: BoxOffice, index: Int) {
        rankingLabel.text = row.rank
        titleLabel.text = row.movieNm
        dateLabel.text = row.openDt
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
            make.centerY.equalToSuperview()
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.size.equalTo(32)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(rankingLabel.snp.trailing).offset(4)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).inset(4)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(16)
        }
    }
    
    func configureView() {
    }
    
    
}
