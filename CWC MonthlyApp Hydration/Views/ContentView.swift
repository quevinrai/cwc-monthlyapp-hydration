//
//  ContentView.swift
//  CWC MonthlyApp Hydration
//
//  Created by Quevin Bambasi on 5/24/23.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    @EnvironmentObject var vm: HealthKitViewModel
    
    var body: some View {
        VStack {
            if vm.isAuthorized {
                VStack {
                    AuthorizedView()
                    ZStack {
                        CircularProgressView()
                    }
                }
            } else {
                VStack {
                    Text("Please Authorize Health!")
                        .font(.title3)
                    
                    Button {
                        vm.healthRequest()
                    } label: {
                        Text("Authorize HealthKit")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    .frame(width: 320, height: 55)
                    .background(Color(.orange))
                    .cornerRadius(10)
                }
            }
        }
        .padding()
        .onAppear {
            vm.readStepsTakenToday()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(HealthKitViewModel())
    }
}
