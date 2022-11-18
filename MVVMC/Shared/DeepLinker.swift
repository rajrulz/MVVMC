//
//  DeepLinker.swift
//  MVVMC
//
//  Created by Rajneesh Biswal on 19/11/22.
//  Copyright © 2022 tawkto. All rights reserved.
//

import Foundation
import UIKit

public protocol DeepLinker {
    typealias CurrentNavigationController = UINavigationController
    func canHandle(deepLink: URL) -> Bool
    func addHandler(deepLink: URL, handler: (URL, CurrentNavigationController) -> Void)
    func route(deepLink: URL) -> Bool
}


/// DeeplinkerAppDelegate needs to be informed when user taps on any deep link.
/// Similarly if any feature module needs to be informed regarding application state like when app entered background etc
/// Similar kind of class needs to be created and registered in appDelegate
public class DeeplinkerAppDelegate: NSObject, UIApplicationDelegate {
    private var deepLinker: DeepLinker?

    public init(_ deepLinker: DeepLinker) {
        self.deepLinker = deepLinker
    }

    public func application(_ app: UIApplication,
                            open url: URL,
                            options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return deepLinker?.route(deepLink: url) ?? false
    }
}
