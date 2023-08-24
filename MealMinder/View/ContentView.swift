//
//  ContentView.swift
//  MealMinder
//
//  Created by Muhammad Rizki Siraj on 15/08/23.
//

import SwiftUI

struct ContentView: View {
            
    var body: some View {
        TabView {
            TrackerPage()
                .tag("journal")
                .tabItem {
                    Label("Journal", systemImage: "book")
                }
            SettingsView()
                .tag("settings")
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
            
//            TrackerPage()
//                .tag("setting")
//                .tabItem {
//                    Label("Setting", systemImage: "gearshape")
//                }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
