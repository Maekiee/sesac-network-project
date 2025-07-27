import Foundation
import Kingfisher

struct ProductViewModel{
    let imageUrl: URL
    let brandName: String
    let title: String // 테그 제거해야됨
    let price: String // 넘버 포맷으로 콤마 붙이기
    
    init(product: Product) {
        self.imageUrl = URL(string: product.image)!
        self.brandName = product.mallName
        self.title = product.title
        self.price = product.lprice
    }
}
