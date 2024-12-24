//
//  PhotoFavoritesList.swift
//  DAMII_EF
//
//  Created by DAMII on 23/12/24.
//

import SwiftUI

struct PhotoFavoritesList: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Imagen.autor, ascending: true)],
        animation: .default
    ) private var images: FetchedResults<Imagen>
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: PhotoViewModel
    @State var imagen: Imagen? = nil
    
    var body: some View {
        if images.isEmpty {
            Text("Sección de Favoritos vacía")
        } else {
            List {
                ForEach(images) { item in
                    HStack {
                        if let imageUrl = item.full, let url = URL(string: imageUrl) {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            } placeholder: {
                                ProgressView()
                            }
                            VStack(alignment: .leading) {
                                Text(item.descripcion ?? "Sin descripción")
                                    .font(.headline)
                                Text(item.autor ?? "Sin Autor")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .swipeActions {
                        Button(role: .destructive, action: {
                            imagen = item
                        }, label: {
                            Image(systemName: "trash")
                        })
                    }
                }
            }
            .navigationTitle("Favoritos")
            .alert(item: $imagen) { item in
                Alert(
                    title: Text("Eliminar de Favoritos?"),
                    message: Text("Esta acción no se puede deshacer"),
                    primaryButton: .destructive(Text("Eliminar")) {
                        viewModel.deletePhoto(image: item)
                    },
                    secondaryButton: .cancel()
                )
            }
        }
        
    }
}
