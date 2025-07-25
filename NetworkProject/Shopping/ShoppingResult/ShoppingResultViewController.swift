import UIKit

class ShoppingResultViewController: UIViewController {
    var searchWord: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
    }

}



extension ShoppingResultViewController: ViewdesignProtocol {
    func configureHierarchy() {
    }
    
    func configureLayout() {
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
