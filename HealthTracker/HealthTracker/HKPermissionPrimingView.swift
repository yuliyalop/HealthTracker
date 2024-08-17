//
//  HKPermissionPrimingView.swift
//  HealthTracker
//
//  Created by Yuliya Lapatsina on 15/08/2024.
//

import SwiftUI
import HealthKitUI

struct HKPermissionPrimingView: View {
    @Environment(HealthKitManager.self) private var hkManager
    @Environment(\.dismiss) private var dismiss
    @State private var isShowingHKPermissions = false
    @Binding var hasSeen: Bool
    
    var description = """
    This app displays your step and weight data in interactive charts.
    
    You can also add new step and weight data to Apple Health from this app. Your data is private and secure.
    """
    
    var body: some View {
        VStack(spacing: 130) {
            VStack(alignment: .leading, spacing: 12) {
                Image(.healthIcon)
                    .resizable()
                    .frame(width: 90, height: 90)
                    .shadow(color: .gray.opacity(0.3), radius: 16)
                Text("Apple Health Integration")
                    .font(.title2).bold()
                
                Text(description)
                    .foregroundStyle(.secondary)
            }
            
            Button("Connect Apple Health") {
                isShowingHKPermissions = true
            }
            .buttonStyle(.borderedProminent)
            .tint(.pink)
        }
        .padding(30)
        .interactiveDismissDisabled()
        .onAppear { hasSeen = true }
        .healthDataAccessRequest(store: hkManager.store,
                                 shareTypes: hkManager.types,
                                 readTypes: hkManager.types,
                                 trigger: isShowingHKPermissions) { result in
            switch result {
            case .success(_):
                dismiss()
            case .failure(_):
                //TODO: Error handling
                dismiss()
            }
        } 
    }
}

#Preview {
    HKPermissionPrimingView(hasSeen: .constant(false))
        .environment(HealthKitManager())
}
