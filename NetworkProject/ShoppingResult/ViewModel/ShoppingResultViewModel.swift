import Foundation

class ShoppingResultViewModel {
    
    var inputDidLoadTrigger: Observable<Void?> = Observable(nil)
    var inputCategory: Observable<ShoppingSortCase> = Observable(.sim)
    
    
    var outputTotalcountText: Observable<String> = Observable("")
    var outputSearchWord: Observable<String?> = Observable(nil)
    var outputProductList: Observable<[Product]> = Observable([])
    
    var outputCategory: Observable<ShoppingSortCase?> = Observable(nil)
    
    init() {
       
        inputDidLoadTrigger.lazyBind { [weak self] value in
            guard let self = self else { return }
            print("초기 실행")
            fetchShoppingData()
        }
        
        inputCategory.lazyBind { [weak self] value in
            guard let self = self else { return }
            fetchShoppingData()
            print("뷰모델 실행")
        }
        
    }
    
    private func fetchShoppingData() {
        guard let searchValue = self.outputSearchWord.value else { return }
        let category = self.inputCategory.value
        
        NetworkManager.shared.getShoppingData(searchWord: searchValue, sortCase: category) { resultValue in
            switch resultValue {
            case .success(let value):
                self.outputProductList.value = value.items
                self.outputTotalcountText.value = "\(NumberFormat.shared.formatNum(from: value.total)) 개의 검색 결과"
                //                self.listCount = value.items.count // 페이지 네이션
                //                self.totalCount = value.total // 페이지 네이션
            case .failure(let error):
                //                self.showAlert(tip: "상품 초기에서 에러")
                print("에러입니다.: \(error)")
            }
        }
    }
    
}
