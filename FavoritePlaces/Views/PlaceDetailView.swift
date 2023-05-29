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
                placeDetailsView()
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
    
    fileprivate func placeDetailsView() -> some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Text(place.name)
                        .font(.title)
                    Spacer()
                }
                
                HStack {
                    Text(place.city)
                    Spacer()
                    Text(place.country)
                }
                .foregroundStyle(.secondary)
                
                Text(place.notes)
                
                Spacer()
                
                Map(coordinateRegion: $locationManager.region, interactionModes: .zoom)
                    .frame(height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Divider()
                
                Button(role: .destructive) {
                    CoreDataManager.shared.delete(id: place.id)
                    dismiss()
                } label: {
                    Text("Delete")
                }
                .frame(maxWidth: .infinity)
                .buttonStyle(.borderedProminent)
            }.padding(10)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: 400)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 20))
    }
}

struct PlaceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceDetailView(place: PlaceViewModel.sampleData[0])
            .preferredColorScheme(.dark)
    }
}
