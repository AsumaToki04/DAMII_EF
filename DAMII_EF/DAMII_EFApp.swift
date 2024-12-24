//
//  DAMII_EFApp.swift
//  DAMII_EF
//
//  Created by DAMII on 23/12/24.
//

import SwiftUI

@main
struct DAMII_EFApp: App {
    let persistence = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            PhotoListView()
                .environment(
                    \.managedObjectContext,
                    persistence.container.viewContext
                )
        }
    }
}
