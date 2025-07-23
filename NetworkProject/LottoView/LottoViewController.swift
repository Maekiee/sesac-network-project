import UIKit
import SnapKit


class LottoViewController: UIViewController {
    
    let popbutton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .clear
        config.baseForegroundColor = .black
        config.image = UIImage(systemName: "chevron.left")
        button.configuration = config
        return button
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 8
        textField.borderStyle = .none
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        textField.inputView = UIPickerView()
        return textField
    }()
    
    let guideLabel: UILabel = {
        let label = UILabel()
        label.text = "당첨번호 안내"
        label.textColor = .black
        return label
    }()
//    
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
        label.text = "000회 당첨결과"
        label.textColor = .orange
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
  
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        for i in 1...8 {
            let circleLabel = CircleLabel()
            circleLabel.text = "\(i)"
            circleLabel.backgroundColor = .orange
            
            circleLabel.snp.makeConstraints { make in
                make.size.equalTo(40)
            }
            stackView.addArrangedSubview(circleLabel)
        }
        return stackView
    }()
    
    
    let circleLabel: CircleLabel = {
        let label = CircleLabel()
        for i in 1...8 {
            label.text = "\(i)"
            label.backgroundColor = .blue

        }
        
        return label
    }()
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
        
        popbutton.addTarget(self, action: #selector(pop), for: .touchUpInside)
    }
    
    @objc func pop() {
        dismiss(animated: true)
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
        view.addSubview(circleLabel)
        view.addSubview(stackView)
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
//            make.horizontalEdges.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }
        
        
        
    }
    
    func configureView() {
        view.backgroundColor = .white
    }
    
    
}
