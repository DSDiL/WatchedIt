//
//  WatchedItApp.swift
//  WatchedIt
//
//  Created by Dilanka Weerasekara on 6/13/23.
//

import SwiftUI
import Firebase

@main
struct WatchedItApp: App {
    @StateObject var dataManager = DataManager()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView().environmentObject(dataManager)
        }
    }
}
