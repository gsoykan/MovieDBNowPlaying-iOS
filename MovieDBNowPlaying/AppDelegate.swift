//
//  AppDelegate.swift
//  MovieDBNowPlaying
//
//  Created by gurkan soykan on 21.06.2019.
//  Copyright © 2019 gurkan soykan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setAppearance()
        setInitialViewController()
        return true
    }
    
    private func setAppearance() {
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = UIColor.darkGray
    }
    
    private func setInitialViewController() {
        let storyboard = UIStoryboard(name: Constants.Storyboards.main, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier : Constants.ViewControllers.nowPlayingVC) as! NowPlayingListViewController
        viewController.presenterDelegate = NowPlayingListPresenter(delegate: viewController)
        let navController = UINavigationController(rootViewController: viewController)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }

}

