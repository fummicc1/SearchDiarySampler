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
