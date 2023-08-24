//
//  Meal.swift
//  MealMinder
//
//  Created by Muhammad Rizki Siraj on 19/08/23.
//

import Foundation
import SwiftUI

struct Meal: Identifiable, Hashable, Codable {
    var id = UUID() // Conforming to Identifiable for list use
    var date: Date
    var name: String
    
    var type: MealType
    enum MealType: String, CaseIterable, Codable {
        case breakfast = "Breakfast"
        case lunch = "Lunch"
        case dinner = "Dinner"
    }
    
    private var imageName: ImageTitle
    var image: Image {
        Image(imageName.rawValue)
    }
    enum ImageTitle: String, CaseIterable, Codable {
        case almondMilk = "almond-milk"
        case bibimbap = "bibimbap"
        case pancakes = "pancakes"
    }
    
    internal init(name: String, type: MealType, date: Date, imageName: ImageTitle) {
            self.name = name
            self.type = type
        self.date = date
        self.imageName = imageName
    }
}
