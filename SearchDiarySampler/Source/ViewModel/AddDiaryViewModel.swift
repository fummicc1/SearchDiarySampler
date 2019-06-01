import Foundation
import RxSwift
import RxCocoa
import Firebase

final class AddDiaryViewModel {
    
    enum ImCompletedInput: String, Equatable {
        case titleAndContent = "タイトルとコンテントが未入力です。"
        case title = "タイトルが未入力です。"
        case content = "コンテントが未入力です。"
        case nothing = "ぺきかん!"
    }
    
    struct Input {
        let tappedPostDiaryButton: Observable<Void>
        let titleEdited: Observable<String>
        let switchedOpenRange: Observable<Entity.Diary.Category>
        let contentEdited: Observable<String>
    }
    
    struct Output {
        let imCompletedInput: Observable<ImCompletedInput>
        let isPersisting: Observable<Bool>
    }
    
    let output: Output
    let model: AddDiaryModel
    
    private let disposeBag = DisposeBag()
    
    init(
        model: AddDiaryModel = AddDiaryModel(),
        input: Input
        ) {
        self.model = model
        let allInputObservables = Observable.combineLatest(input.titleEdited, input.contentEdited, input.switchedOpenRange)
        let imCompletedInput = input.tappedPostDiaryButton.withLatestFrom(allInputObservables).map { (title, content, openRange) -> ImCompletedInput in
            if title.isEmpty, content.isEmpty {
                return .titleAndContent
            }
            if title.isEmpty {
                return .title
            }
            if content.isEmpty {
                return .content
            }
            return .nothing
        }
        let isPersisting = input.tappedPostDiaryButton.withLatestFrom(allInputObservables).flatMap { (title, content, openRange) -> Observable<Bool> in
            let senderRef = Firestore.firestore().collection("users").document(Auth.auth().currentUser!.uid)
            let diary = Entity.Diary(postDate: Timestamp(), title: title, content: content, category: openRange, senderRef: senderRef)
            let request = model.persistDiary(diary: diary).catchErrorJustReturn(false).asObservable()
            return request
        }.share()
        let output = Output(imCompletedInput: imCompletedInput, isPersisting: isPersisting)
        self.output = output
    }
}
