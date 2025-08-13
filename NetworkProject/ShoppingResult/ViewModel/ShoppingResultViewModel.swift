import Foundation

class ShoppingResultViewModel {
    var input: Input
    var output: Output
    
    struct Input {
        var didLoadTrigger: Observable<Void?> = Observable(nil)
        var selectedCategory: Observable<ShoppingFilterType> = Observable(.sim)
        var pagingTrigger: Observable<Void> = Observable(())
        var startPoint: Observable<Int> = Observable(1)
    }
    
    struct Output {
        var totalCountText: Observable<String> = Observable("")
        var searchWord: Observable<String?> = Observable(nil)
        var productList: Observable<[Product]> = Observable([])
        var selectedCategory: Observable<ShoppingFilterType?> = Observable(nil)
        var totalCount: Observable<Int> = Observable(0)
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
            fetchShoppingData(isReset: true)
        }
        
        input.pagingTrigger.lazyBind { [weak self] value in
            guard let self = self else { return }
            fetchShoppingData()
        }
        
    }
    
    private func fetchShoppingData(isReset: Bool = false) {
        guard let searchValue = self.output.searchWord.value else { return }
        let category = self.input.selectedCategory.value
        let count = self.input.startPoint.value
        
        NetworkManager.shared.getSearchShoppingData(
            api: .list(word: searchValue,filterCase: category, startPoint: count),
            type: ShoppingPage.self) { resultValue in
                if isReset {
                    self.output.productList.value = resultValue.items
                } else {
                    self.output.productList.value.append(contentsOf: resultValue.items)
                }
//
                
                self.output.totalCountText.value = "\(resultValue.convertTotal) 개의 검색 결과"
                self.output.totalCount.value = resultValue.total
            }
    }
    
}
