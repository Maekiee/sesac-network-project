import Foundation
import Kingfisher


struct ShoppingPage: Decodable {
    let total: Int
    let start: Int
    let display: Int
    let items: [Product]
}

struct Product: Decodable {
    let image: String
    let mallName: String
    let title: String
    let lprice: String
    
    var imageURL: URL {
        URL(string: image)!
    }
    var price: String {
        NumberFormat.shared.formatStringToNum(stringFrom: lprice)
    }
}
