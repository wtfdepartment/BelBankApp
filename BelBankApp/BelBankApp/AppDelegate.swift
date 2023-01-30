//
//  AppDelegate.swift
//  BelBankApp
//
//  Created by Александра on 29.01.23.
//

import UIKit
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GMSServices.provideAPIKey("AIzaSyAS6qgX2yi3HcDVg_Um0ScpBP4wkp3R5pM")
        return true
    }

}

