//
//  HomeAPI.swift
//  MVVMC
//
//  Created by Rajneesh Biswal on 27/06/21.
//  Copyright © 2021 tawkto. All rights reserved.
//
import Foundation
import UIKit

protocol UserListAPI: PluginAPI {
    func getUserListCoordinator(navigationController: UINavigationController) -> Coordinator<Void>
}
