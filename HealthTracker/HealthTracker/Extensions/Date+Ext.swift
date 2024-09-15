//
//  Date+Ext.swift
//  HealthTracker
//
//  Created by Yuliya Lapatsina on 15/09/2024.
//

import Foundation

extension Date {
    var weekdayInt: Int {
        Calendar.current.component(.weekday, from: self)
    }
    
    var weekdayTitle: String {
        self.formatted(.dateTime.weekday(.wide))
    }
}
