//
//  HealthTrackerApp.swift
//  HealthTracker
//
//  Created by Yuliya Lapatsina on 12/08/2024.
//

import SwiftUI

@main
struct HealthTrackerApp: App {
    let hkManager = HealthKitManager()
    
    var body: some Scene {
        WindowGroup {
            HKPermissionPrimingView()
                .environment(hkManager)
        }
    }
}
