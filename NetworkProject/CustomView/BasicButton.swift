import UIKit

class BasicButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init (title: String) {
        super.init(frame: .zero)
        var config = UIButton.Configuration.filled()
        config.title = title
        config.baseBackgroundColor = .black
        config.baseForegroundColor = .white
        self.configuration = config
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
