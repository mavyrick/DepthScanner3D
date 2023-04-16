//
//  DepthScanner3DApp.swift
//  DepthScanner3D
//
//  Created by Josh Sorokin on 2023. 04. 16..
//

import SwiftUI

@main
struct DepthScanner3DApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
