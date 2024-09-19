//
//  WeightLineChart.swift
//  HealthTracker
//
//  Created by Yuliya Lapatsina on 19/09/2024.
//

import SwiftUI
import Charts

struct WeightLineChart: View {
    var selectedStat: HealthMetricContext = .weight
    var chartData: [HealthMetric]
    
//    var avgWeightCount: Double {
//        guard !chartData.isEmpty else { return 0 }
//        let totalSteps = chartData.reduce(0) { $0 + $1.value }
//        return totalSteps/Double(chartData.count)
//    }
    
    var body: some View {
        VStack {
            NavigationLink(value: selectedStat) {
                HStack {
                    VStack(alignment: .leading) {
                        Label("Weight", systemImage: "figure")
                            .font(.title3.bold())
                            .foregroundStyle(.indigo)
                        Text("Avg: 180 lbs")
                            .font(.caption)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                }
            }
            .padding(.bottom, 12)
            .foregroundStyle(.secondary)
            
            Chart {
                ForEach(chartData) { weight in
                    LineMark(x: .value("Day", weight.date, unit: .day), y: .value("Value", weight.value))
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.secondarySystemBackground)))
    }
}

#Preview {
    WeightLineChart(chartData: MockData.weights)
}
