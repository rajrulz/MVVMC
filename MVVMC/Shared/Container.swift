//
//  Container.swift
//  MVVMC
//
//  Created by Rajneesh Biswal on 27/06/21.
//  Copyright © 2021 tawkto. All rights reserved.
//

import Foundation

class Container {
    private var registery: [String: Any] = [:]
    static let shared = Container()
    private init() {}

    public func register<Interface>(_ interface: Interface.Type, _ initialiser: @escaping () -> Interface) {
        let id = identifier(of: interface)
        registery[id] = initialiser()
    }

    public func get<Interface>(_ interface: Interface.Type = Interface.self) -> Interface? {
        let id = identifier(of: interface)
        guard let interface = registery[id] as? Interface else {
            return nil
        }
        return interface
    }

    private func identifier<Interface>(of interface: Interface.Type) -> String {
        return String(describing: interface.self)
    }
}
