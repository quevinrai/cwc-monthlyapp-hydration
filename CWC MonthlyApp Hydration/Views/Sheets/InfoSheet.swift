//
//  InfoSheet.swift
//  CWC MonthlyApp Hydration
//
//  Created by Quevin Bambasi on 6/4/23.
//

import SwiftUI

struct InfoSheet: View {
    var body: some View {
        VStack(spacing: 30) {
            Text("Info")
                .font(.system(size: 40))
                .bold()
                .fontWeight(.bold)
            
            VStack(spacing: 10) {
                Image(systemName: "drop.fill")
                    .foregroundColor(.blue)
                Image(systemName: "ruler")
            }
            .font(.system(size: 60))
            
            Text("Everyday, we lose water through our breath, perspiration, urine and bowel movements. For our bodies to function properly, we must replenish its water supply by consuming beverages and foods that contain water. Adequate daily fluid intake is approximately:")
            
            VStack {
                Text("Men - 15.5 cups (3.7L) of fluids daily")
                Text("Women - 11.5 cups (2.7L) of fluids daily")
            }
            .bold()
            
            HStack {
                Spacer()
                Image(systemName: "figure.walk")
                    .foregroundColor(.orange)
                Spacer()
                Image(systemName: "cloud.sun")
                    .foregroundColor(.green)
                Spacer()
                Image(systemName: "cross.circle.fill")
                    .foregroundColor(.red)
                Spacer()
            }
            .font(.system(size: 60))
            
            Text("Your total fluid intake may need to be modified based on level of exercise, the environment (i.e. hot/humid weather increases sweat) and overall health.")
            
            Text("Source: Mayo Clinic")
                .font(.caption)
                .bold()
        }
        .multilineTextAlignment(.center)
        .padding()
    }
}

struct InfoSheet_Previews: PreviewProvider {
    static var previews: some View {
        InfoSheet()
    }
}
