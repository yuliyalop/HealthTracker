//
//  DashboardView.swift
//  HealthTracker
//
//  Created by Yuliya Lapatsina on 12/08/2024.
//

import SwiftUI
import Charts

enum HealthMetricContext: CaseIterable, Identifiable {
    case steps, weight
    var id: Self { self }
    
    var title: String {
        switch self {
        case .steps:
            return "Steps"
        case .weight:
            return "Weight"
        }
    }
}

struct DashboardView: View {
    @Environment(HealthKitManager.self) private var hkManager
    @AppStorage("hasSeenPermissionPriming") private var hasSeenPermissionPriming = false
    @State private var isShowingPermissionPriming = false
    @State private var selectedStat: HealthMetricContext = .steps
    
    private var avgStepCount: Double {
        guard !hkManager.stepsData.isEmpty else { return 0 }
        let totalSteps = hkManager.stepsData.reduce(0) { $0 + $1.value }
        return totalSteps/Double(hkManager.stepsData.count)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    Picker("Selected Stat", selection: $selectedStat) {
                        ForEach(HealthMetricContext.allCases) { metric in
                            Text(metric.title)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    StepBarChart(selectedStat: selectedStat, chartData: hkManager.stepsData )
                    
                    StepPieChart(chartData: ChartMath.averageWeekdayCount(for: hkManager.stepsData))

                }
            }
            .padding()
            .task {
                await hkManager.fetchStepCount()
                isShowingPermissionPriming = !hasSeenPermissionPriming
            }
            .navigationTitle("Dashboard")
            .navigationDestination(for: HealthMetricContext.self) { metric in
                HealthDataListView(metric: metric)
            }
            .sheet(isPresented: $isShowingPermissionPriming) {
                HKPermissionPrimingView(hasSeen: $hasSeenPermissionPriming)
            }
        }
        .tint(selectedStat == .steps ? .pink : .indigo)
    }
}

#Preview {
    DashboardView()
        .environment(HealthKitManager())
}
