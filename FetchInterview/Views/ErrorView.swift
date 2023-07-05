//
//  ErrorView.swift
//  FetchInterview
//
//  Created by Russell Weber on 2023-06-30.
//

import SwiftUI

/// `ErrorView` is a `View` that displays a user-friendly message when a network error occurs.
///
/// This component is designed to provide a meaningful context for the error and a clear path to recovery.
///
/// # Example
/// ```
/// ErrorView(error: .networkProblem) {
///     // Retry action
/// }
/// ```
struct ErrorView: View {
    /// The `NetworkError` object to display.
    @State var error: NetworkError
    
    /// The action to retry the request after the error occurred.
    var retryAction: (() -> Void)
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 16.0) {
                Spacer()
                Image(systemName: "wifi.exclamationmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.red)
                    .frame(maxWidth: geometry.size.width / 3)
                VStack(alignment: .center) {
                    Text(error.description)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    Button(action: retryAction) {
                        Text("Retry")
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.top)
                    .padding(.horizontal, 20)
                }
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity)
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: .networkProblem) {}
    }
}
