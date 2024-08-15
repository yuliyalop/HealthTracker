//
//  HKPermissionPrimingView.swift
//  HealthTracker
//
//  Created by Yuliya Lapatsina on 15/08/2024.
//

import SwiftUI

struct HKPermissionPrimingView: View {
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
                
            }
            .buttonStyle(.borderedProminent)
            .tint(.pink)
        }
        .padding(30)
    }
}

#Preview {
    HKPermissionPrimingView()
}
