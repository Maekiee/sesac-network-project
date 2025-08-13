import Foundation
import Alamofire

enum NetworkRouter {
    case list(word: String, filterCase: ShoppingFilterType, startPoint: Int)
    
    var baseURL: String {
        return "https://openapi.naver.com/"
    }
    
    var endpoint: URL {
        switch self {
        case .list(word: let word, filterCase: let filterCase, startPoint: let startPoint):
            URL(string: baseURL + "v1/search/shop.json?query=\(word)&sort=\(filterCase)&start=\(startPoint)&display=20")!
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var header: HTTPHeaders {
        return [
            "X-Naver-Client-Id": APIKey.naverId,
            "X-Naver-Client-Secret": APIKey.naverSecret
        ]
    }
}
