import Foundation
import UIKit
import RxSwift

class DiaryListTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var postDateLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var senderNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func displatyDiaryData(_ diary: Entity.Diary) {
        #warning("convert date into text later.")
        postDateLabel.text = diary.postDate.description
        titleLabel.text = diary.title
        senderNameLabel.text = diary.senderRef.documentID
    }
}
