import Foundation
import RxSwift
import RxCocoa
import FirebaseFirestore

final class AddDiaryViewModel {
    
    struct Input {
        let tappedPostDiaryButton: Observable<Void>
        let titleEdited: Observable<String>
        let senderUIDObservable: Observable<String>
        let contentEdited: Observable<String>
    }
    
    struct Output {
        let diaryRelay: PublishRelay<Entity.Diary> = PublishRelay()
    }
    
    let output: Output
    let model: AddDiaryModel
    
    init(
        model: AddDiaryModel = AddDiaryModel(),
        input: Input
        ) {
        self.model = model
        self.output = Output()
    }
}
