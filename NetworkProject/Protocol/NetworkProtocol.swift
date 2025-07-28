import Foundation

protocol NetworkProtocol {
    func fetchShoppingData(searchWord: String,
                           sortCase: ShoppingSortCase,
                           count: Int,
                           completion: @escaping (Result<ShoppingPage, Error>) -> Void)
}
