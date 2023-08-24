//
//  SwiftUIView.swift
//  MealMinder
//
//  Created by Muhammad Rizki Siraj on 22/08/23.
//

import SwiftUI

struct TodayMealList: View {
    @State var meals: [Meal?]
    @State var mealHours: [DateComponents]
    
    var body: some View {
        Section{
            breakfastCardView(meal: $meals[0], acuanJam: $mealHours[0], mealType: Meal.MealType.breakfast)
            breakfastCardView(meal: $meals[1], acuanJam: $mealHours[1], mealType: Meal.MealType.lunch)
            breakfastCardView(meal: $meals[2], acuanJam: $mealHours[2], mealType: Meal.MealType.dinner)
        } header: {
            Text("Meals")
                .textCase(.none)
                .font(.headline)
                .foregroundColor(.indigo)
                .listRowInsets(EdgeInsets())
                .padding(.top, 24)
                .padding(.bottom, 4)
        }
        .listRowSeparator(.hidden)
    }
}

struct breakfastCardView: View {
    @Binding var meal:Meal?
    @Binding var acuanJam: DateComponents
    @State var mealType: Meal.MealType
    
    var body: some View {
        if(meal != nil) {
            NavigationLink(destination: MealDetail(meal: meal)) {
                HStack(spacing: 10) {
                    Image(systemName: "checkmark")
                        .padding()
                        .background(Color("greenCircle"))
                        .clipShape(Circle())
                        .foregroundColor(.green)
                    
                    Text("\(mealType.rawValue)")
                    
                    Spacer()
                    Text("\(acuanJam.hour ?? 0):\(acuanJam.minute ?? 0)")
                }
                .padding(.vertical, 8)
            }.buttonStyle(.plain)
                .listRowBackground(
                    Rectangle()
                        .fill(Color("greenCard"))
                        .cornerRadius(12)
                        .padding(.vertical,4)
                )
        } else {
            let dateNow = Date()
            let dateAcuan = Calendar.current.date(bySettingHour: acuanJam.hour!, minute: acuanJam.minute!, second: 0, of: Date())!
            
            if(dateNow > dateAcuan) {
                NavigationLink(destination: MealDetail()) {
                    HStack(spacing: 10) {
                        Image(systemName: "xmark")
                            .padding()
                            .background(Color("redCircle"))
                            .clipShape(Circle())
                            .foregroundColor(.red)
                        
                        Text("\(mealType.rawValue)")
                        
                        Spacer()
                        Text("\(acuanJam.hour ?? 0):\(acuanJam.minute ?? 0)")
                    }
                    .padding(.vertical, 8)
                }.buttonStyle(.plain)
                    .listRowBackground(
                        Rectangle()
                            .fill(Color("redCard"))
                            .cornerRadius(12)
                            .padding(.vertical,4)
                    )
            } else {
                NavigationLink(destination: MealDetail()) {
                    HStack(spacing: 10) {
                        Image(systemName: "frying.pan")
                            .frame(width: 19, height: 19)
                            .padding()
                            .background(Color(red: 0.93, green: 0.93, blue: 0.98))
                            .clipShape(Circle())
                            .foregroundColor(.indigo)
                        
                        Text("\(mealType.rawValue)")
                        
                        Spacer()
                        Text("\(acuanJam.hour ?? 0):\(acuanJam.minute ?? 0)")
                    }
                    .padding(.vertical, 8)
                }.buttonStyle(.plain)
                    .listRowBackground(
                        Rectangle()
                            .fill(Color.white)
                            .cornerRadius(12)
                            .padding(.vertical,4)
                    )
            }
        }
    }
}

struct TodayMealList_Previews: PreviewProvider {
    var mealsObject: TodayMeal = TodayMeal(
        breakfast: Meal(name: "Nasi Goreng", type: Meal.MealType.breakfast, date: Date(), imageName: Meal.ImageTitle.bibimbap),
        lunch: Meal(name: "Nasi Goreng", type: Meal.MealType.lunch, date: Date(), imageName: Meal.ImageTitle.bibimbap),
        dinner: Meal(name: "Nasi Goreng", type: Meal.MealType.dinner, date: Date(), imageName: Meal.ImageTitle.bibimbap)
    )
    
    static var previews: some View {
        List {
            TodayMealList(meals: [Meal(name: "Nasi Goreng", type: Meal.MealType.breakfast, date: Date(), imageName: Meal.ImageTitle.bibimbap),
                Meal(name: "Nasi Goreng", type: Meal.MealType.lunch, date: Date(), imageName: Meal.ImageTitle.bibimbap),
                Meal(name: "Nasi Goreng", type: Meal.MealType.dinner, date: Date(), imageName: Meal.ImageTitle.bibimbap)
            ], mealHours: [ScheduleGoalModel().breakfast, ScheduleGoalModel().lunch, ScheduleGoalModel().dinner])
        }
    }
}

struct TodayMeal {
    var breakfast: Meal?
    var lunch: Meal?
    var dinner: Meal?
}
