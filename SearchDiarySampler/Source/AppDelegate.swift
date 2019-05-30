import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        guard let user = Auth.auth().currentUser else {
            return true
        }
        if user.isEmailVerified {
            let diaryListViewController = UIStoryboard(name: "DiaryList", bundle: nil).instantiateInitialViewController() as! DiaryListViewController
            window?.rootViewController = UINavigationController(rootViewController: diaryListViewController)
            window?.makeKeyAndVisible()
        } else {            
        }
        return true
    }
}

extension AppDelegate {
    @objc fileprivate func openGmail() {
        guard let url = URL(string: "googlegmail://") else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

