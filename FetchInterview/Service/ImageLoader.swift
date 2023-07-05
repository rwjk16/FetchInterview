//
//  ImageLoader.swift
//  FetchInterview
//
//  Created by Russell Weber on 2023-07-04.
//

import Foundation
import Combine
import UIKit

/// `ImageLoader` is a class responsible for loading images from a URL.
/// It uses a `URLSession` data task to fetch the image data and converts it into a `UIImage`.
/// If an image for the provided URL is already cached in `ImageCache`, it uses the cached image.
class ImageLoader: ObservableObject {
    
    private static let imageCache = ImageCache.shared
    
    private let urlString: String
    private var cancellable: AnyCancellable?
    
    @Published var image: UIImage?
    
    /// Initialize a new image loader.
    /// - Parameter url: A `String` representing the URL to fetch the image from.
    init(url: String) {
        self.urlString = url
    }
    
    /// Loads an image either from the cache or the provided URL.
    func loadImage() {
        if let cachedImage = ImageLoader.imageCache.image(for: urlString) {
            image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .compactMap { UIImage(data: $0) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] image in
                guard let image = image else { return }
                ImageLoader.imageCache.cache(image: image, for: self?.urlString)
                self?.image = image
            }
    }
    
    deinit {
        cancellable?.cancel()
    }
}
