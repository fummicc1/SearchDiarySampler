import UIKit
import RxCocoa
import RxSwift

class AddDiaryViewController: UIViewController {

    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var contentTextView: UITextView!
    @IBOutlet private weak var switchCategoryButton: UISwitch!
    @IBOutlet private weak var postDiaryButton: UIButton!
    @IBOutlet private weak var backButton: UIBarButtonItem!
    @IBOutlet private weak var inputStateLabel: UILabel!
    
    private var viewModel: AddDiaryViewModel?
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.rx.tap.subscribe { [unowned self] _ in
            self.dismiss(animated: true, completion: nil)
        }.disposed(by: disposeBag)
        
        let input = AddDiaryViewModel.Input(
            tappedPostDiaryButton: postDiaryButton.rx.tap.asObservable(),
            titleEdited: titleTextField.rx.text.orEmpty.asObservable(),
            switchedOpenRange: switchCategoryButton.rx.isOn
                .asObservable()
                .map({$0 ? Entity.Diary.Category.privateDiary : Entity.Diary.Category.publicDiary}),
            contentEdited: contentTextView.rx.text.orEmpty.asObservable())
        viewModel = AddDiaryViewModel(input: input)
        viewModel?.output.imCompletedInput.map({$0.rawValue}).bind(to: inputStateLabel.rx.text).disposed(by: disposeBag)
        viewModel?.output.isPersisting.bind(to: postDiaryButton.rx.isEnabled).disposed(by: disposeBag)
        viewModel?.output.isPersisting.subscribe({ [unowned self] event in
            guard let element = event.element, element else { return }
            let alert = UIAlertController(
                title: "投稿完了！", message: "", preferredStyle: .alert)
            alert.addAction(
                UIAlertAction(
                    title: "OK", style: .default, handler: { action in
                        self.dismiss(animated: true, completion: nil)
                }))
            self.present(alert, animated: true, completion: nil)
        }).disposed(by: disposeBag)
    }
}
