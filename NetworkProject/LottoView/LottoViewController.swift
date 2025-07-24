import UIKit
import SnapKit
import Alamofire

class LottoViewController: UIViewController {
    
    let LottoEpisodeNumber: [Int] = Array(1...1181).reversed()
    
    var drwNumbers: [Int] = []
    
    let popbutton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .clear
        config.baseForegroundColor = .black
        config.image = UIImage(systemName: "chevron.left")
        button.configuration = config
        return button
    }()
    let pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    let toolBar: UIToolbar = {
        let toolBar = UIToolbar()
        toolBar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44)
        return toolBar
    }()
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 8
        textField.borderStyle = .none
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        textField.inputView = pickerView
        textField.inputAccessoryView = toolBar

        return textField
    }()
    let guideLabel: UILabel = {
        let label = UILabel()
        label.text = "당첨번호 안내"
        label.textColor = .black
        return label
    }()
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2020-06-01 추첨"
        label.textColor = .gray
        return label
    }()
    let horizontalDividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "1181회 당첨결과"
        label.textColor = .orange
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    let bonusLable: UILabel = {
        let label = UILabel()
        label.text = "보너스"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
        
        setupToolBar()
        popbutton.addTarget(self, action: #selector(pop), for: .touchUpInside)
        getLottoInfo()
    
    }
    
    private func addLabelToStackView() {
        let plusIndex = drwNumbers.count - 1
        drwNumbers.insert(0, at: plusIndex)
        for i in drwNumbers {
            let circleLabel = CircleLabel()
            if i == 0 {
                circleLabel.text = "+"
                circleLabel.textColor = .black
            } else {
                circleLabel.text = "\(i)"
                switch i {
                case 1...10:
                    circleLabel.backgroundColor = .orange
                case 11...20:
                    circleLabel.backgroundColor = .red
                case 21...30:
                    circleLabel.backgroundColor = .systemIndigo
                case 31...40:
                    circleLabel.backgroundColor = .systemGreen
                case 41...45:
                    circleLabel.backgroundColor = .systemPurple
                default:
                    circleLabel.backgroundColor = .gray
                }
            }
            
            circleLabel.snp.makeConstraints { make in
                make.size.equalTo(40)
            }
            stackView.addArrangedSubview(circleLabel)
        }
    }
    
    private func getLottoInfo(turningCount: String = "1181") {
        stackView.arrangedSubviews.forEach { view in
            stackView.removeArrangedSubview(view)
            view.removeFromSuperview()
            drwNumbers = []
        }
        let lottoApiUrl: String = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(turningCount)"
        
        AF.request(lottoApiUrl, method: .get)
            .responseDecodable(of: Lotto.self) { res in
                switch res.result {
                case .success(let value):
                    self.drwNumbers.append(value.drwtNo1)
                    self.drwNumbers.append(value.drwtNo2)
                    self.drwNumbers.append(value.drwtNo3)
                    self.drwNumbers.append(value.drwtNo4)
                    self.drwNumbers.append(value.drwtNo5)
                    self.drwNumbers.append(value.drwtNo6)
                    self.drwNumbers.append(value.bnusNo)
                    self.dateLabel.text = "\(value.drwNoDate) 추첨"
                    self.addLabelToStackView()
                case .failure(let error):
                    print("에러", error)
                }
            }
    }
    
    private func setupToolBar() {
        let doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(colsedPickerView))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
    }
    
    @objc func pop() {
        dismiss(animated: true)
    }
    
    @objc func colsedPickerView() {
        view.endEditing(true)
    }
}



// MARK: 피커뷰
extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    // 가로 아이템 몇개인지
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    // 세로 아이템 몇개인지
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return LottoEpisodeNumber.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(#function)
        titleLabel.text = "\(row+1) 당첨결과"
        textField.text = String(row+1) // 텍스트 필드에 보여질 회차 텍스트
        guard let turningCount = textField.text else { return }
        getLottoInfo(turningCount: turningCount)
    }
    
    // 픽커뷰에 보여질 데이터
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row + 1) 회차"
    }
    
    
  
}



extension LottoViewController: ViewdesignProtocol {
    func configureHierarchy() {
        view.addSubview(popbutton)
        view.addSubview(textField)
        view.addSubview(guideLabel)
        view.addSubview(dateLabel)
        view.addSubview(horizontalDividerView)
        view.addSubview(titleLabel)
        view.addSubview(stackView)
        view.addSubview(bonusLable)
    }
    
    func configureLayout() {
        popbutton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().inset(10)
        }
        
        textField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(popbutton.snp.bottom).offset(20)
            make.height.equalTo(44)
        }
        
        guideLabel.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
        }
//
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(20)
            make.trailing.equalTo(view.safeAreaInsets).inset(20)
        }
        
        horizontalDividerView.snp.makeConstraints { make in
            make.top.equalTo(guideLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(horizontalDividerView.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(28)
            make.centerX.equalToSuperview()
        }
        
        bonusLable.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(4)
            make.trailing.equalToSuperview().inset(27)
        }
        
    }
    
    func configureView() {
        view.backgroundColor = .white
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.selectRow(1180, inComponent: 0, animated: false)
        textField.text = "1181"
    }
    
    
}
