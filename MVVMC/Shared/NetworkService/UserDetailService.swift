//
//  UserDetailService.swift
//  MVVMC
//
//  Created by Rajneesh Biswal on 01/06/21.
//  Copyright © 2021 tawkto. All rights reserved.
//

import Foundation
import Combine

protocol UserDetailService {
    typealias Request = _UserDetailService.Request
    typealias Response = _UserDetailService.Response
    
    func userDetails(for request: Request) -> AnyPublisher<UserDetailService.Response, Error>
}

enum _UserDetailService {
    struct Request {
        var url: URL
    }

    struct Response {
        var data: UserDetail
    }
}

final class UserDetailServiceClient: UserDetailService {
    func userDetails(for request: Request) -> AnyPublisher<_UserDetailService.Response, Error> {
        return URLSession.shared.dataTaskPublisher(for: request.url)
            .map { $0.data }
            .decode(type: UserDetail.self, decoder: JSONDecoder())
            .compactMap { _UserDetailService.Response(data: $0) }
            .first()
            .mapError { $0 as Error}
            .eraseToAnyPublisher()
    }
}

