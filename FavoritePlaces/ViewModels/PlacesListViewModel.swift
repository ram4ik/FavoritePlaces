//
//  PlacesListViewModel.swift
//  FavoritePlaces
//
//  Created by Ramill Ibragimov on 28.05.2023.
//

import Foundation
import SwiftUI
import UIKit

class PlacesListViewModel: ObservableObject {
    @Published var places = [PlaceViewModel]()
    @Published var showAddSheet = false
    
    init() {
        fetchPlaces()
    }
    
    func fetchPlaces() {
        places = PlaceViewModel.sampleData
    }
}
