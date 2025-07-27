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
        self.price = ProductViewModel.formatPrice(product.lprice)
    }
    
    private static func formatPrice(_ text: String) -> String {
        let intPrice = Int(text)
        let numFormatter = NumberFormatter()
        numFormatter.numberStyle = .decimal
        return numFormatter.string(from: NSNumber(value: intPrice!))!
    }
}

