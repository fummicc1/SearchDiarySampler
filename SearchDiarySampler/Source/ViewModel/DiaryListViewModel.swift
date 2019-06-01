import Foundation
import RxSwift
import RxCocoa

final class DiaryListViewModel {
    
    struct Input {
        let selectedItem: Observable<IndexPath>
        let changedCategory: Observable<Int>
    }
    
    private let model: DiaryListModel
    
    private let diaryListRelay: PublishRelay<[Entity.Diary]> = PublishRelay<[Entity.Diary]>()
    var diaryListObservable: Observable<[Entity.Diary]> {
        return diaryListRelay.asObservable()
    }
    private var publicDiaryListData: [Entity.Diary] = []
    private var privateDiaryListData: [Entity.Diary] = []
    
    private let disposeBag = DisposeBag()
    
    init(
        model: DiaryListModel = DiaryListModel(),
        input: Input
        ) {
        self.model = model
        
//        model.getDiaryDummies { [unowned self] diaryList in
//            self.publicDiaryListData = []
//            self.privateDiaryListData = []
//            diaryList.forEach({ (diary) in
//                if diary.category == .publicDiary {
//                    self.publicDiaryListData.append(diary)
//                } else if diary.category == .privateDiary {
//                    self.privateDiaryListData.append(diary)
//                }
//            })
//        }
        
        model.downloadAllDiaries { [unowned self] diaryList in
            self.publicDiaryListData = []
            self.privateDiaryListData = []
            diaryList.forEach({ (diary) in
                if diary.category == .publicDiary {
                    self.publicDiaryListData.append(diary)
                } else if diary.category == .privateDiary {
                    self.privateDiaryListData.append(diary)
                }
            })
        }
        
        input.changedCategory.subscribe { [unowned self] event in
            guard let element = event.element else { return }
            switch element {
            case 0:
                self.diaryListRelay.accept(self.publicDiaryListData)
            case 1:
                self.diaryListRelay.accept(self.privateDiaryListData)
            default:
                break
            }
        }.disposed(by: disposeBag)
    }
}
