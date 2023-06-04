//
//  HealthKitViewModel.swift
//  CWC MonthlyApp Hydration
//
//  Created by Quevin Bambasi on 6/3/23.
//

import Foundation
import HealthKit

class HealthKitViewModel: ObservableObject {
    private var healthStore = HKHealthStore()
    private var healthKitManager = HealthKitManager()
    @Published var userWaterCount = ""
    @Published var authStatus = ""
    
    init() {
        changeAuthorizationStatus()
    }
    
    func healthRequest() {
        healthKitManager.setUpHealthRequest(healthStore: healthStore) {
            self.changeAuthorizationStatus()
            self.readStepsTakenToday()
        }
    }
    
    func readStepsTakenToday() {
        healthKitManager.readWaterCount(forToday: Date(), healthStore: healthStore) { waterValue in
            // Check if step != 0.0
            // Then it will be assigned to userStepCount with a formatted zero decimal number
            if waterValue != 0.0 {
                DispatchQueue.main.async {
                    self.userWaterCount = String(format: "%.0f", waterValue)
                }
            }
        }
    }
    
    func changeAuthorizationStatus() {
        let waterQtyType = HKQuantityType(.dietaryWater)
        let status = self.healthStore.authorizationStatus(for: waterQtyType)
        
        DispatchQueue.main.async {
            switch status {
                case .notDetermined:
                    self.authStatus = "Not Determined"
                case .sharingDenied:
                    self.authStatus = "Denied"
                case .sharingAuthorized:
                    self.authStatus = "Authorized"
                @unknown default:
                    self.authStatus = ""
            }
        }
    }
}
