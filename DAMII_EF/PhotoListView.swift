//
//  PhotoListView.swift
//  DAMII_EF
//
//  Created by DAMII on 23/12/24.
//

import SwiftUI

struct PhotoListView: View {
    @StateObject var viewModel = PhotoViewModel(viewContext: PersistenceController.shared.container.viewContext)
    @State private var busqueda: String = ""
    @State private var alert: Bool = false
    
    var body: some View {
        NavigationView {
            if viewModel.isLoading {
                ProgressView("Cargando...")
            } else if let err = viewModel.messageError {
                Text("ERROR: \(err)")
                    .foregroundColor(.red)
            } else {
                VStack {
                    TextField("", text: $busqueda)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button("Buscar", action: {
                        if busqueda.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            alert = true
                        } else {
                            Task {
                                await viewModel.searchPhotos(query: busqueda)
                            }
                        }
                        
                    })
                    if viewModel.listPhotos.isEmpty {
                        Text("No se encontraron resultados o no se ingreso el parámetro de búsqueda")
                            .foregroundColor(.gray)
                    } else {
                        List {
                            ForEach(viewModel.listPhotos) { item in
                                NavigationLink(destination: PhotoDetailView(photo: item, viewModel: viewModel)) {
                                    HStack {
                                        if let imageUrl = item.urls.thumb, let url = URL(string: imageUrl) {
                                            AsyncImage(url: url) { image in
                                                image
                                                    .resizable()
                                                    .frame(width: 50, height: 50)
                                            } placeholder: {
                                                ProgressView()
                                            }
                                        } else {
                                            Image(systemName: "xmark")
                                        }
                                        VStack(alignment: .leading) {
                                            Text(item.description ?? "Sin Descripción")
                                                .lineLimit(1)
                                                .font(.headline)
                                            Text(item.user.name)
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                            Text(item.user.instagram_username ?? "Sin Instagram")
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .padding()
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: PhotoFavoritesList(viewModel: viewModel)) {
                            Text("Favoritos")
                        }
                    }
                }
                .alert(isPresented: $alert) {
                    Alert(
                        title: Text("Error de búsqueda"),
                        message: Text("Debe ingresar un parámetro de búsqueda"),
                        dismissButton: .default(Text("Aceptar"))
                    )
                }
            }
        }
    }
}
