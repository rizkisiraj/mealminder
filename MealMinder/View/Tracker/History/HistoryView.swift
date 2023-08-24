//
//  HistoryView.swift
//  MealMinder
//
//  Created by Muhammad Rizki Siraj on 21/08/23.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var scheduleAndGoalData: ScheduleGoalModel
    
    var groupedHistoryMeals: [Date: [Meal]] {
        Dictionary(grouping: scheduleAndGoalData.mealsHistory, by: { Calendar.current.startOfDay(for: $0.date)})
    }
    
    var body: some View {
        List {
                ForEach(groupedHistoryMeals.keys.sorted(by: >), id: \.self) { date in
                    Section(header: Text(formatDate(date: date))
                    ) {
                        ForEach(groupedHistoryMeals[date]!, id: \.id) { item in
                            NavigationLink(destination: MealDetail(meal: item)) {
                                HStack(spacing: 10) {
                                    item.image
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(8)
//                                        .padding()
                                    
                                    Text("\(item.type.rawValue)")
                                    
                                    Spacer()
                                    Text("\(getHour(date: item.date)):\(getMinute(date: item.date))")
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
        .navigationTitle("History")
        .onAppear  {
            dump(groupedHistoryMeals)
        }
    }
        func formatDate(date: Date) -> String {
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                return dateFormatter.string(from: date)
            }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HistoryView()
                .environmentObject(ScheduleGoalModel())
        }
    }
}
