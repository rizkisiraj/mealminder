//
//  Countdown.swift
//  MealMinder
//
//  Created by Muhammad Rizki Siraj on 21/08/23.
//

import SwiftUI

struct Countdown: View {
    @State var scheduleAndGoal: ScheduleGoalModel
    @State var timeRemaining = 0
    @State var idnonesia = ""

        let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
            Text("\(timeString(time: timeRemaining))")
//        Text("\(idnonesia)")
                        .onReceive(timer){ _ in
                            if self.timeRemaining > 0 {
                                self.timeRemaining -= 1
                            }else{
                                var hour: Int
                                var minute: Int
                                let seconds: Int = Calendar.current.component(.second, from: Date())
                                let done = setAcuanDate(mealTimesArray: [
                                    scheduleAndGoal.breakfast,
                                    scheduleAndGoal.lunch,
                                    scheduleAndGoal.dinner
                                ])
                                if done == "breakfast" {
                                    let breakfastHour = scheduleAndGoal.breakfast.hour ?? 0
                                    let breakfastMinute = scheduleAndGoal.breakfast.minute ?? 0
                                    
                                    hour = breakfastHour - Calendar.current.component(.hour, from: Date())
                                    minute = breakfastMinute - Calendar.current.component(.minute, from: Date())
                                    if(minute < 0) {
                                        minute = minute * -1
                                    }

                                } else if done == "lunch" {
                                    let lunchHour = scheduleAndGoal.lunch.hour ?? 0
                                    let lunchMinute = scheduleAndGoal.lunch.minute ?? 0
                                    hour = lunchHour - Calendar.current.component(.hour, from: Date())
                                    minute = lunchMinute - Calendar.current.component(.minute, from: Date())
                                    if(minute < 0) {
                                        minute = minute * -1
                                    }
                                } else {
                                    let dinnerHour = scheduleAndGoal.dinner.hour ?? 0
                                    let dinnerMinute = scheduleAndGoal.dinner.minute ?? 0
                                    hour = dinnerHour - Calendar.current.component(.hour, from: Date())
                                    minute =  dinnerMinute - Calendar.current.component(.minute, from: Date())
                                    if(minute < 0) {
                                        minute = minute * -1
                                    }
                                }
                                
                                if (hour < 0) {
                                    timeRemaining = 0
                                } else {
                                    timeRemaining = hour*60*60 + minute*60 - seconds-1
    //                                timeRemaining = hour
                                    idnonesia = done
                                }
                            }
                        }.onAppear {
                            var hour: Int
                            var minute: Int
                            let seconds: Int = Calendar.current.component(.second, from: Date())
                            let done = setAcuanDate(mealTimesArray: [
                                scheduleAndGoal.breakfast,
                                scheduleAndGoal.lunch,
                                scheduleAndGoal.dinner
                            ])
                            if done == "breakfast" {
                                let breakfastHour = scheduleAndGoal.breakfast.hour ?? 0
                                let breakfastMinute = scheduleAndGoal.breakfast.minute ?? 0
                                
                                hour = breakfastHour - Calendar.current.component(.hour, from: Date())
                                minute = breakfastMinute - Calendar.current.component(.minute, from: Date())
                                if(minute < 0) {
                                    minute = minute * -1
                                }

                            } else if done == "lunch" {
                                let lunchHour = scheduleAndGoal.lunch.hour ?? 0
                                let lunchMinute = scheduleAndGoal.lunch.minute ?? 0
                                hour = lunchHour - Calendar.current.component(.hour, from: Date())
                                minute = lunchMinute - Calendar.current.component(.minute, from: Date())
                                if(minute < 0) {
                                    minute = minute * -1
                                }
                            } else {
                                let dinnerHour = scheduleAndGoal.dinner.hour ?? 0
                                let dinnerMinute = scheduleAndGoal.dinner.minute ?? 0
                                hour = dinnerHour - Calendar.current.component(.hour, from: Date())
                                minute =  dinnerMinute - Calendar.current.component(.minute, from: Date())
                                if(minute < 0) {
                                    minute = minute * -1
                                }
                            }
                            
                            if (hour < 0) {
                                timeRemaining = 0
                            } else {
                                timeRemaining = hour*60*60 + minute*60 - seconds-1
//                                timeRemaining = hour
                                idnonesia = done
                            }
                        }
    }
    func timeString(time: Int) -> String {
            let hours   = Int(time) / 3600
            let minutes = Int(time) / 60 % 60
            let seconds = Int(time) % 60
            return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
        }
    func setAcuanDate(mealTimesArray: [DateComponents]) -> String {
        let breakfastHour = mealTimesArray[0].hour ?? 0
        let breakfastMinute = mealTimesArray[0].minute ?? 0
        let lunchHour = mealTimesArray[1].hour ?? 0
        let lunchMinute = mealTimesArray[1].minute ?? 0
        let dinnerHour = mealTimesArray[2].hour ?? 0
        let dinnerMinute = mealTimesArray[2].minute ?? 0
        
        let millisecondsFirstDate = Int(Date().timeIntervalSince1970)
        let breakfastMilliseconds = Int(Calendar.current.date(bySettingHour: breakfastHour, minute: breakfastMinute, second: 0, of: Date())!.timeIntervalSince1970)
        let lunchMilliseconds = Int(Calendar.current.date(bySettingHour: lunchHour, minute: lunchMinute, second: 0, of: Date())!.timeIntervalSince1970)
        let dinnerMilliseconds = Int(Calendar.current.date(bySettingHour: dinnerHour, minute: dinnerMinute, second: 0, of: Date())!.timeIntervalSince1970)

        if (millisecondsFirstDate < breakfastMilliseconds) {
            return "breakfast"
        } else if (millisecondsFirstDate < lunchMilliseconds) {
            return "lunch"
        } else if (millisecondsFirstDate < dinnerMilliseconds) {
            return "dinner"
        } else {
            return "done"
        }
    }
}

struct Countdown_Previews: PreviewProvider {
    
    static var previews: some View {
        Countdown(scheduleAndGoal: ScheduleGoalModel())
    }
}

func getTimeDifferences(nowDate: Date, acuanDate: Date) -> Int {
    let millisecondsFirstDate = Int(Date().timeIntervalSince1970)
    let millisecondsSecondDate = Int(Calendar.current.date(bySettingHour: 6, minute: 45, second: 0, of: Date())!.timeIntervalSince1970)
  
    return millisecondsFirstDate - millisecondsSecondDate
    
}

