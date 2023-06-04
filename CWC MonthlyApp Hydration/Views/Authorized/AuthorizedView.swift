//
//  AuthorizedView.swift
//  CWC MonthlyApp Hydration
//
//  Created by Quevin Bambasi on 6/3/23.
//

import SwiftUI

struct AuthorizedView: View {
    @EnvironmentObject var vm: HealthKitViewModel
    
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
    }
}

struct AuthorizedView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorizedView()
            .environmentObject(HealthKitViewModel())
    }
}
