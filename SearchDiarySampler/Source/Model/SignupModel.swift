import Foundation
import Firebase
import RxCocoa
import RxSwift

final class SignupModel {
    
    func singup(email: String, password: String) -> Single<User> {
        return Single.create(subscribe: { (singleEvent) -> Disposable in
            Auth.auth().createUser(withEmail: email, password: password, completion: { (result, error) in
                if error != nil {
                    singleEvent(.error(FirebaseAPIError.failedRegistration))
                    return
                }
                guard let result = result else {
                    singleEvent(.error(FirebaseAPIError.noAuthData))
                    return
                }
                result.user.sendEmailVerification(completion: { (error) in
                    if error != nil {
                        singleEvent(.error(FirebaseAPIError.failedSendEmail))
                        return
                    }
                    
                    singleEvent(.success(result.user))
                })
            })
            return Disposables.create()
        })
    }
}
