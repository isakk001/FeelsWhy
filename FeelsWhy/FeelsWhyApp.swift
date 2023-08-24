//
//  FeelsWhyApp.swift
//  FeelsWhy
//
//  Created by Yisak on 2023/08/19.
//

import SwiftUI

@main
struct FeelsWhyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            CalendarView()
                .environment(\.managedObjectContext, persistenceController.persistentContainer.viewContext)
        }
    }
}

