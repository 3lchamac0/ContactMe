//
//  SceneDelegate.swift
//  ContactMe
//
//  Created by formando on 07/11/2019.
//  Copyright © 2019 IPL-Master. All rights reserved.
//

import UIKit
import KeychainAccess

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       checkIfUserIsLoggedIn(scene)
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    private func checkIfUserIsLoggedIn(_ scene: UIScene) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
            
            let mainStoryboard:UIStoryboard = UIStoryboard(name: Constants.Identifiers.STORYBOARD, bundle: nil)
            
            let currentUser = UserService.getCurrentUserSession()
            
            // Check if pwd is in keychain
            if currentUser != nil {
                // Show first item of tab bar
                let tabBarController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Identifiers.MAIN_TAB) as! MainTabBarController
                
                // ToDo: Should we set the item of the tab to open by default?
                window.rootViewController = tabBarController
            } else {
                // Show login page
                let loginViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Identifiers.LOGIN)
                window.rootViewController = loginViewController
            }
            
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
    
}

