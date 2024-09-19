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

}
