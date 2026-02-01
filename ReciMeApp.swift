//
//  ReciMeApp.swift
//  ReciMe
//
//  Created by Kadir Yildiz on 31/1/2026.
//

import SwiftUI
import CoreData

@main
struct ReciMeApp: App {
    @StateObject private var vm = RecipeListViewModel()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                Recipes()
                    .navigationBarHidden(true)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .environmentObject(vm)
        }

    }
}
