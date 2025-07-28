import Foundation
import Kingfisher

struct ProductViewModel{
    let imageUrl: URL
    let brandName: String
    let title: String
    let price: String
    
    init(product: Product) {
        self.imageUrl = URL(string: product.image)!
        self.brandName = product.mallName
        self.title = product.title.removeHtml
        self.price = NumberFormat.shared.formatStringToNum(stringFrom: product.lprice)
    }
}

