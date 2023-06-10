//
//  HealthKitViewModel.swift
//  CWC MonthlyApp Hydration
//
//  Created by Quevin Bambasi on 6/3/23.
//

import SwiftUI
import Foundation
import HealthKit

class HealthKitViewModel: ObservableObject {
    @Published var waters = [WaterCollection]()
    @Published var userWaterCount = ""
    @Published var authStatus = ""
    private var healthStore = HKHealthStore()
    private var healthKitManager = HealthKitManager()
    
    init() {
        self.changeAuthorizationStatus()
    }
    
    func healthRequest() {
        healthKitManager.setUpHealthRequest(healthStore: healthStore) {
            self.changeAuthorizationStatus()
            self.readStepsTakenToday()
        }
    }
    
    func readStepsTakenToday() {
        healthKitManager.readWaterCount(healthStore: healthStore) { result in
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en-US")
            formatter.setLocalizedDateFormatFromTemplate("hh mm a")
            
            let value = Int(result.sumQuantity()?.doubleValue(for: HKUnit.literUnit(with: .milli)) ?? 0)
            let time = formatter.string(from: result.startDate)
            
            if value != 0 {
                DispatchQueue.main.async {
                    self.waters.append(WaterCollection(
                        id: UUID(),
                        value: value,
                        time: time,
                        drinkType: ""))
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
