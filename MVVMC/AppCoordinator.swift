//
//  AppCoordinator.swift
//  MVVMC
//
//  Created by Rajneesh Biswal on 01/06/21.
//  Copyright © 2021 tawkto. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator<Void> {
    var window: UIWindow
    var navigationController: UINavigationController
    var bootStrapCoordinator: Coordinator<Void>

    init(scene: UIWindowScene) {
        window = UIWindow(windowScene: scene)
        navigationController = UINavigationController()
        window.rootViewController = navigationController
        bootStrapCoordinator = BootstrapCoordinator()
    }

    override func start() {
        bootStrapCoordinator.start()

        if let userListAPI: UserListAPI = Container.shared.get() {
            let userListCoordinator = userListAPI.getUserListCoordinator(navigationController: navigationController)
            userListCoordinator.start()
            addChildCoordinator(userListCoordinator)
            window.makeKeyAndVisible()
        } 
    }
}

class BootstrapCoordinator: Coordinator<Void> {

    override func start() {
        super.start()
        
        Container.shared.register(UserListAPI.self, UserListPluginAPI.init)
        Container.shared.register(UserDetailAPI.self, UserDetailPluginAPI.init)
    }
}
