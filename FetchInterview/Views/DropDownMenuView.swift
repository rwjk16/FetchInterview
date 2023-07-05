//
//  DropDownMenuView.swift
//  FetchInterview
//
//  Created by Russell Weber on 2023-07-04.
//

import SwiftUI

/// `DropDownMenuView` is a reusable `View` component that renders a dropdown menu.
struct DropDownMenuView: View {
    var items: [String]
    @Binding var selection: String
    var isLoading: Bool
    var error: NetworkError?
    
    let retryAction: (() -> Void)

    var body: some View {
        Menu {
            if isLoading {
                LoadingView()
            } else if let error = error {
                ErrorView(error: error) {
                    retryAction()
                }
            } else {
                ForEach(items, id: \.self) { item in
                    Button(action: {
                        selection = item
                    }) {
                        Text(item)
                    }
                }
            }
        } label: {
            Label {
                Text(selection)
                    .font(.headline)
            } icon: {
                Image(systemName: "chevron.up.chevron.down")
            }
            .frame(minWidth: 150)
        }
        .foregroundColor(.black)
        .labelStyle(.titleAndIcon)
    }
}
