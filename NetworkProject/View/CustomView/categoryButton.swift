import UIKit


class CategoryButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init (title: String) {
        super.init(frame: .zero)
        var config = UIButton.Configuration.filled()
        config.title = title
        config.baseBackgroundColor = .clear
        config.baseForegroundColor = .white
        config.background.cornerRadius = 8
        config.background.strokeColor = .white
        config.background.strokeWidth = 1
        self.configuration = config
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

