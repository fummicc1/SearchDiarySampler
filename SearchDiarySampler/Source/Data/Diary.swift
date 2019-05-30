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
        
//        init(data: [String: Any]) {
//            if let postDate = data["posted_at"] as? Timestamp {
//                self.postDate = postDate
//            } else {
//                self.postDate = Timestamp()
//            }
//            if let title = data["title"] as? String {
//                self.title = title
//            } else {
//                self.title = ""
//            }
//            if let content = data["content"] as? String {
//                self.content = content
//            } else {
//                self.content = ""
//            }
//            if let rawValue = data["category"] as? String, let category = Category(rawValue: rawValue) {
//                self.category = category
//            } else {
//                self.category = .publicDiary
//            }
//            if let senderRef = data["sender_ref"] as? DocumentReference {
//                self.senderRef = senderRef
//            } else {
//                self.senderRef = Firestore.firestore().collection("users").document("failure")
//            }
        //        }
        
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
