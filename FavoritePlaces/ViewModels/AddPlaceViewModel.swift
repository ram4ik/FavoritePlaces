//
//  AddPlaceViewModel.swift
//  FavoritePlaces
//
//  Created by Ramill Ibragimov on 28.05.2023.
//

import Foundation
import SwiftUI
import UIKit

class AddPlaceViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var city: String = ""
    @Published var country: String = ""
    @Published var notes: String = ""
    
    @Published var showProgress: Bool = false
    
    @Published var image: Image?
    @Published var imageData: Data?
    
    func savePlace() async {
        if let data = imageData {
            CoreDataManager.shared.save(name: name, notes: notes, city: city, country: country, imageData: data)
        }
    }
    
    func getImageFor(placeName: String) async {
        let encodedName = placeName.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
        let url = URL(string: "https://source.unsplash.com/1080x1350/?\(encodedName)")!
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            await MainActor.run(body: {
                imageData = data
                image = Image(uiImage: UIImage(data: data)!)
            })
        } catch let err {
            print(err.localizedDescription)
        }
    }
}
