//
//  ImageCache.swift
//  FetchInterview
//
//  Created by Russell Weber on 2023-06-29.
//

import Foundation
import UIKit

/// `ImageCache` is a singleton used to cache images that have been downloaded.
/// It uses an `NSCache` to store `UIImage` instances against `String` keys (URLs).
class ImageCache {
    static let shared = ImageCache()
    
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    /// Retrieves a cached image corresponding to a unique key.
    /// - Parameter key: A `String` representing the unique identifier for the image.
    /// - Returns: A `UIImage` instance if it exists in the cache, `nil` otherwise.
    func image(for key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    /// Caches an image with a unique key.
    /// - Parameters:
    ///   - image: The `UIImage` instance to be cached.
    ///   - key: A `String` representing the unique identifier for the image.
    func cache(image: UIImage, for key: String?) {
        guard let key = key else { return }
        cache.setObject(image, forKey: key as NSString)
    }
}
