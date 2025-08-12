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
                isShow.value = true
            } else {
                outputSearchText.value = searchWord
            }
        }
        
    }
        
    
    
    
}
