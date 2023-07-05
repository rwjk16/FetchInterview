//
//  NavigationBarView.swift
//  FetchInterview
//
//  Created by Russell Weber on 2023-06-30.
//

import SwiftUI

/// `NavigationBarView` is a `View` component used to render a navigation bar.
struct NavigationBarView: View {
    @Binding var category: String
    
    let categories: [String]
    let isLoading: Bool
    let error: NetworkError?
    let retryAction: (() -> Void)

    var body: some View {
        HStack {
            Spacer()
            DropDownMenuView(items: categories,
                             selection: $category,
                             isLoading: isLoading,
                             error: error,
                             retryAction: retryAction)
            Spacer()
        }
        .padding()
    }
}
