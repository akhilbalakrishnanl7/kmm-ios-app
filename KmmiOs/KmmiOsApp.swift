//
//  KmmiOsApp.swift
//  KmmiOs
//
//  Created by Akhil.b on 13/10/23.
//

import SwiftUI
import shared

/**
 * KmmiOsApp is the entry point of the application. Here we are initializing the SDK, View and ViewModel
 */
@main
struct KmmiOsApp: App {
    
    let sdk = SpaceXSDK(databaseDriverFactory: DatabaseDriverFactory())
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: .init(sdk: sdk))
        }
    }
}
