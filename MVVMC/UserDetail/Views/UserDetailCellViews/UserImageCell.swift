//
//  UserImageCell.swift
//  MVVMC
//
//  Created by Rajneesh Biswal on 01/06/21.
//  Copyright © 2021 tawkto. All rights reserved.
//

import UIKit

class UserImageView: UIView {

    var model: Model {
        didSet {
            applyModel()
        }
    }

    private var userImageView: CDNImageView

    init(model: Model = .init()) {
        self.model = model
        self.userImageView = CDNImageView(url: model.imageUrlStr)
        super.init(frame: .zero)
        setUpView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpView() {
        userImageView.contentMode = .scaleAspectFill
        userImageView.layer.cornerRadius = Spacing.small
        userImageView.clipsToBounds = true
        userImageView.layer.borderColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        userImageView.layer.borderWidth = 1

        addAutoLayoutSubView(userImageView)
        NSLayoutConstraint.activate([
            userImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            userImageView.topAnchor.constraint(equalTo: topAnchor),
            userImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            userImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            userImageView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }

    private func applyModel() {
        userImageView = CDNImageView(url: model.imageUrlStr)
    }
}

extension UserImageView {
    struct Model {
        var imageUrlStr: String
        public init(imageUrlStr: String = "") {
            self.imageUrlStr = imageUrlStr
        }
    }
}

extension UserImageView: CellDisplayable {
    func getView() -> UIView {
        return self
    }
}
