import Foundation
import Firebase
import RxSwift
import RxCocoa

final class SignupViewModel {
    
    // Model class
    private let model: SignupModel
    
    private let disposeBag = DisposeBag()
    
    private let email: Observable<String>
    private let password: Observable<String>
    private let repeatedPassword: Observable<String>
    let canClickRegisterButton: Observable<Bool>
    var isSignup: Observable<Bool> = Observable.just(false)
    
    private let userModel = PublishSubject<User?>()
    
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
        
        canClickRegisterButton = Observable
            .combineLatest(password, repeatedPassword)
            .map { (password, repeatedPassword) -> Bool in
                return password == repeatedPassword && password.count > 5
        }
        
        let emailAndPassword = Observable.combineLatest(email, password)
        let userEventObservable =
            registerButtonClicked
                .withLatestFrom(emailAndPassword)
                .flatMap { [weak self] (email, password) -> Observable<Event<User>>  in
                    guard let self = self else { return Observable.empty() }
                    return self.model.singup(email: email, password: password).asObservable().materialize()
                }
                .share()
        userEventObservable.map({$0.element}).bind(to: userModel).disposed(by: disposeBag)
        
        isSignup = userModel.map({$0 != nil}).share()
    }
}
