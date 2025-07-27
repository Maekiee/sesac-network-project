import Foundation
import Alamofire
class NetworkManager: NetworkProtocol {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    func fetchShoppingData(searchWord: String, sortCase: ShoppingSortCase, completion: @escaping (Result<ShoppingPage, Error>) -> Void) {
        let url = "https://openapi.naver.com/v1/search/shop.json?query=\(searchWord)&sort=\(sortCase)&display=30"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": "ev3bgbRZgCPjAqHmpFk_",
            "X-Naver-Client-Secret": "QfglBffT1m"
        ]
        AF.request(url, method: .get, headers: header)
            .responseDecodable(of: ShoppingPage.self) { res in
                switch res.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    print("에러: \(error)")
                    completion(.failure(error))
                }
            }
    }
    
}
