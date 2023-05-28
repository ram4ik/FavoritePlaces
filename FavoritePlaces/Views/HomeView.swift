//
//  HomeView.swift
//  FavoritePlaces
//
//  Created by Ramill Ibragimov on 28.05.2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = PlacesListViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                // topHeader()
                if !viewModel.places.isEmpty {
                    // placesView()
                } else {
                    // emptyStateView()
                }
                
                Spacer()
            }
            .padding()
            .onAppear() {
                viewModel.fetchPlaces()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
