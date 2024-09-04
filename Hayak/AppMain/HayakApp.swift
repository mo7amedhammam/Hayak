//
//  HayakApp.swift
//  Hayak
//
//  Created by wecancity on 09/06/2024.
//

import SwiftUI

@main
struct HayakApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
//            OtpScreen()
        }
    }
}


class AppDelegate: UIResponder, UIApplicationDelegate {
//    var window: UIWindow?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch
        do {
             print("app started")
//             print("app in: user :", Helper.shared.getSelectedUserType()?.rawValue ?? "")
//             print("app in: loged in :", Helper.shared.CheckIfLoggedIn())
//             try registerForRemoteNotifications(application: application)
//             FirebaseApp.configure()
//             Messaging.messaging().delegate = self
//             UNUserNotificationCenter.current().delegate = self
//             UIApplication.shared.applicationIconBadgeNumber = 0

//            if Helper.shared.CheckIfLoggedIn() == false {
//                Helper.shared.setSelectedUserType(userType: .Student)
//             }
            
         } catch {
             print("Error initializing app:", error.localizedDescription)
         }
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // The app entered the background
        // Handle actions when the app moves to the background
        print("app in background")
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // The app is about to terminate
        // Handle actions before the app gets terminated
        print("app terminated")
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
         .portrait
     }
}
