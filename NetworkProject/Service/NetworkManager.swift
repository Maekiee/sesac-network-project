import Foundation
import Alamofire

class NetworkManager: NetworkProtocol {
    static let shared = NetworkManager()

    private init() { }
    
    
    
    func getShoppingData(searchWord: String,
                         sortCase: ShoppingSortCase,
                         count: Int = 1,
                         completion: @escaping (Result<ShoppingPage, Error>) -> Void
    ) {
        let url = "https://openapi.naver.com/v1/search/shop.json?query=\(searchWord)&sort=\(sortCase)&start=\(count)&display=100"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.naverId,
            "X-Naver-Client-Secret": APIKey.naverSecret
        ]
        AF.request(url, method: .get, headers: header)
            .responseDecodable(of: ShoppingPage.self) { res in
                switch res.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error): //400 {}
                    completion(.failure(error))
                }
            }
    }
    
    func getRecommandShoppingData(completion: @escaping (Result<ShoppingPage, Error>) -> Void) {
        let url = "https://openapi.naver.com/v1/search/shop.json?query=f1차&sort=sim&start=1&display=10"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.naverId,
            "X-Naver-Client-Secret": APIKey.naverSecret
        ]
        AF.request(url, method: .get, headers: header)
            .responseDecodable(of: ShoppingPage.self) { res in
                switch res.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
