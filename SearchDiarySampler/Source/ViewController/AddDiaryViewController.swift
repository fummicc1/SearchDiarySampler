import UIKit
import RxCocoa
import RxSwift

class AddDiaryViewController: UIViewController {

    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var contentTextView: UITextView!
    @IBOutlet private weak var switchCategoryButton: UISwitch!
    @IBOutlet private weak var postDiaryButton: UIButton!
    @IBOutlet private weak var backButton: UIBarButtonItem!
    
    private var viewModel: AddDiaryViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()        
    }
}
