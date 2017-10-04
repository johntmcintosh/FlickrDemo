//
//  AppDelegate.swift
//  FlickrDemo
//
//  Created by John McIntosh on 10/2/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let vc = FeedViewController()
        let navController = UINavigationController(rootViewController: vc)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navController
        window.makeKeyAndVisible()
        self.window = window

        return true
    }
}
