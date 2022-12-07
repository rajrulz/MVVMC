//
//  MainCoordinator.swift
//  MVVMC
//
//  Created by Rajneesh Biswal on 31/05/21.
//  Copyright © 2021 tawkto. All rights reserved.
//

import Foundation
import UIKit
import Combine

class UserListCoordinator: Coordinator<Void> {
    var navigationController: UINavigationController
    private var userService: UserService
    private var cancellableSubscribers = Set<AnyCancellable>()
    private var userResponse: UserService.Response?

    private let viewController: UserListViewController
    private let container: Container

    init(container: Container, navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.userService = UserServiceClient()
        self.viewController = UserListViewController()
        self.container = container
        super.init()
        setUp()
    }

    override func start() {
        super.start()
        guard let url = URL(string: "https://api.github.com/users?since=0") else {
            return
        }
        self.viewController.delegate = self
        self.navigationController.pushViewController(viewController, animated: true)

        viewController.model = .loading
        userService.users(for: .init(url: url))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .failure(let error):
                    self?.viewController.model = .completed(.failure(error))
                default:
                    break
                }
            }) { [weak self] in
                self?.viewController.model = .completed(.success(.init(response: $0, title: "GitHub Users")))
            }
            .store(in: &cancellableSubscribers)
    }

    private func setUp() {
        self.navigationController.navigationBar.prefersLargeTitles = true
        self.navigationController.navigationBar.largeTitleTextAttributes =
            [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1),
             NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]
    }
}

extension UserListCoordinator: UserListViewControllerDelegate {
    func didSelectUser(_ user: UserContext, sender: UserListViewController) {
        if let userDetailAPI: UserDetailAPI = container.get() {
            let userDetailCoordinator = userDetailAPI.getUserDetailsCoordinator(context: user, navigationController: navigationController)
            addChildCoordinator(userDetailCoordinator)
            userDetailCoordinator.start()
        }
    }
}
