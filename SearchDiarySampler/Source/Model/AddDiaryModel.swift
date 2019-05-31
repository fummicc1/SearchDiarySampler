import Foundation
import RxSwift
import RxCocoa
import Firebase

final class AddDiaryModel {
    
    func persistDiary(diary: Entity.Diary) -> Single<Bool> {
        return Single.create(subscribe: { singleEvent -> Disposable in
            let data = diary.getDictionary()
            Firestore.firestore().collection("diaries").document().setData(data) { error in
                if let error = error {
                    singleEvent(.error(FirebaseAPIError.other(error: error)))
                    return
                }
                singleEvent(.success(true))
            }
            return Disposables.create()
        })
    }
    
}
