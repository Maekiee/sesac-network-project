import Foundation
import Alamofire
class NetworkManager: NetworkProtocol {
    static let shared = NetworkManager()
    
    private init() { }
    
    
    func getShoppingData(searchWord: String,
                         sortCase: ShoppingSortCase,
                         count: Int = 1,
                         completion: @escaping (ShoppingPage) -> Void,
                         errorHandler: @escaping (any Error) -> Void) {
        let url = "https://openapi.naver.com/v1/search/shop.json?query=\(searchWord)&sort=\(sortCase)&start=\(count)&display=30"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": "ev3bgbRZgCPjAqHmpFk_",
            "X-Naver-Client-Secret": "QfglBffT1m"
        ]
        AF.request(url, method: .get, headers: header)
            .responseDecodable(of: ShoppingPage.self) { res in
                switch res.result {
                case .success(let value):
                    completion(value)
                case .failure(let error):
                    errorHandler(error)
                }
            }
        
    }
    
}
