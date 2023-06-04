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
    
    func readWaterCount(forToday: Date, healthStore: HKHealthStore, completion: @escaping (Double) -> Void) {
        let stepQuantityType = HKQuantityType(.dietaryWater) // Data we want to read from HealthKit
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        
        // Prepare date as predicate to read today's step count data
        // .strictStartDate allows data that I read to be within the time range specified to get exact today's step count data
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        // .cumulativeSum calculates sum of all steps recorded in a day
        // Health app shows steps recorded by the hour
        // Need to sum all of it to get the total step count
        let query = HKStatisticsQuery(quantityType: stepQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
            guard let result = result, let sum = result.sumQuantity() else {
                completion(0.0)
                return
            }
            
            // Completion contains sum of the step count converted into a double value
            completion(sum.doubleValue(for: HKUnit.literUnit(with: .milli)))
        }
        
        // Execute query
        healthStore.execute(query)
    }
}
