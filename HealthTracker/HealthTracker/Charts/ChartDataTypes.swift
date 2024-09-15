//
//  ChartDataTypes.swift
//  HealthTracker
//
//  Created by Yuliya Lapatsina on 15/09/2024.
//

import Foundation

struct WeekdayChartData: Identifiable {
    let id = UUID()
    let date: Date
    let value: Double
}
