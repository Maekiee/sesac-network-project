import UIKit
import SnapKit
import Kingfisher

class ShoppingResultCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "ShoppingResultCollectionViewCell"
    let deviceWidth = (UIScreen.main.bounds.width - 24) / 2
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    let brandLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCellItems(item: Product) {
        let Url = URL(string: item.image)
        imageView.kf.setImage(with: Url)
        brandLabel.text = item.mallName
        titleLabel.text = item.title
        priceLabel.text = item.lprice
        
    }
    
}

extension ShoppingResultCollectionViewCell: ViewdesignProtocol {
    func configureHierarchy() {
        contentView.addSubview(imageView)
        contentView.addSubview(brandLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
    }
    
    func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(deviceWidth)
        }
        
        brandLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(4)
            make.leading.equalToSuperview().inset(8)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(brandLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview().inset(8)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().inset(8)
        }
    }
    
    func configureView() {
//        contentView.layer.borderColor = UIColor.red.cgColor
//        contentView.layer.borderWidth = 1.0
    }
    
    
}
