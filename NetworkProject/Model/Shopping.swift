import Foundation
import Kingfisher


struct ShoppingPage: Decodable {
    let total: Int
    let start: Int
    let display: Int
    let items: [Product]
    
    var convertTotal: String {
        NumberFormat.shared.formatNum(from: total)
    }
}

struct Product: Decodable {
    let image: String
    let mallName: String
    let title: String
    let lprice: String
    
    
    var pureTitle: String {
//        title.removeHtml
        title.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
    }
    var imageURL: URL {
        URL(string: image)!
    }
    var price: String {
        NumberFormat.shared.formatStringToNum(stringFrom: lprice)
    }
}
