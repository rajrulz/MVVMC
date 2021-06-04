//
//  UserDetailsView.swift
//  MVVMC
//
//  Created by Rajneesh Biswal on 05/06/21.
//  Copyright © 2021 tawkto. All rights reserved.
//

import Foundation
import UIKit

enum Image: String {
    case user
    case company
    case blog
    case email
    case location
    case twitter
    case bio

    var view: UIImageView {
        switch self {
        default:
           let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.image = UIImage(named: rawValue)
            imageView.contentMode = .scaleAspectFit
            return imageView
        }
    }
}
class UserDetailsView: UIView {
    var model: Model {
        didSet {
            applyModel()
        }
    }
    private var nameLabel = UILabel()
    private var userImage = Image.user.view
    private var companyLabel = UILabel()
    private var companyImage = Image.company.view
    private var blogLabel = UILabel()
    private var blogImage = Image.blog.view

    private var emailLabel = UILabel()
    private var emailImage = Image.email.view

    private var locationLabel = UILabel()
    private var locationImage = Image.location.view

    private var twitterLabel = UILabel()
    private var twitterImage = Image.twitter.view

    private var bioLabel = UILabel()
    private var bioImage = Image.bio.view

    private var vStack = UIStackView()
    private var hStack: (() -> UIStackView) = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }
    init(model: Model = Model()) {
        self.model = model
        super.init(frame: .zero)
        applyModel()
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        vStack.axis = .vertical
        vStack.alignment = .leading

        setLinesForAllLabels()

        addAutoLayoutSubView(vStack)
        setUpViewConstraint()
    }

    private func setUpViewConstraint() {
        NSLayoutConstraint.activate([
            vStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.small),
            vStack.topAnchor.constraint(equalTo: topAnchor, constant: Spacing.small),
            vStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.small),
            vStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Spacing.small)
        ])
    }

    private func applyModel() {
        if !model.name.isEmpty {
            nameLabel.text = model.name
            addHStack(label: nameLabel, image: userImage)
        }
        if !model.company.isEmpty {
            companyLabel.text = model.company
            addHStack(label: companyLabel, image: companyImage)
        }
        if !model.email.isEmpty {
            emailLabel.text = model.email
            addHStack(label: emailLabel, image: emailImage)
        }
        if !model.location.isEmpty {
            locationLabel.text = model.location
            addHStack(label: locationLabel, image: locationImage)
        }
        if !model.twitterUsername.isEmpty {
            twitterLabel.text = model.twitterUsername
            addHStack(label: twitterLabel, image: twitterImage)
        }
        if !model.bio.isEmpty {
            bioLabel.text = model.bio
            addHStack(label: bioLabel, image: bioImage)
        }
    }

    private func setLinesForAllLabels() {
        companyLabel.numberOfLines = 0
        blogLabel.numberOfLines = 0
        bioLabel.numberOfLines = 0
    }

    private func addHStack(label: UILabel, image: UIImageView) {
        let horizontalStack = hStack()
        horizontalStack.alignment = .center
        horizontalStack.addArrangedSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            image.heightAnchor.constraint(equalToConstant: 40),
            image.widthAnchor.constraint(equalTo: image.heightAnchor)
        ])
        horizontalStack.setCustomSpacing(Spacing.vSmall, after: image)
        let verticalStack = UIStackView()
        verticalStack.addArrangedSubview(label)
        horizontalStack.addArrangedSubview(verticalStack)
        vStack.addArrangedSubview(horizontalStack)
        vStack.setCustomSpacing(Spacing.small, after: horizontalStack)
    }
}

extension UserDetailsView {
    struct Model {
        var name: String
        var company: String
        var blog: String
        var email: String
        var location: String
        var twitterUsername: String
        var bio: String

        init(name: String = "",
             company: String = "",
             blog: String = "",
             email: String = "",
             location: String = "",
             twitterUsername: String = "",
             bio: String = "") {
            self.name = name
            self.company = company
            self.blog = blog
            self.email = email
            self.location = location
            self.twitterUsername = twitterUsername
            self.bio = bio
        }
    }
}

extension UserDetailsView: CellDisplayable {
    func getView() -> UIView {
        return self
    }
}
