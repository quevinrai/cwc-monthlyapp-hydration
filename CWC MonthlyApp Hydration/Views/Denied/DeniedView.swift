//
//  DeniedView.swift
//  CWC MonthlyApp Hydration
//
//  Created by Quevin Bambasi on 6/3/23.
//

import SwiftUI

struct DeniedView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("You have denied permissions to access your HealthKit data.")
                .padding(.bottom)
            Text("To update your permissions:")
                .padding(.bottom)
            VStack(alignment: .leading) {
                HStack(spacing: 0) {
                    Text("1. Open ")
                    
                    if let urlString = URL(string: UIApplication.openSettingsURLString) {
                        Link(destination: urlString, label: {
                            Label(title: {
                                Text("Settings")
                            }, icon: {
                                Image(systemName: "gear")
                                    .symbolRenderingMode(.multicolor)
                            })
                            .bold()
                        })
                        
                    }
                }
                HStack(spacing: 0) {
                    Text("2. Tap on ")
                    Label("Health", systemImage: "heart.square.fill")
                        .bold()
                        .symbolRenderingMode(.multicolor)
                }
                HStack(spacing: 0) {
                    Text("2. Tap on ")
                    Text("Data Access & Devices")
                        .bold()
                        .symbolRenderingMode(.multicolor)
                }
                HStack(spacing: 0) {
                    Text("2. Tap on ")
                    Label(title: {
                        Text("CWC MonthlyApp Hydration")
                    }, icon: {
                        Image(systemName: "drop.circle.fill")
                            .symbolRenderingMode(.multicolor)
                            .foregroundColor(.blue)
                        
                    })
                    .bold()
                }
                HStack(spacing: 0) {
                    Text("2. Tap on ")
                    Text("Turn On All")
                        .bold()
                }
            }
        }
    }
}

struct DeniedView_Previews: PreviewProvider {
    static var previews: some View {
        DeniedView()
    }
}
