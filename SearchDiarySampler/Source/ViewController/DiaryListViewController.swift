import UIKit
import RxSwift
import RxCocoa

class DiaryListViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var addDiaryBarButton: UIBarButtonItem!
    @IBOutlet private weak var categorySegmentedControl: UISegmentedControl!
    
    private var viewModel: DiaryListViewModel?
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let input = DiaryListViewModel.Input(
            selectedItem: tableView.rx.itemSelected.asObservable(),
            changedCategory: categorySegmentedControl.rx.selectedSegmentIndex.asObservable()
        )
        viewModel = DiaryListViewModel(input: input)
        
        viewModel?.diaryListObservable.bind(to: tableView.rx.items(cellIdentifier: "DiaryListCell", cellType: DiaryListTableViewCell.self)) { row, element, cell in
            cell.displatyDiaryData(element)
        }.disposed(by: disposeBag)
        
        addDiaryBarButton.rx.tap.subscribe { [unowned self] event in
            let viewController = UIStoryboard(name: "AddDiary", bundle: nil).instantiateInitialViewController()!
            let navigationController = UINavigationController(rootViewController: viewController)
            self.present(navigationController, animated: true, completion: nil)
        }
    }
}
