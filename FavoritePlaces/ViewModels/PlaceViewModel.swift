//
//  PlaceViewModel.swift
//  FavoritePlaces
//
//  Created by Ramill Ibragimov on 28.05.2023.
//

import Foundation
import SwiftUI

class PlaceViewModel: Identifiable {
    var id: UUID
    var name: String
    var city: String
    var country: String
    var notes: String
    var placeImage: Image
    
    init(id: UUID, name: String, city: String, country: String, notes: String, placeImage: Image) {
        self.id = id
        self.name = name
        self.city = city
        self.country = country
        self.notes = notes
        self.placeImage = placeImage
    }
}

extension PlaceViewModel {
    static var sampleData: [PlaceViewModel] {
        [
            .init(id: UUID(), name: "Rotermann", city: "Tallinn", country: "Estonia", notes: "Rotermanni kvartal", placeImage: Image("rotermann")),
            .init(id: UUID(), name: "Noblessner", city: "Tallinn", country: "Estonia", notes: "Noblessneri kvartal", placeImage: Image("noblessner"))
        ]
    }
}
