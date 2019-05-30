
extension Entity {
    struct User {
        let authenticationID: String
        let identity: String
        let userName: String
        var diaryList: [Diary]?
        
        init(data: [String: Any]) {
            guard
                let authenticationID = data["authentication_id"] as? String,
                let identity = data["identity"] as? String,
                let userName = data["user_name"] as? String else {
                    fatalError()
            }
            self.authenticationID = authenticationID
            self.identity = identity
            self.userName = userName
        }
        
        init(
            authenticationID: String,
            identity: String,
            userName: String
            ) {
            self.authenticationID = authenticationID
            self.identity = identity
            self.userName = userName
        }
    }
}
