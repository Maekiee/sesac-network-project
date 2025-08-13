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
    let viewModel = ShoppingResultViewModel()

    
    let totalCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGreen
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
        
        viewModel.input.didLoadTrigger.value = ()
        
        viewModel.output.productList.lazyBind { [weak self] value in
            guard let self = self else { return }
            collectionView.reloadData()
            print("값 바뀜")
        }
        
        viewModel.output.totalCountText.bind { [weak self] value in
            guard let self = self else { return }
            totalCountLabel.text = viewModel.output.totalCountText.value
        }
    }
    
    
    
    // 필터 버튼
    @objc private func sortReloadData(_ sender: CategoryButton) {
        if viewModel.input.selectedCategory.value != sender.buttonTag {
            print("실행 버튼 버튼 ")
            viewModel.input.selectedCategory.value = sender.buttonTag
        }
       
    }

}

//MARK: 컬렉션 뷰
extension ShoppingResultViewController: UICollectionViewDelegate, UICollectionViewDataSource, CollectionViewLayoutProtocol {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.output.productList.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShoppingResultCollectionViewCell.identifier, for: indexPath) as! ShoppingResultCollectionViewCell
        let item = viewModel.output.productList.value[indexPath.item]
        cell.setCellItems(item: item)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // 페이지네이션
//        if indexPath.item == (newItems.count - 3) && newItems.count < totalCount {
//            listCount = newItems.count + 1
//            NetworkManager.shared.getShoppingData(searchWord: searchWord, sortCase: currentCategory, count: listCount) { resultValue in
//                switch resultValue {
//                case .success(let value):
//                    self.newItems.append(contentsOf: value.items)
////                    self.searchTotalCountLabel.text = "\(NumberFormat.shared.formatNum(from: value.total)) 개의 검색 결과"
//                case .failure(let error):
//                    self.showAlert(tip: "페이지 네이션 에러")
//                    print("에러입니다.: \(error)")
//                }
//            }
//        }
    }
    
    //MARK: - 셀 크기
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
    
    func setHorizonCellLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 20)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        return layout
    }
}

//MARK: 프로토콜
extension ShoppingResultViewController: ViewdesignProtocol {
    
    func configureHierarchy() {
        view.addSubview(totalCountLabel)
        view.addSubview(stackView)
        view.addSubview(collectionView)
    }
    
    func configureLayout() {
        totalCountLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.horizontalEdges.equalToSuperview().inset(8)
        }
        // 필터 버튼
        stackView.snp.makeConstraints { make in
            make.top.equalTo(totalCountLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(8)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(8)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    func configureView() {
        view.backgroundColor = .black
        navigationItem.title = viewModel.output.searchWord.value
        if let navigationBar = self.navigationController?.navigationBar {
            navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)
            ]
        }
        navigationController?.navigationBar.tintColor = .white
   
        
    }
    
    
}
