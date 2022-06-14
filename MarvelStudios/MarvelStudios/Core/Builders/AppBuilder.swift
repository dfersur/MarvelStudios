//
//  AppBuilder.swift
//  MarvelStudios
//
//  Created by David Manuel Fernández Suárez on 10/6/22.
//

import UIKit

/// Builder de lnicio de la app
class AppBuilder {
    
    private var window: UIWindow?

    init(window: UIWindow?) {
        self.window = window
    }
    
    func build() {
        window?.makeKeyAndVisible()
        let navigationController: UINavigationController = UINavigationController()
        window?.rootViewController = navigationController
        AppCoordinator(navigationController: navigationController).start()
    }
    
}
