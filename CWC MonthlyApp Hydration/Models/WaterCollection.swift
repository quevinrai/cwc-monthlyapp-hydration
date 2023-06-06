//
//  WaterCollection.swift
//  CWC MonthlyApp Hydration
//
//  Created by Quevin Bambasi on 6/5/23.
//

import Foundation

struct WaterCollection: Identifiable {
    var id: UUID
    var value: Int
    var time: String
    var drinkType: String
    
    static let example = WaterCollection(id: UUID(), value: 100, time: "12:00 AM", drinkType: "Water")
}
