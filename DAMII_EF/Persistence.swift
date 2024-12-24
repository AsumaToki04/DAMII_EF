//
//  Persistence.swift
//  DAMII_EF
//
//  Created by DAMII on 23/12/24.
//

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    
    private init() {
        container = NSPersistentContainer(name: "DAMII_EF")
        container.loadPersistentStores { _, error in
            if let err = error as? NSError {
                fatalError("No se pudo conectar a la BD: \(err.localizedDescription)")
            }
        }
    }
}
