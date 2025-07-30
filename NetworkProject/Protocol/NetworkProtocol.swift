import Foundation

protocol NetworkProtocol {
    func getShoppingData(searchWord: String,
                         sortCase: ShoppingSortCase,
                         count: Int,
                         completion: @escaping (Result<ShoppingPage, Error>) -> Void)
    
}
