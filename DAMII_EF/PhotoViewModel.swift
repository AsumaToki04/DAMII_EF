//
//  PhotoViewModel.swift
//  DAMII_EF
//
//  Created by DAMII on 23/12/24.
//

import Foundation
import CoreData

@MainActor
class PhotoViewModel: ObservableObject {
    @Published var listPhotos: [Result] = []
    @Published var isLoading: Bool = false
    var viewContext: NSManagedObjectContext
    var messageError: String? = nil
    
    @Published var full = ""
    @Published var description = ""
    @Published var autor = ""
    @Published var instagram = ""
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
    }
    
    func searchPhotos(query: String) async {
        do {
            isLoading = true
            listPhotos = try await AppServices.shared.getPhotosList(query: query)
            isLoading = false
        } catch {
            messageError = "\(error)"
            isLoading = false
        }
    }
    
    func addPhoto() {
        let nuevo = Imagen(context: viewContext)
        nuevo.id = UUID()
        nuevo.full = full
        nuevo.descripcion = description
        nuevo.autor = autor
        nuevo.instagram = instagram
        saveChanges()
    }
    
    func saveChanges() {
        do {
            try viewContext.save()
        } catch {
            print("Error al guardar cambios")
        }
    }
    
    func deletePhoto(image: Imagen) {
        viewContext.delete(image)
        saveChanges()
    }
}
