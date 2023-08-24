//
//  FoodForm.swift
//  MealMinder
//
//  Created by Muhammad Rizki Siraj on 20/08/23.
//

import SwiftUI

struct FoodForm: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var mealsHistory: [Meal]
    
    @State private var selectedDate = Date()
    @State private var mealTime = Meal.MealType.breakfast
    @State private var imageName: String = Meal.ImageTitle.almondMilk.rawValue
    @State private var food:String = "Nasi Goreng, teh manis..."
    
    var rows = [GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            List {
                DatePicker(selection: $selectedDate, in: ...Date(), displayedComponents: .date) {
                    Text("Select Date").bold()
                }
                VStack(alignment: .leading) {
                    Text("Meal Time").bold()
                    Picker("Meal Time", selection: $mealTime) {
                        ForEach(Meal.MealType.allCases, id: \.self) {
                            meal in
                            Text("\(meal.rawValue)").tag(meal)
                        }
                    }
                    .pickerStyle(.segmented)
                    .controlSize(.large)
                }
                VStack(alignment: .leading) {
                    Text("Icons").bold()
                    HStack(alignment: .top) {
                        ForEach(Meal.ImageTitle.allCases, id: \.self) { imageTitle in
                            Group {
                                if (imageTitle.rawValue == imageName) {
                                    Image("\(imageTitle.rawValue)")
                                        .resizable()
                                        .cornerRadius(2)
                                        .padding(2)
                                        .frame(width: 80, height: 80)
                                        .background(.indigo)
                                        .cornerRadius(4)
                                } else {
                                    Image("\(imageTitle.rawValue)")
                                        .resizable()
                                        .frame(width: 80, height: 80)
                                        .clipped()
                                        .cornerRadius(4)
                                        .onTapGesture {
                                            imageName = imageTitle.rawValue
                                        }
                                }
                            }
                        }
                    }
                }
                
                TextEditor(text: $food)
                    .foregroundColor(.black)
                    .frame(minHeight: 200)
                    .listRowSeparator(.hidden, edges: .bottom)
            }
            .listStyle(.plain)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button("Done") {
                        var imageNameDummy: Meal.ImageTitle
                        
                        switch imageName {
                        case Meal.ImageTitle.bibimbap.rawValue:
                            imageNameDummy = Meal.ImageTitle.bibimbap
                        case Meal.ImageTitle.almondMilk.rawValue:
                            imageNameDummy = Meal.ImageTitle.almondMilk
                        default:
                            imageNameDummy = Meal.ImageTitle.pancakes
                        }
                        
                        let newMeal = Meal(name: food, type: mealTime, date: Date(), imageName: imageNameDummy)
                        mealsHistory.append(newMeal)
//                        print(scheduleAndGoalModal.mealsHistory)
                        dismiss()
                        
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .navigationTitle("What did you eat?")
        }
    }
}

struct FoodForm_Previews: PreviewProvider {
    
    
    static var previews: some View {
        FoodForm(mealsHistory: .constant([]))
    }
}
