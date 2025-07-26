import UIKit
import Alamofire
import SnapKit

enum ShoppingSortCase: String, CaseIterable {
    case date = "날짜순"
    case sim = "정확도"
    case asc = "가격낮은순"
    case dsc = "가격높은순"
}

class ShoppingResultViewController: UIViewController {
    var searchWord: String = ""
    
    
    let searchTotalCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGreen
        label.text = "202020202"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        ShoppingSortCase.allCases.forEach { item in
            let button = CategoryButton(
                title: item.rawValue
            )
            stackView.addArrangedSubview(button)
        }
        return stackView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
    }

}



extension ShoppingResultViewController: ViewdesignProtocol {
    func configureHierarchy() {
        view.addSubview(searchTotalCountLabel)
        view.addSubview(stackView)
    }
    
    func configureLayout() {
        searchTotalCountLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.horizontalEdges.equalToSuperview().inset(8)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(searchTotalCountLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(8)
        }
    }
    
    func configureView() {
        view.backgroundColor = .black
        navigationItem.title = searchWord
        if let navigationBar = self.navigationController?.navigationBar {
            navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)
            ]
        }
        navigationController?.navigationBar.tintColor = .white
    }
    
    
}
