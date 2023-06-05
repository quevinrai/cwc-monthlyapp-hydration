//
//  SettingsSheet.swift
//  CWC MonthlyApp Hydration
//
//  Created by Quevin Bambasi on 6/4/23.
//

import SwiftUI

struct SettingsSheet: View {
    @State var selectedWaterValue = 3700
    
    var body: some View {
        VStack {
            Text("Settings")
                .font(.system(size: 40))
                .bold()
                .fontWeight(.bold)
            
            Spacer()
            
            Text("Set your goal:")
            Picker("Set your goal", selection: $selectedWaterValue) {
                ForEach(1000...5000, id: \.self) { i in
                    if (i % 100 == 0) {
                        Text("\(i) mL").tag(i)
                    }
                }
            }
            .pickerStyle(.wheel)
            
            Spacer()

            VStack {
                Button(action: {
                    
                }, label: {
                    HStack {
                        Text("Save Goal")
                        Image(systemName: "square.and.arrow.down")
                    }
                    .padding(.vertical, 15)
                    .frame(width: 200)
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(LinearGradient(colors: [
                                Color(UIColor(red: 45/255, green: 133/255, blue: 227/255, alpha: 1)),
                                Color(UIColor(red: 120/255, green: 172/255, blue: 227/255, alpha: 1))
                            ], startPoint: UnitPoint.leading, endPoint: UnitPoint.trailing))
                    )
                })
                
                Button(action: {
                    
                }, label: {
                    HStack {
                        Text("Log to Health")
                        Image(systemName: "heart.circle.fill")
                    }
                    .padding(.vertical, 15)
                    .frame(width: 200)
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(LinearGradient(colors: [
                                Color(UIColor(red: 237/255, green: 153/255, blue: 74/255, alpha: 1)),
                                Color(UIColor(red: 240/255, green: 206/255, blue: 175/255, alpha: 1))
                            ], startPoint: UnitPoint.leading, endPoint: UnitPoint.trailing))
                    )
                })
            }
            
            Spacer()
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .shadow(radius: 5)
                    .frame(height: 100)
                Text("Logging to health deletes all intake listings from this app! Intake is logged and reset automatically at the start of each day.")
                    .font(.caption)
                    .foregroundColor(.red)
                    .bold()
                    .padding(.horizontal)
            }
            
            Spacer()
        }
        .padding()
    }
}

struct SettingsSheet_Previews: PreviewProvider {
    static var previews: some View {
        SettingsSheet()
    }
}
