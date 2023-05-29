//
//  AddNewPlaceView.swift
//  FavoritePlaces
//
//  Created by Ramill Ibragimov on 28.05.2023.
//

import SwiftUI

struct AddNewPlaceView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel = AddPlaceViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                Text("New Favorite Place")
                    .font(.title)
                
                Group {
                    TextField("Name of the place", text: $viewModel.name)
                    TextField("City", text: $viewModel.city)
                    TextField("Country", text: $viewModel.country)
                    TextField("Notes", text: $viewModel.notes)
                }
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
                
                Spacer()
                
                if let image = viewModel.image {
                    image
                        .resizable()
                        .frame(width: 200, height: 350)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                } else {
                    Image("rotermann")
                        .resizable()
                        .blur(radius: 30)
                        .frame(width: 200, height: 350)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                Button("Get Image") {
                    Task {
                        await viewModel.getImageFor(placeName: viewModel.name)
                    }
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
                .disabled(viewModel.name.isEmpty)
                
                Spacer()
                
                HStack {
                    Button {
                        savePlace()
                    } label: {
                        Label("Save", systemImage: "doc.fill.badge.plus")
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button(role: .destructive) {
                        dismiss()
                    } label: {
                        Label("Cancel", systemImage: "x.square.fill")
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding()
            
            if viewModel.showProgress {
                Rectangle()
                    .foregroundColor(Color.secondary.opacity(0.8))
                
                ProgressView {
                    Text("Saving new place...")
                }
            }
        }
        .interactiveDismissDisabled()
    }
    
    private func savePlace() {
        viewModel.showProgress.toggle()
        Task {
            await viewModel.savePlace()
            DispatchQueue.main.async {
                dismiss()
            }
        }
    }
}

struct AddNewPlaceView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewPlaceView()
            .preferredColorScheme(.dark)
    }
}
