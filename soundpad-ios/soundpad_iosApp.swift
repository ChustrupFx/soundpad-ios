//
//  soundpad_iosApp.swift
//  soundpad-ios
//
//  Created by Victor Soares on 17/08/23.
//

import SwiftUI

@main
struct soundpad_iosApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
