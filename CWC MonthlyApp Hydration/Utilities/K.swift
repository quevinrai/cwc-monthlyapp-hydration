//
//  K.swift
//  CWC MonthlyApp Hydration
//
//  Created by Quevin Bambasi on 6/5/23.
//

import Foundation

class K {
    
}

extension Date {
    var today: Date { return Date() }
}

extension Calendar {
    var gregorian: Calendar {
        var cal = Calendar(identifier: .gregorian)
        cal.locale = Locale(identifier: "en-US")
        
        return cal
    }
}
