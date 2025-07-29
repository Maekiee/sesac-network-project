import UIKit
import Alamofire
import SnapKit

enum ShoppingSortCase: String, CaseIterable {
    case sim = "정확도"
    case date = "날짜순"
    case asc = "가격낮은순"
    case dsc = "가격높은순"
}

class ShoppingResultViewController: UIViewController {
    var searchWord: String = ""
    var listCount: Int = 1
    var aaaList: [Product] = []
    var currentCategory = ShoppingSortCase.sim
    var newItems: [ProductViewModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    var totalCount: Int = 0
    
    // 넘버 폼새 사용 하기
    let searchTotalCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGreen
        label.text = ""
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        ShoppingSortCase.allCases.forEach { item in
            let button = CategoryButton(
                title: item.rawValue,
                caseTag: item
            )
            button.addTarget(self, action: #selector(sortReloadData), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
        return stackView
    }()
    lazy var collectionView: UICollectionView = {
        let layout = setCellLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ShoppingResultCollectionViewCell.self, forCellWithReuseIdentifier: ShoppingResultCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
        
        NetworkManager.shared.getShoppingData(searchWord: searchWord, sortCase: currentCategory) { value in
            self.newItems = value.items.map { ProductViewModel(product: $0) }
            self.searchTotalCountLabel.text = "\(NumberFormat.shared.formatNum(from: value.total)) 개의 검색 결과"
            self.listCount = value.items.count
            self.totalCount = value.total
        } errorHandler: { error in
            
            self.showAlert(tip: "네트워크 에러")
        }
    }
    
    
    
    // 필터 버튼
    @objc private func sortReloadData(_ sender: UIButton) {
        guard let myButton = sender as? CategoryButton else { return }
        currentCategory = myButton.buttonTag
        NetworkManager.shared.getShoppingData(searchWord: searchWord, sortCase: currentCategory) { resultValue in
            self.newItems.removeAll()
                            self.newItems = resultValue.items.map { ProductViewModel(product: $0) }
                            self.searchTotalCountLabel.text = "\(resultValue.total.formatted()) 개의 검색 결과"
                            self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        } errorHandler: { error in
            self.showAlert(tip: "네트워크 에러")
        }
        
    }

}

//MARK: 컬렉션 뷰
extension ShoppingResultViewController: UICollectionViewDelegate, UICollectionViewDataSource, CollectionViewLayoutProtocol {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShoppingResultCollectionViewCell.identifier, for: indexPath) as! ShoppingResultCollectionViewCell
        let item = newItems[indexPath.item]
        cell.setCellItems(item: item)
        
        return cell
    }
    
    func setCellLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = (deviceWidth - 24) / 2
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth + (cellWidth / 2))
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 40, right: 8)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        return layout
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // 페이지네이션
        if indexPath.item == (newItems.count - 3) && newItems.count < totalCount {
            listCount = newItems.count + 1
            
            NetworkManager.shared.getShoppingData(searchWord: searchWord, sortCase: currentCategory, count: listCount) { reslutValue in
                self.newItems.append(contentsOf: reslutValue.items.map { ProductViewModel(product: $0)} )
                self.searchTotalCountLabel.text = "\(NumberFormat.shared.formatNum(from: reslutValue.total)) 개의 검색 결과"
            } errorHandler: { error in
                self.showAlert(tip: "네트워크 에러")
            }
        }
    }
}

//MARK: 프로토콜
extension ShoppingResultViewController: ViewdesignProtocol {
    
    func configureHierarchy() {
        view.addSubview(searchTotalCountLabel)
        view.addSubview(stackView)
        view.addSubview(collectionView)
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
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(8)
            make.horizontalEdges.bottom.equalToSuperview()
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
