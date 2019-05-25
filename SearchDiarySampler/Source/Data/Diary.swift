import FirebaseFirestore

extension Entity {
    
    enum Category: String {
        case publicDiary
        case privateDiary
    }
    
    struct Diary {
        let postDate: Timestamp
        let title: String
        let content: String
        let category: Category
        let senderRef: DocumentReference
    }
}
