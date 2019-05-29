import Foundation
import RxSwift
import RxCocoa
import Firebase

final class DiaryListModel {
    
    func downloadAllDiaries(completion: @escaping ([Entity.Diary]) -> ()) {
        Firestore.firestore().collection("diaries").getDocuments(completion: { (snapShots, error) in
            if let error = error {
                fatalError("\(error)")
            }
            guard let snapShots = snapShots else {
                fatalError("no snapShots!")
            }
            var diaryList: [Entity.Diary] = []
            for document in snapShots.documents {
                let diary = Entity.Diary(data: document.data())
                diaryList.append(diary)
            }
            completion(diaryList)
        })
    }
    
    func getDiaryDummies(completion: @escaping ([Entity.Diary]) -> ()) {
        completion((0...19).map({ _ in Entity.Diary.createDummy()}))
    }
}
