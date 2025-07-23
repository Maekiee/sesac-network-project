import UIKit
import SnapKit

class MovieViewController: UIViewController {
    let tableView = UITableView()
    
    let textField: UITextField = {
        let textfield = UITextField()
        textfield.borderStyle = .none
        textfield.placeholder = "영화 제목을 입력하세요"
        return textfield
    }()
    
    let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        
        return view
    }()
    
    let submitbutton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.title = "검색"
        config.baseForegroundColor = .white
        config.baseBackgroundColor = .black
        button.configuration = config
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        return stackView
    }()
    
    let list = MovieInfo.movies
    var movieList: [Movie] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
        movieList = list

         
    }
    
    @objc func submitTapped() {
        view.endEditing(true)
        movieList.shuffle()
        print(#function)
    }

}

extension MovieViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        movieList.shuffle()
        view.endEditing(true)
        return true
    }
}


extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
        
        let row = movieList[indexPath.row]
        
        cell.configCellData(row: row, index: indexPath.row)
        return cell
    }
    
    
}


extension MovieViewController: ViewdesignProtocol {
    func configureHierarchy() {

        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(submitbutton)
        view.addSubview(stackView)
        
        view.addSubview(dividerView)
        view.addSubview(tableView)
    }
    
    func configureLayout() {
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        submitbutton.snp.makeConstraints { make in
            make.width.equalTo(64)
            make.height.equalTo(44)
        }
        
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(1)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(8)
        }
    }
    
    func configureView() {
        view.backgroundColor = .white
        tableView.rowHeight = 60
        tableView.delegate = self
        tableView.dataSource = self
        textField.delegate = self
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        submitbutton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
    }
    
    
}
