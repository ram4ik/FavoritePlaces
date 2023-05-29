//
//  PlaceDetailView.swift
//  FavoritePlaces
//
//  Created by Ramill Ibragimov on 29.05.2023.
//

import SwiftUI
import MapKit

struct PlaceDetailView: View {
    var place: PlaceViewModel
    
    @ObservedObject var locationManager: LocationManager
    @Environment(\.dismiss) var dismiss
    
    init(place: PlaceViewModel) {
        self.place = place
        self.locationManager = LocationManager()
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            ZStack(alignment: .bottom) {
                backgroundImageView()
                // placeDetailsView()
            }
            .frame(maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            
            customBackButton()
        }
        .navigationBarBackButtonHidden()
        .onAppear() {
            locationManager.getLocationFor(address: place.city + " " + place.country)
        }
    }
    
    fileprivate func customBackButton() -> some View {
        HStack {
            Button {
                withAnimation {
                    dismiss()
                }
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title)
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .foregroundStyle(.primary)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 10))
            .contentShape(Rectangle())
            Spacer()
        }
        .padding(.leading)
    }
    
    fileprivate func backgroundImageView() -> some View {
        GeometryReader { geo in
            place.placeImage
                .resizable()
                .scaledToFill()
                .frame(width: geo.size.width, height: geo.size.height * 0.6)
            
            Spacer()
        }
    }
}

struct PlaceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceDetailView(place: PlaceViewModel.sampleData[0])
            .preferredColorScheme(.dark)
    }
}
