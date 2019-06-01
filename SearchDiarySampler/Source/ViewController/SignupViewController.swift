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
        
        viewModel?.isSignup.subscribe({ [weak self] event in
            guard let self = self , let element = event.element else { return }
            if element {
                // ここ、Driver使ってないのいにアラートが表示されたの謎.
                let alert = UIAlertController(title: "登録まであと少しです。", message: "認証メールアドレスを送信しました。確認をお願いします。", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }).disposed(by: disposeBag)
        viewModel?.isSignup.bind(to: registerButton.rx.isEnabled).disposed(by: disposeBag)
    }
}

extension SignupViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
