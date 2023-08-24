//
//  SettingsView.swift
//  MealMinder
//
//  Created by Muhammad Rizki Siraj on 21/08/23.
//

import SwiftUI

struct SettingsView: View {
    @State private var isOnReminder = true
    @State private var isOnGetReadyReminder = true
    @State private var minutes = 3
    @State var animationDelay = 0.1
    
    var body: some View {
        List {
            Section {
                Toggle(isOn: $isOnReminder) {
                    Text("Reminder")
                        .bold()
                }
                Toggle(isOn: $isOnGetReadyReminder) {
                    Text("Get Ready Reminder")
                        .bold()
                }
                if (isOnGetReadyReminder) {
                    Picker("Meals Count", selection: $minutes) {
                        ForEach(2 ..< 5) {
                            Text("\($0) Minutes")
                        }
                    }
                    .foregroundColor(.indigo)
                    .pickerStyle(.wheel)
                    .labelsHidden()
                    .frame(maxHeight: 150)
                }
            } header: {
                Text("Notifications")
                    .foregroundColor(.indigo)
            }
            
            Section {
                NavigationLink(destination: Text("About Us")) {
                    Text("About Us")
                        .bold()
                }
            } header: {
                Text("Acknowledgements")
                    .foregroundColor(.indigo)
            }
        }
        .navigationTitle("Settings")
        .listStyle(.grouped)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView()
        }
    }
}
