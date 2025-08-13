import Foundation

class ShoppingResultViewModel {
    var input: Input
    var output: Output
    
    struct Input {
        var didLoadTrigger: Observable<Void?> = Observable(nil)
        var selectedCategory: Observable<ShoppingSortCase> = Observable(.sim)
    }
    
    struct Output {
        var totalCountText: Observable<String> = Observable("")
        var searchWord: Observable<String?> = Observable(nil)
        var productList: Observable<[Product]> = Observable([])
        var selectedCategory: Observable<ShoppingSortCase?> = Observable(nil)
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
        
        NetworkManager.shared.getShoppingData(searchWord: searchValue, sortCase: category) { resultValue in
            switch resultValue {
            case .success(let value):
                self.output.productList.value = value.items
                self.output.totalCountText.value = "\(NumberFormat.shared.formatNum(from: value.total)) 개의 검색 결과"
                //                self.listCount = value.items.count // 페이지 네이션
                //                self.totalCount = value.total // 페이지 네이션
            case .failure(let error):
                //                self.showAlert(tip: "상품 초기에서 에러")
                print("에러입니다.: \(error)")
            }
        }
    }
    
}
