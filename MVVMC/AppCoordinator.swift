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
    private let container: Container

    init(window: UIWindow,
         navigationController: UINavigationController) {
        self.window = window
        self.navigationController = navigationController
        self.container = Container()
        window.rootViewController = navigationController
        bootStrapCoordinator = BootstrapCoordinator(container)
    }

    override func start() {
        bootStrapCoordinator.start()

        if let userListAPI: UserListAPI = container.get() {
            let userListCoordinator = userListAPI.getUserListCoordinator(navigationController: navigationController)
            userListCoordinator.start()
            addChildCoordinator(userListCoordinator)
            window.makeKeyAndVisible()
        } 
    }
}

class BootstrapCoordinator: Coordinator<Void> {
    private let container: Container

    init(_ container: Container) {
        self.container = container
    }

    override func start() {
        super.start()

        container.register(UserListAPI.self, UserListPluginAPI.init)
        container.register(UserDetailAPI.self, UserDetailPluginAPI.init)
    }
}
