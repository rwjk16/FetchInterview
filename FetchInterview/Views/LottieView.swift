//
//  LottieView.swift
//  FetchInterview
//
//  Created by Russell Weber on 2023-07-05.
//
 
import SwiftUI
import Lottie

/// `LottieView` is a `UIViewRepresentable` wrapper around a `LottieAnimationView`, which allows you to include Lottie animations in a SwiftUI view hierarchy.
struct LottieView: UIViewRepresentable {
    /// The name of the Lottie file (without the file extension) to load and play.
    let lottieFile: String

    /// The underlying `LottieAnimationView` that plays the animation.
    private let animationView = LottieAnimationView()
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
 
        animationView.animation = LottieAnimation.named(lottieFile)
        animationView.contentMode = .scaleAspectFit
        animationView.play()
 
        view.addSubview(animationView)
 
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        animationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
 
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // No updates are needed, as the animation replays indefinitely while visible.
    }
}

/// `LoadingView` is a simple SwiftUI view that presents an animated loading indicator.
struct LoadingView: View {
    var body: some View {
        LottieView(lottieFile: "loading-animation")
    }
}

struct LoadingView_Preview: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
