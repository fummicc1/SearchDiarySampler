import Foundation
import RxSwift
import RxCocoa
import Firebase

enum FirebaseAPIError: Error {
    case noAuthData
    case failedRegistration
    case failedSendEmail
    case noCurrentUserExists
    case noDocumentData
    case other(error: Error)
}

class UserManager {
    static let shared: UserManager = UserManager()
    private init() {
        loadMe()
    }
    
    private let meRelay: BehaviorRelay<Entity.User?> = BehaviorRelay(value: nil)
    var me: Entity.User? {
        return meRelay.value
    }
    
    func loadMe() {
        guard let currentUser = Auth.auth().currentUser else {
            fatalError("\(FirebaseAPIError.noCurrentUserExists)")
        }
        Firestore.firestore().collection("users").document(currentUser.uid).addSnapshotListener({ [unowned self] (snapShot, error) in
            if let error = error {
                fatalError("\(FirebaseAPIError.other(error: error))")
            }
            guard let snapShot = snapShot, let data = snapShot.data() else {
                fatalError("\(FirebaseAPIError.noDocumentData)")
            }
            let user = Entity.User(data: data)
            self.meRelay.accept(user)
        })
    }
}
