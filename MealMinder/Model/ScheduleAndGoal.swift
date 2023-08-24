//
//  ScheduleAndGoal.swift
//  MealMinder
//
//  Created by Muhammad Rizki Siraj on 17/08/23.
//

import Foundation

final class ScheduleGoalModel: ObservableObject {
    @Published var breakfast: DateComponents = DateComponents(hour: 8, minute: 24)
    @Published var lunch: DateComponents = DateComponents(hour: 12, minute: 15)
    @Published var dinner: DateComponents = DateComponents(hour: 20, minute: 53)
    
    @Published var goal = 0
    @Published var mealsHistory: [Meal] = [Meal(name: "Nasi Goreng", type: Meal.MealType.breakfast, date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(), imageName: Meal.ImageTitle.bibimbap), Meal(name: "Nasi Goreng", type: Meal.MealType.lunch, date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(), imageName: Meal.ImageTitle.bibimbap), Meal(name: "Nasi Goreng", type: Meal.MealType.dinner, date: Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date(), imageName: Meal.ImageTitle.bibimbap)]
}
