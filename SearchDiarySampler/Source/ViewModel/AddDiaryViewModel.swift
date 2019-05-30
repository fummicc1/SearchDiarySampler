import Foundation
import RxSwift
import RxCocoa

final class AddDiaryViewModel {
    
    struct Input {
        let tappedPostDiaryButton: Observable<Void>
        let titleEdited: Observable<String>
    }
    
    struct Output {
        
    }
    
    let output: Output
    let model: AddDiaryModel
    
    init(
        model: AddDiaryModel = AddDiaryModel(),
        input: Input
        ) {
        self.model = model
    }
}
