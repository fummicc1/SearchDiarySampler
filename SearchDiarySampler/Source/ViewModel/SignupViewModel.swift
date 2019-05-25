import Foundation
import Firebase
import RxSwift
import RxCocoa

final class SignupViewModel {
    
    private let model: SignupModel
    
    private let disposeBag = DisposeBag()
    private let userModel = BehaviorRelay<User?>(value: nil)
    private let email: Observable<String>
    private let password: Observable<String>
    private let repeatedPassword: Observable<String>
    let canClickRegisterButton: Observable<Bool>
    var user: User? {
        return userModel.value
    }
    
    init(
        model: SignupModel = SignupModel(),
        email: Observable<String>,
        password: Observable<String>,
        repeatedPassword: Observable<String>,
        registerButtonClicked: Observable<Void>
        ) {
        self.model = model
        self.email = email
        self.password = password
        self.repeatedPassword = repeatedPassword
        
        canClickRegisterButton = Observable.combineLatest(password, repeatedPassword).map { (password, repeatedPassword) -> Bool in
            return password == repeatedPassword && password.count > 5
        }
    }
}
