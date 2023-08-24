//
//  ScheduleRecommendation.swift
//  MealMinder
//
//  Created by Muhammad Rizki Siraj on 15/08/23.
//

import SwiftUI

struct ScheduleRecommendation: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var scheduleAndGoal: ScheduleGoalModel
    
    @Binding var isEditingGoals: Bool
    let currentDate = Date()
    
    @State private var mealsCount = 2
    @Binding var daysGoal: Int
    @State private var breakfast = Calendar.current.date(bySettingHour: 6, minute: 45, second: 0, of: Date())!
    @State private var lunch = Calendar.current.date(bySettingHour: 11, minute: 45, second: 0, of: Date())!
    @State private var dinner = Calendar.current.date(bySettingHour: 19, minute: 45, second: 0, of: Date())!

    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading){
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 42, height: 41)
                    .foregroundColor(.indigo)
                Text("Schedule Recommendation")
                    .font(.largeTitle)
                    .padding(.vertical, 16)
                Text("Here are meal schedule recommendation based on your goals and preferences")
                    .foregroundColor(.secondary)
                    .padding(.bottom, 48)
            }
            .padding(16)
            
            List {
                Section {
                    
                    
                    DatePicker("Breakfast", selection: $breakfast, displayedComponents: .hourAndMinute)
                        .foregroundColor(.indigo)
                    
                    DatePicker("Lunch", selection: $lunch, displayedComponents: .hourAndMinute)
                        .foregroundColor(.indigo)
                    
                    DatePicker("Dinner", selection: $dinner, displayedComponents: .hourAndMinute)
                        .foregroundColor(.indigo)
                    
                } header: {
                    Text("Recommended Schedule")
                        .font(.body)
                        .textCase(.none)
                        .foregroundColor(.black)
                        .padding(.bottom,16)
                        .listRowInsets(EdgeInsets())
                    
                } footer: {
                    Text("This schedule could works for you because of your crowded activities")
                        .multilineTextAlignment(.center)
                        .padding(.top,4)
                }
            }
            .environment(\.defaultMinListRowHeight, 55)
//            .padding(.horizontal, 16)
            .scrollContentBackground(.hidden)
            .scrollDisabled(true)
            .listStyle(.insetGrouped)
            
            Spacer()
            HStack {
                Button("Back") {
                    dismiss()
                }
                Spacer()
                Button("Done") {
                    isEditingGoals = false
                    scheduleAndGoal.breakfast = DateComponents(hour: getHour(date: breakfast), minute: getMinute(date: breakfast))
                    scheduleAndGoal.lunch = DateComponents(hour: getHour(date: lunch), minute: getMinute(date: lunch))
                    scheduleAndGoal.dinner = DateComponents(hour: getHour(date: dinner), minute: getMinute(date: dinner))
                    scheduleAndGoal.goal = daysGoal
                    registerNotification(mealTimeObject: scheduleAndGoal)
                }
                .buttonStyle(.borderedProminent)
                .cornerRadius(30)
            }
            .padding(16)
        }
        .navigationTitle("Goals")
        .navigationBarHidden(true)
//        .padding(.all,24)
        .padding(.top, 44)
        .background(Color(red: 0.93, green: 0.93, blue: 0.98))
    }
}

struct ScheduleRecommendation_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleRecommendation(isEditingGoals: .constant(true), daysGoal: .constant(15))
            .environmentObject(ScheduleGoalModel())
    }
}

func getHour(date: Date) -> Int {
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: date)
    return hour
}

func getMinute(date: Date) -> Int {
    let calendar = Calendar.current
    let minute = calendar.component(.minute, from: date)
    return minute
}

func registerNotification(mealTimeObject: ScheduleGoalModel) {
    let mealTimes = [mealTimeObject.breakfast, mealTimeObject.lunch, mealTimeObject.dinner]
    
    for mealTime in mealTimes {
        var dateComponents = DateComponents()
        let content = UNMutableNotificationContent()
        content.sound = UNNotificationSound.default
        content.title = "It's breakfast time!"
        content.body = "Eat your breakfast to stay fit for the rest of the day."
        
        dateComponents.calendar = Calendar.current


        dateComponents.hour = mealTime.hour  // Tuesday
        dateComponents.minute = mealTime.minute    // 14:00 hours
           
        // Create the trigger as a repeating event.
        let trigger = UNCalendarNotificationTrigger(
                 dateMatching: dateComponents, repeats: true)
        
        // Create the request
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                    content: content, trigger: trigger)


        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
           if error != nil {
              // Handle any errors.
           }
        }
    }
}
