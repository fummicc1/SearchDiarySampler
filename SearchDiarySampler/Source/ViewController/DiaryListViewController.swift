import UIKit
import RxSwift
import RxCocoa

class DiaryListViewController: UIInputViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var addDiaryBarButton: UIBarButtonItem!
    @IBOutlet private weak var categorySegmentedControl: UISegmentedControl!
    
    private var viewModel: DiaryListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let input = DiaryListViewModel.Input(
            selectedItem: tableView.rx.itemSelected.asObservable(),
            tappedAddDiaryButton: addDiaryBarButton.rx.tap.asObservable(),
            changedCategory: categorySegmentedControl.rx.selectedSegmentIndex.asObservable()
        )
        viewModel = DiaryListViewModel(input: input)
    }
}

extension DiaryListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.diaryList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
