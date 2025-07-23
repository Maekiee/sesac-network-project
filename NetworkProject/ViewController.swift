import UIKit
import SnapKit


class ViewController: UIViewController {
    
    let goLottobutton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.title = "Go Lotto"
        config.baseBackgroundColor = .orange
        config.baseForegroundColor = .white
        button.configuration = config
        return button
    }()
    
    let goMovieButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.title = "Go Movie"
        config.baseBackgroundColor = .black
        config.baseForegroundColor = .white
        button.configuration = config
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuUI()
        configLayout()
        
        goLottobutton.addTarget(self, action: #selector(goLottoScreen), for: .touchUpInside)
        goMovieButton.addTarget(self, action: #selector(goMovieScreen), for: .touchUpInside)
    }
    
    func configuUI() {
        view.addSubview(goLottobutton)
        view.addSubview(goMovieButton)
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
    }
    
    @objc func goLottoScreen() {
        print(#function)
    }
    
    @objc func goMovieScreen() {
        print(#function)
        
    }
}

