//
//  SceneDelegate.swift
//  Marvel_Heroes
//
//  Created by Cristiano Salla Lunardi on 09/12/19.
//  Copyright © 2019 Cristiano Salla Lunardi. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let window = window else { return }
        guard let splitViewController = window.rootViewController as? UISplitViewController else { return }
        guard let navigationController = splitViewController.viewControllers.last as? UINavigationController else { return }
        navigationController.topViewController?.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        navigationController.topViewController?.navigationItem.leftItemsSupplementBackButton = true
        splitViewController.delegate = self
    }

}

