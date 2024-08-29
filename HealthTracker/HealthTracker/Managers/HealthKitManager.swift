//
//  HealthKitManager.swift
//  HealthTracker
//
//  Created by Yuliya Lapatsina on 15/08/2024.
//

import Foundation
import HealthKit
import Observation

@Observable class HealthKitManager {
    let store = HKHealthStore()
    
    let types: Set = [HKQuantityType(.stepCount), HKQuantityType(.bodyMass)]
    
    var stepsData: [HealthMetric] = []
    var weightsData: [HealthMetric] = []
    
    func fetchStepCount() async {
        let calendar = Calendar(identifier: .gregorian)
        let today = calendar.startOfDay(for: .now)
        
        let endDate = calendar.date(byAdding: .day, value: 1, to: today)!
        let startDate = calendar.date(byAdding: .day, value: -28, to: endDate)!
        
        let queryPredicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
        let samplePredicate = HKSamplePredicate.quantitySample(type: HKQuantityType(.stepCount), predicate: queryPredicate)
        
        let everyDay = DateComponents(day:1)
        
        let sumOfStepsQuery = HKStatisticsCollectionQueryDescriptor(
            predicate: samplePredicate  ,
            options: .cumulativeSum,
            anchorDate: endDate,
            intervalComponents: everyDay)

        do {
            let stepCounts = try await sumOfStepsQuery.result(for: store)
            
            stepsData = stepCounts.statistics().map({
                .init(date: $0.startDate, value: $0.sumQuantity()?.doubleValue(for: .count()) ?? 0)
            })
        } catch {
            
        }
    }
    
    func fetchWeights() async {
        let calendar = Calendar(identifier: .gregorian)
        let today = calendar.startOfDay(for: .now)
        
        let endDate = calendar.date(byAdding: .day, value: 1, to: today)!
        let startDate = calendar.date(byAdding: .day, value: -28, to: endDate)!
        
        let queryPredicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
        let samplePredicate = HKSamplePredicate.quantitySample(type: HKQuantityType(.bodyMass), predicate: queryPredicate)
        
        let everyDay = DateComponents(day:1)
        
        let sumOfWeightQuery = HKStatisticsCollectionQueryDescriptor(
            predicate: samplePredicate  ,
            options: .mostRecent,
            anchorDate: endDate,
            intervalComponents: everyDay)


        do {
            let weights = try await sumOfWeightQuery.result(for: store)
            
            weightsData = weights .statistics().map({
                .init(date: $0.startDate, value: $0.mostRecentQuantity()?.doubleValue(for: .pound()) ?? 0)
            })
        } catch {
            
        }
    }
    
//    func addSimulatorData() async {
//        var mockSamples: [HKObject] = []
//        
//        for i in 0..<28 {
//            let stepQuantity = HKQuantity(unit: .count(), doubleValue: .random(in: 4_000...20_000))
//            let weightQuantity = HKQuantity(unit: .pound(), doubleValue: .random(in: (160 + Double(i/3)...165 + Double(i/3))))
//            
//            let startDate = Calendar.current.date(byAdding: .day, value: -i, to: .now)!
//            let endDate = Calendar.current.date(byAdding: .second, value: 1, to: startDate)!
//            
//            let stepSample = HKQuantitySample(type: HKQuantityType(.stepCount), quantity: stepQuantity, start: startDate, end: endDate)
//            let weightSample = HKQuantitySample(type: HKQuantityType(.bodyMass), quantity: weightQuantity, start: startDate, end: endDate)
//            
//            
//            mockSamples.append(stepSample)
//            mockSamples.append(weightSample)
//        }
//        
//        try! await store.save(mockSamples)
//        print("✅ Dummy data sent up")
//    }
}
