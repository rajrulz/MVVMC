//
//  UserListViewController+Model.swift
//  MVVMC
//
//  Created by Rajneesh Biswal on 31/05/21.
//  Copyright © 2021 tawkto. All rights reserved.
//

import Foundation

extension UserListViewController {
    struct Model {
        var cellModels: [UserCellView.Model]

        init(response: UserService.Response = .init(data: [])) {
            self.cellModels = response.data.map { UserCellView.Model(user: $0) }
        }

        func generateSections() -> [CellDisplayable] {
            return cellModels.map { UserCellView(model: $0) }
        }
    }
}
