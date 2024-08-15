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
}
