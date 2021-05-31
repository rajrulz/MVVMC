//
//  UserService.swift
//  MVVMC
//
//  Created by Rajneesh Biswal on 30/05/21.
//  Copyright © 2021 tawkto. All rights reserved.
//

import Foundation
import Combine

protocol UserService {
    typealias Request = _UserService.Request
    typealias Response = _UserService.Response
    
    func users(for request: Request) -> AnyPublisher<Response, Error>
}

enum _UserService {
    struct Request {
        var url: URL
    }

    struct Response {
        var data: [User]
    }
}

final class UserServiceClient: UserService {
    static let urlStr = "https://api.github.com/users?since=0"

    func users(for request: Request) -> AnyPublisher<UserService.Response, Error> {
        return URLSession.shared.dataTaskPublisher(for: request.url)
            .compactMap { $0.data }
            .decode(type: [User].self, decoder: JSONDecoder())
            .map { Response(data: $0) }
            .mapError { $0 as Error}
            .eraseToAnyPublisher()
    }
}
