//
//  ImageService.swift
//  MVVMC
//
//  Created by Rajneesh Biswal on 31/05/21.
//  Copyright © 2021 tawkto. All rights reserved.
//

import Foundation
import Combine
import UIKit

class ImageCache {
    static let shared = ImageCache()
    private init() {}

    private var cache = NSCache<NSString, UIImage>()

    subscript(_ identifier: NSString) -> UIImage? {
        return cache.object(forKey: identifier)
    }

    func setImage(_ image: UIImage, forKey key: NSString) {
        cache.setObject(image, forKey: key)
    }
}

class CDNImageView: UIImageView {
    private let imageURLStr: NSString
    private let cache = ImageCache.shared
    private var cancellableSubsciptions = Set<AnyCancellable>()

    init(url: String) {
        self.imageURLStr = NSString(string: url)
        super.init(frame: .zero)
        fetchImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func fetchImage() {
        if let image = cache[imageURLStr] {
            self.image = image
            return
        }

        guard let url = URL(string: String(imageURLStr)) else { return }
        URLSession.shared.dataTaskPublisher(for: url)
            .compactMap { UIImage(data: $0.data) }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }) { [unowned self] in
                self.image = $0
                self.cache.setImage($0, forKey: self.imageURLStr)
            }
            .store(in: &cancellableSubsciptions)
    }
}
