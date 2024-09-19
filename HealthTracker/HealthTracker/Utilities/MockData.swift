//
//  MockData.swift
//  HealthTracker
//
//  Created by Yuliya Lapatsina on 19/09/2024.
//

import Foundation

struct MockData {
    static var steps: [HealthMetric] {
        var array: [HealthMetric] = []
        
        for i in 0..<28 {
            let metric = HealthMetric(
                date: Calendar.current.date(byAdding: .day, value: -i, to: .now)!,
                value: .random(in: 4_000...20_000))
            
            array.append(metric)
        }
        
        return array
    }
    
    static var weights: [HealthMetric] {
        var array: [HealthMetric] = []
        
        for i in 0..<28 {
            let metric = HealthMetric(
                date: Calendar.current.date(byAdding: .day, value: -i, to: .now)!,
                value: .random(in: (160 + Double(i/3)...165 + Double(i/3))))
            
            array.append(metric)
        }
        
        return array
    }
}
