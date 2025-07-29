import Foundation

class NumberFormat {
    static let shared = NumberFormat()
    
    private init() { }
    
    let format = {
        let numFormatter = NumberFormatter()
        numFormatter.numberStyle = .decimal
        return numFormatter
    }()
    
    
    func formatNum(from: Int) -> String {
        return format.string(from: NSNumber(value: from))!
    }
    
    func formatStringToNum(stringFrom: String) -> String {
        let intPrice = Int(stringFrom)
        return format.string(from: NSNumber(value: intPrice!))!
    }
}
