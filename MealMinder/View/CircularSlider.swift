//
//  CircularSlider.swift
//  MealMinder
//
//  Created by Muhammad Rizki Siraj on 19/08/23.
//

import SwiftUI

struct CircularSlider: View {
    @State var progress = 0.33
      let ringDiameter = 300.0
         @State var rotationAngle = Angle(degrees: 120)
     
        private func changeAngle(location: CGPoint) -> Angle{
            // Create a Vector for the location (reversing the y-coordinate system on iOS)
             let vector = CGVector(dx: location.x, dy: -location.y)
     
            // Calculate the angle of the vector
            let angleRadians = atan2(vector.dx, vector.dy)
    
            // Convert the angle to a range from 0 to 360 (rather than having negative angles)
            let positiveAngle = angleRadians < 0.0 ? angleRadians + (2.0 * .pi) : angleRadians
    
            // Update slider progress value based on angle
            progress = positiveAngle / (2.0 * .pi)
    
            return Angle(radians: positiveAngle)
        }
    
        var body: some View {
            ZStack {
                Color(hue: 0.58, saturation: 0.04, brightness: 1.0)
                    .edgesIgnoringSafeArea(.all)
    
            VStack {
                ZStack {
                       Circle()
                            .stroke(Color(hue: 0.0, saturation: 0.0, brightness: 0.9), lineWidth: 20.0)
                            .overlay() {
                               Text("\(progress, specifier: "%.2f")")
                                    .font(.system(size: 78, weight: .bold, design:.rounded))
                            }
                        Circle()
                            .trim(from: 0, to: progress)
                            .stroke(Color(hue: 0.0, saturation: 0.5, brightness: 0.9),
                                    style: StrokeStyle(lineWidth: 20.0, lineCap: .round)
                            )
                            .rotationEffect(Angle(degrees: -90))
                       Circle()
                            .fill(Color.white)
                            .shadow(radius: 3)
                            .frame(width: 21, height: 21)
                            .offset(y: -ringDiameter / 2.0)
                            .rotationEffect(rotationAngle)
                            .gesture(
                                DragGesture(minimumDistance: 0.0)
                                    .onChanged() { value in
                                    rotationAngle = changeAngle(location: value.location)
                                    }
                            )
                    }
                    .frame(width: ringDiameter, height: ringDiameter)
    
                    Spacer()
                }
                .padding(.vertical, 40)
                .padding()
            }
        }
}

struct CircularSlider_Previews: PreviewProvider {
    static var previews: some View {
        CircularSlider(progress: 0.75)
            .frame(width: 200, height: 200)
    }
}
