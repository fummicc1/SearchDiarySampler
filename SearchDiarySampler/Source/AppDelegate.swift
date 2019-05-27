import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        if Auth.auth().currentUser != nil {
            let diaryListViewController = UIStoryboard(name: "DiaryList", bundle: nil).instantiateInitialViewController() as! DiaryListViewController
            window?.rootViewController = UINavigationController(rootViewController: diaryListViewController)
            window?.makeKeyAndVisible()
        }
        return true
    }
}

