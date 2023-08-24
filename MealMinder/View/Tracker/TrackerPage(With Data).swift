//
//  TrackerPage(With Data).swift
//  MealMinder
//
//  Created by Muhammad Rizki Siraj on 18/08/23.
//

import SwiftUI

struct TrackerPage_With_Data_: View {
    @EnvironmentObject var scheduleAndGoalData: ScheduleGoalModel
    @State private var isAddingFood = false
    @State private var isEditingSchedule = false
    
    var filteredMeals:  [Meal?] {
        var todayMealArray: [Meal] {
            
            if scheduleAndGoalData.mealsHistory.isEmpty {
                return []
            }
            
            return scheduleAndGoalData.mealsHistory.filter { meal in Calendar.current.isDate(meal.date, inSameDayAs: Date())
            }
            
        }
        
        if(todayMealArray.isEmpty) {
            return [nil, nil, nil]
        }
        
        let breakfastMeal = todayMealArray.first(where: { $0.type.rawValue == Meal.MealType.breakfast.rawValue }) ?? nil

        let lunchMeal = todayMealArray.first(where: { $0.type.rawValue == Meal.MealType.lunch.rawValue }) ?? nil

        let dinnerMeal = todayMealArray.first(where: { $0.type.rawValue == Meal.MealType.dinner.rawValue }) ?? nil
        return [breakfastMeal, lunchMeal, dinnerMeal]
    }
    
    var body: some View {
        //        ScrollView {
        List {
            Section{
                VStack(spacing: 16) {
                    Text("Time remaining for the Next Meal")
                        .foregroundColor(.indigo)
                    Countdown(scheduleAndGoal: scheduleAndGoalData)
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.indigo)
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .foregroundColor(.secondary)
                            .frame(width: .infinity, height: 5)
                        Rectangle()
                            .foregroundColor(.indigo)
                            .frame(width: 124, height: 5)
                    }
                    .frame(width: .infinity, height: 5)
                    .cornerRadius(7)
                    HStack(alignment: .center) {
                        Button("Edit Schedule") {
                            isEditingSchedule = true
                        }
                        .buttonStyle(.bordered)
                        .tint(.indigo)
                        .controlSize(.large)
                        
                        Spacer()
                        Button("Log food") {
                            isAddingFood = true
                        }
                        .controlSize(.large)
                        .buttonStyle(.borderedProminent)
                    }
                }
                .padding(.all,16)
                .background(.white)
                .cornerRadius(16)
            }
            
            TodayMealList(meals: filteredMeals, mealHours: [scheduleAndGoalData.breakfast, scheduleAndGoalData.lunch, scheduleAndGoalData.dinner]).id(UUID())
            
            Section {
                VStack(alignment: .center, spacing: 16) {
                    Text("3")
                        .font(.largeTitle)
                        .foregroundColor(.indigo)
                        .bold()
                        .frame(width: 75, height: 75, alignment: .center)
                        .padding()
                        .background(Color("indigoSoft"))
                        .cornerRadius(100)
                        .overlay(
                            Circle()
                            .stroke(Color.indigo, lineWidth: 8)
//                            .padding(6)
                        )
                    Text("You have been eating regularly for 3 straight days.")
                        .multilineTextAlignment(.center)
                        .bold()
                }
                .padding()
                .alignmentGuide(.listRowSeparatorLeading) { viewDimensions in

                    // 2
                    return 0
                }
                NavigationLink(destination: HistoryView()
                    .environmentObject(scheduleAndGoalData)) {
                    Text("Check out your history")
                        .font(.callout)
                }
                .buttonStyle(.bordered)
            }
            .padding()
        }
        .navigationTitle("Journal")
        .background(.ultraThinMaterial)
        .sheet(isPresented: $isAddingFood) {
            FoodForm(mealsHistory: $scheduleAndGoalData.mealsHistory)
        }
        .sheet(isPresented: $isEditingSchedule) {
            ScheduleEditor()
                .presentationDetents([.height(300)])
                .presentationDragIndicator(.visible)
        }
    }
}

struct TrackerPage_With_Data__Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TrackerPage_With_Data_()
                .environmentObject(ScheduleGoalModel())
        }
        
    }
}
