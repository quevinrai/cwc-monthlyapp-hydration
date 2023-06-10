//
//  HealthKitManager.swift
//  CWC MonthlyApp Hydration
//
//  Created by Quevin Bambasi on 5/31/23.
//

import Foundation
import HealthKit

class HealthKitManager {
    func setUpHealthRequest(healthStore: HKHealthStore, readWaterValues: @escaping () -> Void) {
        if HKHealthStore.isHealthDataAvailable() {
            // Specify data we want to get
            let waterCount = HKQuantityType(.dietaryWater)
            
            // Trigger Health app permission popup that will ask to give permission
            healthStore.requestAuthorization(toShare: [waterCount], read: [waterCount]) { success, error in
                if success {
                    readWaterValues()
                } else if error != nil {
                    // Handle error here
                }
            }
        }
    }
    
    func readWaterCount(healthStore: HKHealthStore, completion: @escaping (HKStatistics) -> Void) {
        let waterQuantityType = HKQuantityType(.dietaryWater) // Data we want to read from HealthKit
        let userLocale = Locale(identifier: "en-US")
        let now = Date()
        let formatter = DateFormatter()
        formatter.locale = userLocale
        formatter.setLocalizedDateFormatFromTemplate("hh mm a")
        var cal = Calendar(identifier: .gregorian)
        cal.locale = userLocale
        
        let startOfDay = cal.startOfDay(for: now)
        let anchorDate = cal.date(bySettingHour: 12, minute: 0, second: 0, of: now)
        
        var interval = DateComponents()
        interval.minute = 1
        
        let query = HKStatisticsCollectionQuery(quantityType: waterQuantityType, quantitySamplePredicate: nil, options: [.cumulativeSum, .separateBySource], anchorDate: anchorDate!, intervalComponents: interval)
        
        query.initialResultsHandler = { query, results, error in
            guard let results = results else { return }
            
            results.enumerateStatistics(from: startOfDay, to: now) { result, stop in
                completion(result)
            }
        }
        
        // Execute query
        healthStore.execute(query)
    }
    
    func saveWaterCount(healthStore: HKHealthStore, ounces: Double) {
        let waterQuantityType = HKQuantityType(.dietaryWater)
        
        let quantityUnit = HKUnit(from: "fl_oz_us")
        let quantityAmount = HKQuantity(unit: quantityUnit, doubleValue: ounces)
        let now = Date()
        
        let sample = HKQuantitySample(type: waterQuantityType, quantity: quantityAmount, start: now, end: now)
        let correlationType = HKCorrelationType(.food)
        
        let waterCorrelationForWaterAmount = HKCorrelation(type: correlationType, start: now, end: now, objects: [sample])
        
        healthStore.save(waterCorrelationForWaterAmount) { success, error in
            if let error = error {
                print(error.localizedDescription)
                return
            } else {
                print("Water data was successfully saved!")
            }
        }
    }
}
