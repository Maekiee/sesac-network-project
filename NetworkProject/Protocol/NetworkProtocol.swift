import Foundation

protocol NetworkProtocol {
    func getShoppingData(searchWord: String,
                         sortCase: ShoppingSortCase,
                         count: Int,
                         completion: @escaping (ShoppingPage) -> Void,
                         errorHandler: @escaping (Error) -> Void)
    
}
