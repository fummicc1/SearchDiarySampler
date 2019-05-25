extension Entity {
    struct User {
        let authenticationID: String
        let identity: String
        let userName: String
        var diaryList: [Diary]?
    }
}
