import UIKit
import RxSwift
import RxCocoa

class SignupViewController: UIViewController {
    
    @IBOutlet private weak var emailTextField: UITextField! {
        didSet {
            emailTextField.delegate = self
        }
    }
    @IBOutlet private weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.delegate = self
        }
    }
    @IBOutlet private weak var repeatedPasswordTextField: UITextField! {
        didSet {
            repeatedPasswordTextField.delegate = self
        }
    }
    @IBOutlet private weak var registerButton: UIButton!
    
    private let disposeBag = DisposeBag()
    private var viewModel: SignupViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SignupViewModel(
            email: emailTextField.rx.text.orEmpty.asObservable(),
            password: passwordTextField.rx.text.orEmpty.asObservable(),
            repeatedPassword: repeatedPasswordTextField.rx.text.orEmpty.asObservable(),
            registerButtonClicked: registerButton.rx.tap.asObservable()
        )
        
        viewModel?.canClickRegisterButton.subscribe({ [weak self] (event) in
            let value = event.element ?? false
            self?.registerButton.alpha = value ? 1.0 : 0.5
            self?.registerButton.isEnabled = value
        }).disposed(by: disposeBag)
    }
}

extension SignupViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
