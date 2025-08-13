import Foundation

class ShoppingSearchViewModel {
    var input: Input
    var output: Output
    
    
    struct Input {
        var searchText: Observable<String?> = Observable(nil)
    }
    
    struct Output {
        var alertTripper: Observable<Void> = Observable(())
        var searchText: Observable<String> = Observable("")
    }
    
    
    
    
    init() {
        input = Input()
        output = Output()
        
        input.searchText.bind { [weak self] value in
            guard let self = self else { return }
            guard let searchWord = value else { return }
            if searchWord.count < 2 {
                output.alertTripper.value = ()
            } else {
                output.searchText.value = searchWord
            }
        }
        
    }
        
    
    
    
}
