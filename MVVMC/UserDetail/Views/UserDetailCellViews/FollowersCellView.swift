//
//  FollowersCellView.swift
//  MVVMC
//
//  Created by Rajneesh Biswal on 04/06/21.
//  Copyright © 2021 tawkto. All rights reserved.
//

import UIKit

class FollowersCellView: UIView {

    var model: Model {
        didSet {
            applyModel()
        }
    }
    private var followersCountLabel = UILabel()
    private var followingCountLabel = UILabel()
    private var followersLabel = UILabel()
    private var followingLabel = UILabel()
    private var followersVStack = UIStackView()
    private var followingVStack = UIStackView()

    init(model: Model = Model()) {
        self.model = model
        super.init(frame: .zero)
        setUpView()
        applyModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpView() {
        followersVStack.axis = .vertical
        followersVStack.alignment = .center

        followingVStack.axis = .vertical
        followingVStack.alignment = .center

        followersVStack.addArrangedSubview(followersCountLabel)
        followersVStack.setCustomSpacing(Spacing.vSmall, after: followersCountLabel)
        followersVStack.addArrangedSubview(followersLabel)

        followingVStack.addArrangedSubview(followingCountLabel)
        followingVStack.setCustomSpacing(Spacing.vSmall, after: followingCountLabel)
        followingVStack.addArrangedSubview(followingLabel)

        addAutoLayoutSubView(followersVStack)
        addAutoLayoutSubView(followingVStack)
        

        setUpViewLayout()
    }

    private func setUpViewLayout() {
        NSLayoutConstraint.activate([
            followersVStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.large),
            followersVStack.topAnchor.constraint(equalTo: topAnchor, constant: Spacing.vSmall),
            followersVStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Spacing.vSmall),

            followingVStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.large),
            followingVStack.topAnchor.constraint(equalTo: topAnchor, constant: Spacing.vSmall),
            followingVStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Spacing.vSmall)
        ])
    }

    private func applyModel() {
        followersCountLabel.text = "\(model.followers)"
        followingCountLabel.text = "\(model.following)"
        followersLabel.text = "Followers"
        followingLabel.text = "Following"
    }
}

extension FollowersCellView {
    struct Model {
        var followers: Int = 0
        var following: Int = 0
        var followersURL: URL?
        var followingURL: URL?
    }
}

extension FollowersCellView: CellDisplayable {
    func getView() -> UIView {
        return self
    }
}


