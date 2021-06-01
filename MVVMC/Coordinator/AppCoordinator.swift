//
//  AppCoordinator.swift
//  MVVMC
//
//  Created by Rajneesh Biswal on 01/06/21.
//  Copyright © 2021 tawkto. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var window: UIWindow
    var navigationController: UINavigationController

    init(scene: UIWindowScene) {
        window = UIWindow(windowScene: scene)
        navigationController = UINavigationController()
        window.rootViewController = navigationController
    }

    func start() {
        let userListCoordinator = UserListCoordinator(navigationController: navigationController)
        userListCoordinator.start()
        childCoordinators.append(userListCoordinator)
        window.makeKeyAndVisible()
    }
    
}
