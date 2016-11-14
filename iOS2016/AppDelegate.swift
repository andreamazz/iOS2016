//
//  AppDelegate.swift
//  iOS2016
//
//  Created by Andrea Mazzini on 13/11/2016.
//  Copyright © 2016 Andrea Mazzini. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

    UINavigationBar.appearance().tintColor = .black

    return true
  }

}

