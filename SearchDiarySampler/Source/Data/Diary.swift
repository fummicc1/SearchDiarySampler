import FirebaseFirestore

extension Entity {
    
    struct Diary {
        
        enum Category: String {
            case publicDiary
            case privateDiary
        }
        
        let postDate: Timestamp
        let title: String
        let content: String
        let category: Category
        let senderRef: DocumentReference
        
        init(data: [String: Any]) {
            guard
                let postDate = data["posted_at"] as? Timestamp,
                let title = data["title"] as? String,
                let content = data["content"] as? String,
                let rawValue = data["category"] as? String,
                let category = Category(rawValue: rawValue),
                let senderRef = data["sender_ref"] as? DocumentReference else {
                    fatalError()
            }
            self.postDate = postDate
            self.title = title
            self.content = content
            self.category = category
            self.senderRef = senderRef
        }

        
        init(
            postDate: Timestamp,
            title: String,
            content: String,
            category: Category,
            senderRef: DocumentReference
            ) {
            self.postDate = postDate
            self.title = title
            self.content = content
            self.category = category
            self.senderRef = senderRef
        }
        
        static func createDummy() -> Diary {
            return Diary(
                postDate: Timestamp(),
                title: "",
                content: "",
                category: .publicDiary,
                senderRef: Firestore.firestore().collection("users").document("dummy_user")
            )
        }
    }
}
