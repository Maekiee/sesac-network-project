import Foundation

class NumberFormat {
    static let shared = NumberFormat()
    
    private init() { }
    
    func formatNum(from: Int) -> String {
        let numFormatter = NumberFormatter()
        numFormatter.numberStyle = .decimal
        return numFormatter.string(from: NSNumber(value: from))!
    }
    
    func formatStringToNum(stringFrom: String) -> String {
        let intPrice = Int(stringFrom)
        let numFormatter = NumberFormatter()
        numFormatter.numberStyle = .decimal
        return numFormatter.string(from: NSNumber(value: intPrice!))!
    }
}
