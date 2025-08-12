import UIKit
import SnapKit

class ShoppingSearchViewController: UIViewController {
    let viewModel = ShoppingSearchViewModel()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "땡땡댕의 쇼핑쇼핑"
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .white
        return label
    }()
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.barTintColor = .clear
        searchBar.placeholder = "브랜드,상품,프로필,태그 등"
        searchBar.searchTextField.textColor = .white
        searchBar.searchTextField.leftView?.tintColor = .systemGray5
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "브랜드,상품,프로필,태그 등",
                                                                             attributes: [.foregroundColor : UIColor.systemGray5])
        return searchBar
    }()
    let mainImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "flex_shopping")
        return imageView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
        
        viewModel.isShow.bind { [weak self] value in
            guard let self = self else { return }
            if value {
                showAlert(tip: "2글자 이상 입력해 주세요")
            }
        }
    }
}

extension ShoppingSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.inputSearchText.value = searchBar.text
        
        let vc = ShoppingResultViewController()
        vc.viewModel.outputSearchWord.value = viewModel.outputSearchText.value
        navigationController?.pushViewController(vc, animated: true)
        view.endEditing(true)
        searchBar.text = ""
    }
}



extension ShoppingSearchViewController: ViewdesignProtocol {
    func configureHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(searchBar)
        view.addSubview(mainImage)
    }
    
    func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview().inset(8)
        }
        
        mainImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(48)
            make.height.equalTo(250)
        }
        
    }
    
    func configureView() {
        view.backgroundColor = .black
    }
}
