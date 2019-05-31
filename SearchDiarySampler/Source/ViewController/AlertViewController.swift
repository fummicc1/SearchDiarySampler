import UIKit
import RxSwift
import RxCocoa

class AlertViewController: UIViewController {

    @IBOutlet private weak var openGmailButton: UIButton!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openGmailButton.rx.tap.subscribe { event in
            guard let url = URL(string: "googlegmail://") else { return }
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }.disposed(by: disposeBag)
    }
}
