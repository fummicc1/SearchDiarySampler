import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        Auth.auth().currentUser?.reload(completion: { [unowned self] _ in
            guard let user = Auth.auth().currentUser else {
                return
            }
            if user.isEmailVerified {
                let diaryListViewController = UIStoryboard(name: "DiaryList", bundle: nil).instantiateInitialViewController() as! DiaryListViewController
                self.window?.rootViewController = UINavigationController(rootViewController: diaryListViewController)
                self.window?.makeKeyAndVisible()
            } else {
                guard let alertViewController = UIStoryboard(name: "Alert", bundle: nil).instantiateInitialViewController() else {
                    return
                }
                self.window?.rootViewController = alertViewController
                self.window?.makeKeyAndVisible()
            }
        })
        return true
    }
}
