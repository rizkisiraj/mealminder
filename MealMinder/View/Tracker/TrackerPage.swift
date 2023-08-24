//
//  TrackerPage.swift
//  MealMinder
//
//  Created by Muhammad Rizki Siraj on 15/08/23.
//

import SwiftUI

struct TrackerPage: View {
    
    init() {
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.systemIndigo]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.systemIndigo]
    }
    @State private var isEditingGoals: Bool = false
    @EnvironmentObject var scheduleAndGoal: ScheduleGoalModel
    
    var body: some View {
        
        NavigationView {
            if scheduleAndGoal.goal == 0 {
                VStack {
                    Image(systemName: "fork.knife")
                        .resizable()
                        .frame(width: 32.0, height: 41)
                        .foregroundStyle(.secondary)
                    
                    Text("You haven't set up your eating schedule")
                        .font(.body)
                        .padding(.top, 16)
                        .padding(.bottom, 16)
                        .foregroundStyle(.secondary)
                    Button("Create Schedule") {
                        isEditingGoals.toggle()
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .fullScreenCover(isPresented: $isEditingGoals) {
                        ScheduleQuestion(isEditingGoals: $isEditingGoals)
                    }
                }
                    .navigationTitle("Journal")
                    .padding()
                    .tint(.indigo)
            } else {
                TrackerPage_With_Data_()
            }
            
        }
    }
}

struct TrackerPage_Previews: PreviewProvider {
    static var previews: some View {
        TrackerPage()
            .previewDevice("iPhone 14")
            .environmentObject(ScheduleGoalModel())
    }
}
