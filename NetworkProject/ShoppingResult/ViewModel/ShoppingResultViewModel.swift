import Foundation

class ShoppingResultViewModel {
    var input: Input
    var output: Output
    
    struct Input {
        var didLoadTrigger: Observable<Void?> = Observable(nil)
        var selectedCategory: Observable<ShoppingFilterType> = Observable(.sim)
    }
    
    struct Output {
        var totalCountText: Observable<String> = Observable("")
        var searchWord: Observable<String?> = Observable(nil)
        var productList: Observable<[Product]> = Observable([])
        var selectedCategory: Observable<ShoppingFilterType?> = Observable(nil)
    }
    
    
    
    init() {
        input = Input()
        output = Output()
       
        input.didLoadTrigger.lazyBind { [weak self] value in
            guard let self = self else { return }
            print("초기 실행")
            fetchShoppingData()
        }
        
        input.selectedCategory.lazyBind { [weak self] value in
            guard let self = self else { return }
            fetchShoppingData()
            
            print("뷰모델 실행")
        }
        
    }
    
    private func fetchShoppingData() {
        guard let searchValue = self.output.searchWord.value else { return }
        let category = self.input.selectedCategory.value
        
        
        
        NetworkManager.shared.getSearchShoppingData(api: .list(word: searchValue, filterCase: category, startPoint: 1), type: ShoppingPage.self) { resultValue in
            self.output.productList.value = resultValue.items
            self.output.totalCountText.value = "\(resultValue.convertTotal) 개의 검색 결과"
        }
    }
    
}
