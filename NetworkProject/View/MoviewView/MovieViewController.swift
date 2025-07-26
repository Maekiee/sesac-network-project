import UIKit
import SnapKit
import Alamofire

class MovieViewController: UIViewController {
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 60
        tableView.delegate = self
        tableView.dataSource = self
        textField.delegate = self
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        return tableView
    }()
    let textField: UITextField = {
        let textfield = UITextField()
        textfield.borderStyle = .none
        textfield.placeholder = "날짜를 입력해 주세요"
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
    

    
    var movieList: [BoxOffice] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
        
        fetchMovieDate()
    }
    
    private func fetchMovieDate(inputValue: String? = nil) {
        let targetDate: String
        
        if let date = inputValue, !date.isEmpty {
            targetDate = date
            } else {
                // 어제 날짜
                guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else {
                    return
                }
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyyMMdd"
                formatter.locale = Locale(identifier: "ko_KR")
                targetDate = formatter.string(from: yesterday)
            }
        
        
        let apiUrl: String = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=87326d7892a79b81ae16230feed7ac72&targetDt=\(targetDate)"
        
        AF.request(apiUrl, method: .get)
            .responseDecodable(of: BoxOfficeResult.self) { res in
                switch res.result {
                case .success(let value):
                    self.movieList = value.boxOfficeResult.dailyBoxOfficeList
                case .failure(let error):
                    print("에러", error)
                }
            }
    }
    
    @objc func submitTapped() {
        view.endEditing(true)
        guard let inputValue = textField.text else { return }
        fetchMovieDate(inputValue: inputValue)
        print(#function)
    }

}



//MARK: - 텍스트필드
extension MovieViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)

        guard let inputValue = textField.text else { return true}
        fetchMovieDate(inputValue: inputValue)
        return true
    }
}



//MARK: - 테이블 뷰
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
        submitbutton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
    }
    
    
}
