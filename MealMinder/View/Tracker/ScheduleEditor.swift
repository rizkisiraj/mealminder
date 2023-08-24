//
//  ScheduleEditor.swift
//  MealMinder
//
//  Created by Muhammad Rizki Siraj on 20/08/23.
//

import SwiftUI

struct ScheduleEditor: View {
    @EnvironmentObject var scheduleAndGoalData: ScheduleGoalModel
    
    @State private var breakfast = Calendar.current.date(bySettingHour: 6, minute: 45, second: 0, of: Date())!
    @State private var lunch = Calendar.current.date(bySettingHour: 11, minute: 45, second: 0, of: Date())!
    @State private var dinner = Calendar.current.date(bySettingHour: 19, minute: 45, second: 0, of: Date())!
    
    var body: some View {
            List {
                DatePicker("Breakfast", selection: $breakfast, displayedComponents: .hourAndMinute)
                    .foregroundColor(.indigo)
                    .padding(.all, 8)
                
                DatePicker("Lunch", selection: $lunch, displayedComponents: .hourAndMinute)
                    .foregroundColor(.indigo)
                    .padding(.all, 8)
                
                DatePicker("Dinner", selection: $dinner, displayedComponents: .hourAndMinute)
                    .foregroundColor(.indigo)
                    .padding(.all, 8)
            }
            .onAppear {
                breakfast = Calendar.current.date(bySettingHour: scheduleAndGoalData.breakfast.hour!, minute: scheduleAndGoalData.breakfast.minute!, second: 0, of: Date())!
                lunch = Calendar.current.date(bySettingHour: scheduleAndGoalData.lunch.hour!, minute: scheduleAndGoalData.lunch.minute!, second: 0, of: Date())!
                dinner = Calendar.current.date(bySettingHour: scheduleAndGoalData.dinner.hour!, minute: scheduleAndGoalData.dinner.minute!, second: 0, of: Date())!
            }.onDisappear {
                scheduleAndGoalData.breakfast = DateComponents(hour: getHour(date: breakfast), minute: getMinute(date: breakfast))
                scheduleAndGoalData.lunch = DateComponents(hour: getHour(date: lunch), minute: getMinute(date: lunch))
                scheduleAndGoalData.dinner = DateComponents(hour: getHour(date: dinner), minute: getMinute(date: dinner))
            }
        
    }
}

struct ScheduleEditor_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleEditor()
            .environmentObject(ScheduleGoalModel())
    }
}
