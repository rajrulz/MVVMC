//
//  AppCoordinator.swift
//  MVVMC
//
//  Created by Rajneesh Biswal on 01/06/21.
//  Copyright © 2021 tawkto. All rights reserved.
//

import Foundation
import UIKit

class Coordinator<CoordinationResult> {
    private let identifier = UUID()
    private var childCoordinators: [UUID: Coordinator] = [:]
    open func start() {
    }

    public var onFinish:((CoordinationResult)-> Void)?

    public func finish(_ result: CoordinationResult) {
        onFinish?(result)
        cleanUpFromParent?()
    }

    public func addChildCoordinator(_ coordinator: Coordinator) {
        coordinator.cleanUpFromParent = { [weak self, weak coordinator] in
            self?.removeChildCoordinator(coordinator)
        }
        childCoordinators[coordinator.identifier] = coordinator
    }

    private var cleanUpFromParent: (()-> Void)?
    private  func removeChildCoordinator(_ coordinator: Coordinator?) {
        guard let coordinator = coordinator else { return }
        childCoordinators[coordinator.identifier] = nil
    }
}

class AppCoordinator: Coordinator<Void> {
    var window: UIWindow
    var navigationController: UINavigationController

    init(scene: UIWindowScene) {
        window = UIWindow(windowScene: scene)
        navigationController = UINavigationController()
        window.rootViewController = navigationController
    }

    override func start() {
        let userListCoordinator = UserListCoordinator(navigationController: navigationController)
        userListCoordinator.start()
        addChildCoordinator(userListCoordinator)
        window.makeKeyAndVisible()
    }
}
