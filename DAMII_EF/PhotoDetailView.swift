//
//  PhotoDetailView.swift
//  DAMII_EF
//
//  Created by DAMII on 23/12/24.
//

import SwiftUI

struct PhotoDetailView: View {
    var photo: Result
    @ObservedObject var viewModel: PhotoViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            if let imageUrl = photo.urls.full, let url = URL(string: imageUrl) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .frame(width: 400, height: 400)
                } placeholder: {
                    ProgressView("Cargando imagen...")
                }
            } else {
                Text("Error al cargar Imagen")
            }
            List {
                Text("Descripción: \(photo.description ?? "Sin Descripción")")
                Text("Autor: \(photo.user.name)")
                Text("Instagram: \(photo.user.instagram_username ?? "Sin Instagram")")
            }
        }
        .navigationTitle("Detalles")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    viewModel.full = photo.urls.full
                    viewModel.description = photo.description ?? "Sin Descripción"
                    viewModel.autor = photo.user.name
                    viewModel.instagram = photo.user.instagram_username ?? "Instagram"
                    viewModel.addPhoto()
                }) {
                    Image(systemName: "star")
                }
            }
        }
    }
}
