import UIKit

extension UIViewController {
    
    
    func showAlert(tip message: String) {
        let alertController = UIAlertController(title: "오류", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
//    func showAlert(title: String, message: String, ok: String, okHandler: @escaping () -> Void) {
//        print("==========1=============")
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        
//        let cancel = UIAlertAction(title: "취소", style: .cancel)
//        let ok = UIAlertAction(title: "저장", style: .default) { _ in
//            okHandler()
//            print("==========3=============")
//        }
//        
//        
//        alert.addAction(ok)
//        alert.addAction(cancel)
//        
//        self.present(alert, animated: true)
//        print("==========2=============")
//    }
//    
    
}
