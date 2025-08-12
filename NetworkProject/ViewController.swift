import UIKit
import SnapKit


class ViewController: UIViewController {
    
    let goLottobutton: BasicButton = {
        let button = BasicButton(
            title: "go Lotto"
        )
        return button
    }()
    let goMovieButton: BasicButton = {
        let button = BasicButton(
            title: "Go Movie"
        )
        return button
    }()
    let goShoppingButton: BasicButton = {
        let button = BasicButton(
            title: "Go Shopping"
        )
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print("뷰컨 로드됨'")
        configuUI()
        configLayout()
        
        goLottobutton.addTarget(self, action: #selector(goLottoScreen), for: .touchUpInside)
        goMovieButton.addTarget(self, action: #selector(goMovieScreen), for: .touchUpInside)
        goShoppingButton.addTarget(self, action: #selector(goShoppingScreen), for: .touchUpInside)
    }
    
    func configuUI() {
        view.addSubview(goLottobutton)
        view.addSubview(goMovieButton)
        view.addSubview(goShoppingButton)
    }
    
    func configLayout() {
        goLottobutton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(44)
        }
        
        goMovieButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(goLottobutton.snp.bottom).offset(20)
            make.height.equalTo(44)
            
        }
        
        goShoppingButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(goMovieButton.snp.bottom).offset(20)
            make.height.equalTo(44)
        }
    }
    
    @objc func goLottoScreen() {
        print(#function)
        let vc = LottoViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @objc func goMovieScreen() {
        print(#function)
        let vc = MovieViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @objc func goShoppingScreen() {
        print(#function)
        
        let vc = ShoppingSearchViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

