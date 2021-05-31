//
//  UserCellView.swift
//  MVVMC
//
//  Created by Rajneesh Biswal on 31/05/21.
//  Copyright © 2021 tawkto. All rights reserved.
//

import UIKit
import Combine

protocol CellDisplayable: AnyObject {
    func getView() -> UIView
}

class UserCellView: UIView {
    var model: Model {
        didSet {
            applyModel()
        }
    }
    
    private var userImageView: CDNImageView
    private var typeLabel = UILabel()
    private var usernameLabel = UILabel()
    private var horizontalStackView = UIStackView()
    private var verticalStackView = UIStackView()

    init(model: Model) {
        self.model = model
        userImageView = CDNImageView(url: model.avatarUrl)
        super.init(frame: .zero)
        setUp()
        applyModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUp() {
        horizontalStackView.alignment = .top
        horizontalStackView.axis = .horizontal

        verticalStackView.alignment = .leading
        verticalStackView.axis = .vertical

        usernameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        usernameLabel.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)

        typeLabel.font = UIFont.systemFont(ofSize: 14)
        typeLabel.textColor = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
        userImageView.layer.cornerRadius = Spacing.small/2
        userImageView.clipsToBounds = true
        userImageView.layer.borderColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        userImageView.layer.borderWidth = 1
        userImageView.contentMode = .scaleAspectFit
        setUpLayout()
    }

    func setUpLayout() {
        self.addAutoLayoutSubView(horizontalStackView)
        
        horizontalStackView.addArrangedSubview(userImageView)
        horizontalStackView.setCustomSpacing(Spacing.small, after: userImageView)

        verticalStackView.addArrangedSubview(usernameLabel)
        verticalStackView.setCustomSpacing(Spacing.small, after: usernameLabel)
        
        verticalStackView.addArrangedSubview(typeLabel)
        horizontalStackView.addArrangedSubview(verticalStackView)

        self.backgroundColor = .systemGray
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: horizontalStackView.leadingAnchor, constant: -Spacing.small),
            self.topAnchor.constraint(equalTo: horizontalStackView.topAnchor, constant: -Spacing.small),
            self.trailingAnchor.constraint(equalTo: horizontalStackView.trailingAnchor, constant: Spacing.small),
            self.bottomAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: Spacing.small),

            userImageView.heightAnchor.constraint(equalToConstant: Spacing.large),
            userImageView.widthAnchor.constraint(equalToConstant: Spacing.large)
        ])
    }

    func applyModel() {
        typeLabel.text = model.type
        usernameLabel.text = model.username
    }
}

extension UserCellView: CellDisplayable {
    func getView() -> UIView {
        return self
    }
}
