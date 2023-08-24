//
//  ScheduleQuestion.swift
//  MealMinder
//
//  Created by Muhammad Rizki Siraj on 15/08/23.
//

import SwiftUI

struct ScheduleQuestion: View {
    
    @Environment(\.dismiss) private var dismiss
    @Binding var isEditingGoals: Bool
    @State private var mealsCount = 2
    @State private var daysGoal = 15
    let days = [15,30,60,90]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 42, height: 41)
                        .foregroundColor(.indigo)
                    Text("Add your goals")
                        .font(.largeTitle)
                        .padding(.vertical, 16)
                    Text("Adding your goals helps make personalized meal schedule recommendation that fits you")
                        .foregroundColor(.secondary)
                        .padding(.bottom, 48)
                }
                .padding(16)
                List {
                    Section {
                        Picker("Meals Count", selection: $mealsCount) {
                            ForEach(2 ..< 5) {
                                Text("\($0) Meals/day")
                            }
                        }
                        .foregroundColor(.indigo)
                        
                        Picker("Target", selection: $daysGoal) {
                            ForEach(days, id: \.self) {
                                Text("\($0) Days")
                            }
                        }
                        .foregroundColor(.indigo)
                    } header: {
                        Text("Your goal details")
                            .font(.body)
                            .textCase(.none)
                            .foregroundColor(.black)
                            .padding(.bottom,16)
                            .listRowInsets(EdgeInsets())
                        
                    }
                }
                .environment(\.defaultMinListRowHeight, 55)
                .scrollContentBackground(.hidden)
                .scrollDisabled(true)
                .listStyle(.insetGrouped)
                
                Spacer()
                HStack {
                    Button("Exit") {
                        dismiss()
                    }
                    Spacer()
                    NavigationLink(destination: ScheduleRecommendation(isEditingGoals: $isEditingGoals, daysGoal: $daysGoal)) {
                        Text("Next")
                    }
                    .buttonStyle(.borderedProminent)
                    .cornerRadius(30)
                }
                .padding(16)
            }
            .navigationTitle("Goals")
            .navigationBarHidden(true)
//            .padding(.all,24)
            .padding(.top, 42)
            .background(Color(red: 0.93, green: 0.93, blue: 0.98))
        }
    }
}

struct ScheduleQuestion_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleQuestion(isEditingGoals: .constant(true))
    }
}
