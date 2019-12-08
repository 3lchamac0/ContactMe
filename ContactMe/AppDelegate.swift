//
//  AppDelegate.swift
//  ContactMe
//
//  Created by formando on 07/11/2019.
//  Copyright © 2019 IPL-Master. All rights reserved.
//

import UIKit
import GooglePlaces
import KeychainAccess


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        GMSPlacesClient.provideAPIKey("AIzaSyD1dWnnUugFZuqhfLYSR5FOm18bB6A0GgY")
        
        do {
            
            try ProfileDataHelper.createTable()
                        
           /* let keychain = Keychain(service: Constants.KEYCHAIN_SERVICE)
            try keychain.removeAll()
            
            guard var profiles = try ProfileDataHelper.findAll() else {
                throw DataAccessError.Datastore_Connection_Error
            }
            for profile in profiles{
                try ProfileDataHelper.delete(item: profile)
            }*/
            
        } catch _{
            print("caca")
        }
        
        checkIfUserIsLoggedIn()

        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
    private func checkIfUserIsLoggedIn() {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
    
            window?.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
            
            let mainStoryboard:UIStoryboard = UIStoryboard(name: Constants.Identifiers.STORYBOARD, bundle: nil)
            
            let keychain = Keychain(service: Constants.KEYCHAIN_SERVICE)
            
            // Check if pwd is in keychain
            if keychain[Constants.USER_PASSWORD_KEY] != nil {
                // Show first item of tab bar
                let tabBarController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Identifiers.MAIN_TAB) as! MainTabBarController
                
                // ToDo: Should we set the item of the tab to open by default?
                window?.rootViewController = tabBarController
            } else {
                // Show login page
                let loginViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Identifiers.LOGIN)
                window?.rootViewController = loginViewController
            }
            
            window?.makeKeyAndVisible()
        
    }
}

