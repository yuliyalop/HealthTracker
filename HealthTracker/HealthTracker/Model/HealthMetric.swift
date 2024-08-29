//
//  HealthMetric.swift
//  HealthTracker
//
//  Created by Yuliya Lapatsina on 19/08/2024.
//

import Foundation

struct HealthMetric: Identifiable {
    let id = UUID()
    let date: Date
    let value: Double
    
    static var mockData: [HealthMetric] {
        var array: [HealthMetric] = []
        
        for i in 0..<28 {
            let metric = HealthMetric(
                date: Calendar.current.date(byAdding: .day, value: -i, to: .now)!,
                value: .random(in: 4_000...20_000))
            
            array.append(metric)
        }
        
        return array 
    }
}
