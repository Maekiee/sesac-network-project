import Foundation

class ShoppingSearchViewModel {
    
    var inputSearchText: Observable<String?> = Observable(nil)
    var outputSearchText: Observable<String> = Observable("")
    var isShow: Observable<Bool> = Observable(false)
    
    init() {
        
        inputSearchText.bind { [weak self] value in
            guard let self = self else { return }
            guard let searchWord = value else { return }
            if searchWord.count < 2 {
                // 얼럿 띄울 수 있게 뭔가 해야됨
                isShow.value = true
            } else {
                outputSearchText.value = searchWord
            }
        }
        
    }
        
    
    
    
}
