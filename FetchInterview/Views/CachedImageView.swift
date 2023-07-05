//
//  CachedImage.swift
//  FetchInterview
//
//  Created by Russell Weber on 2023-06-29.
//

import Foundation
import SwiftUI
import Combine

/// `CachedImageView` is a `View` that displays an image fetched from a URL.
/// It uses `ImageLoader` to fetch the image data and displays a placeholder view until the image is available.
struct CachedImageView<Placeholder: View>: View {
    
    let url: String
    let placeholder: Placeholder
    
    @StateObject private var imageLoader: ImageLoader
    
    /// Initialize a new cached image view.
    /// - Parameters:
    ///   - url: A `String` representing the URL to fetch the image from.
    ///   - placeholder: A `View` to be displayed while the image is being fetched.
    init(url: String, placeholder: Placeholder) {
        self.url = url
        self.placeholder = placeholder
        self._imageLoader = StateObject(wrappedValue: ImageLoader(url: url))
    }
    
    var body: some View {
        Group {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                placeholder
            }
        }
        .onAppear {
            imageLoader.loadImage()
        }
    }
}
