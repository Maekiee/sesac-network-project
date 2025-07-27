import Foundation

protocol NetworkProtocol {
    func fetchShoppingData(searchWord: String,
                           sortCase: ShoppingSortCase,
                           completion: @escaping (Result<ShoppingPage, Error>) -> Void)
}
