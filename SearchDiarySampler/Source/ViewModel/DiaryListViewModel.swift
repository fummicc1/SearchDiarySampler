import Foundation
import RxSwift
import RxCocoa

final class DiaryListViewModel {
    
    struct Input {
        let selectedItem: Observable<IndexPath>
        let tappedAddDiaryButton: Observable<Void>
        let changedCategory: Observable<Int>
    }
    
    private let model: DiaryListModel
    
    private let diaryListRelay: BehaviorRelay<[Entity.Diary]> = BehaviorRelay<[Entity.Diary]>(value: [])
    var diaryList: [Entity.Diary] {
        return diaryListRelay.value
    }
    
    let input: Input
    
    init(
        model: DiaryListModel = DiaryListModel(),
        input: Input
        ) {
        self.model = model
        self.input = input
    }
}
