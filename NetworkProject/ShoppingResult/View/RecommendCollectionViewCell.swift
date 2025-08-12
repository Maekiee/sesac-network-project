import UIKit
import SnapKit
import Kingfisher

class RecommendCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "RecommendCollectionViewCell"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
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
    
    func setCellItems(item: RecommendProductModel) {
        imageView.kf.setImage(with: item.imageUrl)
    }
    
}


extension RecommendCollectionViewCell: ViewdesignProtocol {
    func configureHierarchy() {
        contentView.addSubview(imageView)
    }
    
    func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(100)
        }
    }
    
    func configureView() {
    }
    
    
}
