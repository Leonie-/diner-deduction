import UIKit

///The Application Delegate receives application-level messages, and can respond accordingly.
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    ///
    var window: UIWindow?

    /// Responsible for launching the main application
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    
    /// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state. This method may eventually be used to pause the game. Currently not used.
    func applicationWillResignActive(_ application: UIApplication) {}

    
    /// This method releases shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. Currently not used.
    func applicationDidEnterBackground(_ application: UIApplication) {}

    /// This method is called as part of the transition from the background to the active state. Currently not used.
    func applicationWillEnterForeground(_ application: UIApplication) {}

    /// This method restarts any tasks that were paused (or not yet started) while the application was inactive. Currently not used.
    func applicationDidBecomeActive(_ application: UIApplication) {}

    /// Called when the application is about to terminate. Currently not used.
    func applicationWillTerminate(_ application: UIApplication) {}

}

