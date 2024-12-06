//
//  ContentView.swift
//  DashboardView
//
//  Created by Syed Zia ur Rehman on 06/12/2024.
//
import Charts
import SwiftUI

struct ContentView: View {
    var body: some View {
        
        DashboardView()
    }
}


import SwiftUI
import Charts

struct DashboardView: View {
    let username = "Zia"
    let activityData = [
        ActivityData(name: "Swift Basics", count: 10),
        ActivityData(name: "UI/UX Design", count: 7),
        ActivityData(name: "Combine Tutorial", count: 5)
    ]

    var body: some View {
        ZStack {
            // Background Gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.purple]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                // Header
                DashboardHeader(username: username)
                
                // Metric Cards
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        MetricCard(title: "Completed", value: "24", icon: "checkmark.circle.fill", gradient: Gradient(colors: [.green, .blue]))
                        MetricCard(title: "Upcoming", value: "5", icon: "clock.fill", gradient: Gradient(colors: [.orange, .red]))
                        MetricCard(title: "Messages", value: "12", icon: "message.fill", gradient: Gradient(colors: [.purple, .pink]))
                    }
                    .padding(.horizontal)
                    .padding(.vertical)
                }
                
                // Recent Activities as Interactive Graph
                RecentActivityGraph(activityData: activityData)
                
                Spacer()
            }
            .padding(.top, 50)
        }
    }
}

// MARK: - Header Component
struct DashboardHeader: View {
    let username: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Welcome Back,")
                .font(.headline)
                .foregroundColor(.white.opacity(0.9))
            Text(username)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.2))
                .shadow(radius: 10)
        )
        .padding(.horizontal)
    }
}

// MARK: - Metric Card Component
struct MetricCard: View {
    let title: String
    let value: String
    let icon: String
    let gradient: Gradient

    var body: some View {
        VStack(spacing: 15) {
            Image(systemName: icon)
                .font(.system(size: 40))
                .foregroundColor(.white)
                .shadow(radius: 5)
            Text(value)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Text(title)
                .font(.headline)
                .foregroundColor(.white.opacity(0.8))
        }
        .frame(width: 150, height: 200)
        .background(
            LinearGradient(gradient: gradient, startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
    }
}

// MARK: - Activity Data Model
struct ActivityData: Identifiable {
    let id = UUID()
    let name: String
    let count: Int
}

// MARK: - Recent Activity Graph Component
struct RecentActivityGraph: View {
    let activityData: [ActivityData]
    @State private var selectedActivity: ActivityData? // Tracks selected activity for tooltip
    @State private var showTooltip: Bool = false // Controls tooltip visibility

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Recent Activities")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.horizontal)

            GeometryReader { geometry in
                ZStack {
                    // Chart with gesture recognizer
                    Chart(activityData) { activity in
                        BarMark(
                            x: .value("Activity", activity.name),
                            y: .value("Count", activity.count)
                        )
                        .foregroundStyle(Gradient(colors: [.blue, .green]))
                    }
                    .frame(height: 200)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white.opacity(0.2))
                            .shadow(radius: 10)
                    )
                    .padding(.horizontal)
                    .onTapGesture { location in
                        // Get the tapped point and map it to the chart data
                        let tappedIndex = Int(location.x / (geometry.size.width / CGFloat(activityData.count)))
                        if tappedIndex >= 0 && tappedIndex < activityData.count {
                            withAnimation {
                                selectedActivity = activityData[tappedIndex]
                                showTooltip = true

                                // Hide the tooltip after 0.5 seconds
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    withAnimation {
                                        showTooltip = false
                                    }
                                }
                            }
                        }
                    }

                    // Tooltip
                    if showTooltip, let activity = selectedActivity {
                        VStack(spacing: 8) {
                            Text("Activity: \(activity.name)")
                                .font(.headline)
                                .foregroundColor(.white)
                            Text("Progress: \(activity.count)")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.8))
                        }
                        .padding()
                        .background(Color.black.opacity(0.8))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white.opacity(0.5), lineWidth: 1)
                        )
                        .position(
                            // Tooltip placement logic
                            x: UIScreen.main.bounds.width / 2,
                            y: 150
                        )
                    }
                }
            }
        }
    }
}

// MARK: - Preview
struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
