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
                topHeader()
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
    
    private func topHeader() -> some View {
        HStack {
            Text("Favorite Places")
                .font(.title)
            Spacer()
            
            Button {
                viewModel.showAddSheet.toggle()
            } label: {
                Image(systemName: "plus.circle.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.primary)
                    .tint(Color.orange.gradient)
            }
            .sheet(isPresented: $viewModel.showAddSheet, onDismiss: {
                viewModel.fetchPlaces()
            }) {
                AddNewPlaceView()
                    .presentationDetents([.large])
                    .presentationDragIndicator(.hidden)
                    .presentationCornerRadius(20)
                    .presentationBackground(.ultraThinMaterial)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}
