//
//  AuthorizedView.swift
//  CWC MonthlyApp Hydration
//
//  Created by Quevin Bambasi on 6/3/23.
//

import SwiftUI

struct AuthorizedView: View {
    @EnvironmentObject var vm: HealthKitViewModel
    @State var progressValue: Double = 0.0
    @State var isInfoPresented = false
    @State var isSettingsPresented = false
    
    var dateToday: String {
        let userLocale = Locale.autoupdatingCurrent
        var gregorianCalendar = Calendar(identifier: .gregorian)
        gregorianCalendar.locale = userLocale
        
        let dateComponents = gregorianCalendar.dateComponents(
            [.month,
             .day,
             .year
            ],
            from: Date()
        )
        
        let month = Calendar.current.monthSymbols[(dateComponents.month ?? 1) - 1]
        let day = dateComponents.day
        let year = dateComponents.year
        
        return "\(month) \(day ?? 0), \(year ?? 0)"
    }
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    Text(dateToday)
                        .font(.largeTitle)
                        .bold()
                    Text("Here is your fluid intake")
                        .font(.callout)
                        .italic()
                    
                    Text("\(vm.userWaterCount)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                
                ZStack {
                    CircularProgressView(progressValue: $progressValue)
                    VStack {
                        HStack {
                            Text("\(Int(progressValue * 100))%")
                            Image(systemName: "drop.fill")
                                .foregroundColor(.blue)
                        }
                        .font(.largeTitle)
                        .bold()
                        
                        Text("of daily goal")
                            .font(.caption)
                    }
                }
                
                Text("1,000 mL / 3,700 mL")
                    .bold()
            }
            
            HStack {
                Button {
                    isInfoPresented = true
                } label: {
                    Image(systemName: "info.circle")
                        .font(.title)
                }
                .foregroundColor(.black)
                
                Spacer()
                
                Button(action: {
                    
                }, label: {
                    HStack {
                        Text("Add Intake")
                        Image(systemName: "plus.circle")
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(LinearGradient(colors: [
                                Color(UIColor(red: 45/255, green: 133/255, blue: 227/255, alpha: 1)),
                                Color(UIColor(red: 120/255, green: 172/255, blue: 227/255, alpha: 1))
                            ], startPoint: UnitPoint.leading, endPoint: UnitPoint.trailing))
                    )
                })
                
                Spacer()
                
                Button {
                    isSettingsPresented = true
                } label: {
                    Image(systemName: "gearshape")
                        .font(.title)
                }
                .foregroundColor(.black)

            }
            .padding(.horizontal)
        }
        .padding()
        .sheet(isPresented: $isInfoPresented) {
            InfoSheet()
        }
        .sheet(isPresented: $isSettingsPresented) {
            SettingsSheet()
        }
    }
}

struct AuthorizedView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorizedView()
            .environmentObject(HealthKitViewModel())
    }
}
