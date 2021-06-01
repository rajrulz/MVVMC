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

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}

class UserListCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []

    var navigationController: UINavigationController
    
    private var onFinish: (()-> Void)?
    private var userService: UserService

    private var cancellableSubscribers = Set<AnyCancellable>()
    private var userResponse: UserService.Response?

    private let viewController: UserListViewController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.userService = UserServiceClient()
        self.viewController = UserListViewController()
        setUp()
    }

    func start() {
        guard let url = URL(string: "https://api.github.com/users?since=0") else {
            return
        }
        self.viewController.delegate = self
        self.navigationController.pushViewController(viewController, animated: true)

        userService.users(for: .init(url: url))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }) { [weak self] in
                self?.viewController.model = .init(response: $0, title: "GitHub Users")
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
    func didSelectUser(_ user: UserCellView.Model, sender: UserListViewController) {
        
    }
}
