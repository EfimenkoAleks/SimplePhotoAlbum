//
//  AppDelegate.swift
//  SimplePhotoAlbum
//
//  Created by user on 01.09.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        DBStorageConfigurator.registerStorageClass(MainDBStorage.self)
        let window = UIWindow()
        AppManager.shared.updateRootVC(window)
        window.makeKeyAndVisible()
        return true
    }
}

