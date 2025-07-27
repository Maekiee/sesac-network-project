import UIKit


class CategoryButton: UIButton {
    // ShoppingSortCase 말고 여러 열거형 값 받을 수 있게 변경
    var buttonTag = ShoppingSortCase.sim
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init (title: String, caseTag: ShoppingSortCase = ShoppingSortCase.sim, backgroundColor: UIColor = UIColor.clear) {
        super.init(frame: .zero)
        var config = UIButton.Configuration.filled()
        var attributedTitle = AttributedString(title)
        buttonTag = caseTag
        attributedTitle.font = .systemFont(ofSize: 13)
        config.baseBackgroundColor = .clear
        config.baseForegroundColor = .white
        config.background.cornerRadius = 8
        config.background.strokeColor = .white
        config.background.strokeWidth = 1
        config.titleAlignment = .center
        config.attributedTitle = attributedTitle
        self.configuration = config
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

