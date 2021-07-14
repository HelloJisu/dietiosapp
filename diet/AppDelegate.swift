//
//  AppDelegate.swift
//  diet
//
//  Created by 유지수 on 2021/07/10.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var idstring : String = ""



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        let namekey = UserDefaults.standard.string(forKey: "id")
        print(namekey)
        if let name = namekey {
            idstring=name
        if(!namekey!.isEmpty){
            let storyboard = UIStoryboard(name: "second", bundle: nil)
            
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "home")
            
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
        }
        }
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

