//
//  MealDetail.swift
//  MealMinder
//
//  Created by Muhammad Rizki Siraj on 20/08/23.
//

import SwiftUI

struct MealDetail: View {
    var meal: Meal?
    
    var body: some View {
        if meal == nil {
            VStack {
                Image(systemName: "x.square")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.secondary)
                Text("You haven't added a meal yet")
                    .padding(.top, 16)
                    .foregroundColor(.secondary)
            }
        } else {
            VStack(spacing: 16) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(meal?.type.rawValue ?? "Lunch")
                            .font(.largeTitle)
                            .bold()
                        
                        Text(meal?.date ?? Date(), style: .date)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Button {
                        print("s")
                    } label: {
                        HStack {
                            Image(systemName: "pencil")
                            Text("Edit")
                        }
                    }
                    .buttonStyle(.bordered)
                    .tint(.indigo)
                }
                VStack(spacing: 16) {
                    meal?.image
                        .resizable()
                        .aspectRatio(1/1, contentMode: .fit)
                        .cornerRadius(12)
                        .padding(.horizontal, 24)
                    Text(meal?.name ?? "")
                        .font(.title3)
                }
                Spacer()
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct MealDetail_Previews: PreviewProvider {
    static var previews: some View {
        MealDetail()
    }
}
