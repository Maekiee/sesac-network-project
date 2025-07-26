import Foundation

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
}
