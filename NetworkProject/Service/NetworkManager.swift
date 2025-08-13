import Foundation
import Alamofire

class NetworkManager: NetworkProtocol {
    static let shared = NetworkManager()

    private init() { }
    
    
    func getSearchShoppingData<T: Decodable>(api: NetworkRouter, type: T.Type, completion: @escaping (T) -> Void) {
        AF.request(
            api.endpoint,
            method: api.method,
            headers: api.header
        ).responseDecodable(of: T.self) { res in
            switch res.result {
            case .success(let value):
                completion(value)
            case .failure(let error):
                print("네트워크 통신 에러: \(error)")
            }
        }
    }
    
    
//    func getShoppingData(searchWord: String,
//                         sortCase: ShoppingFilterType,
//                         count: Int = 1,
//                         completion: @escaping (Result<ShoppingPage, Error>) -> Void
//    ) {
//        let url = "https://openapi.naver.com/v1/search/shop.json?query=\(searchWord)&sort=\(sortCase)&start=\(count)&display=100"
//        let header: HTTPHeaders = [
//            "X-Naver-Client-Id": APIKey.naverId,
//            "X-Naver-Client-Secret": APIKey.naverSecret
//        ]
//        AF.request(url,
//                   method: .get,
//                   headers: header)
//            .responseDecodable(of: ShoppingPage.self) { res in
//                switch res.result {
//                case .success(let value):
//                    completion(.success(value))
//                case .failure(let error): //400 {}
//                    completion(.failure(error))
//                }
//            }
//    }
    
    
    
    // 추천 쇼핑
//    func getRecommandShoppingData(completion: @escaping (Result<ShoppingPage, Error>) -> Void) {
//        let url = "https://openapi.naver.com/v1/search/shop.json?query=f1차&sort=sim&start=1&display=10"
//        let header: HTTPHeaders = [
//            "X-Naver-Client-Id": APIKey.naverId,
//            "X-Naver-Client-Secret": APIKey.naverSecret
//        ]
//        AF.request(url, method: .get, headers: header)
//            .responseDecodable(of: ShoppingPage.self) { res in
//                switch res.result {
//                case .success(let value):
//                    completion(.success(value))
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
//    }
}
