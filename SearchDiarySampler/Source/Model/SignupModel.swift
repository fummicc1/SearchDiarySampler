import Foundation
import Firebase
import RxCocoa
import RxSwift

final class SignupModel {
    
    enum AuthError: Error {
        case noData
        case failedRegistration
        case failedSendEmail
    }
    
    func singup(email: String, password: String) -> Single<User> {
        return Single.create(subscribe: { (singleEvent) -> Disposable in
            Auth.auth().signIn(withEmail: email, password: password, completion: { (result, error) in
                if error != nil {
                    singleEvent(.error(AuthError.failedRegistration))
                    return
                }
                guard let result = result else {
                    singleEvent(.error(AuthError.noData))
                    return
                }
                result.user.sendEmailVerification(completion: { (error) in
                    if error != nil {
                        singleEvent(.error(AuthError.failedSendEmail))
                        return
                    }
                    singleEvent(.success(result.user))
                })
            })
            return Disposables.create()
        })
    }
}
