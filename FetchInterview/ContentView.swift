//
//  ContentView.swift
//  FetchInterview
//
//  Created by Russell Weber on 2023-06-29.
//

import SwiftUI

struct ContentView: View {
    // State property to control the visibility of the dropdown
    var body: some View {
        VStack {
            let listVM = MealListViewModel()
            MealListView(viewModel: listVM)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
