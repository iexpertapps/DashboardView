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

// MARK: - Dashboard View
struct DashboardView: View {
    let username = "Zia"
    let activityData = [
        ActivityData(name: "Swift Basics", count: 10, description: "Learned the basics of Swift programming."),
        ActivityData(name: "UI/UX Design", count: 7, description: "Worked on user interface and experience designs."),
        ActivityData(name: "Combine Tutorial", count: 5, description: "Studied Apple's Combine framework.")
    ]

    var body: some View {
        NavigationView {
            ZStack {
                // Full-screen gradient background
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.purple]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 30) {
                    // Dashboard Header
                    DashboardHeader(username: username)

                    // Metric Cards
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            MetricCardLink(title: "Completed", value: "24", icon: "checkmark.circle.fill", gradient: Gradient(colors: [.green, .blue]), activity: activityData[0])
                            MetricCardLink(title: "Upcoming", value: "5", icon: "clock.fill", gradient: Gradient(colors: [.orange, .red]), activity: activityData[1])
                            MetricCardLink(title: "Messages", value: "12", icon: "message.fill", gradient: Gradient(colors: [.purple, .pink]), activity: activityData[2])
                        }
                        .padding(.horizontal)
                        .padding(.vertical)
                    }

                    // Recent Activities as a graph
                    RecentActivityGraph(activityData: activityData)

                    Spacer()
                }
                .padding(.top, 50)
            }
            .navigationBarTitleDisplayMode(.inline)
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

// MARK: - Metric Card Link
struct MetricCardLink: View {
    let title: String
    let value: String
    let icon: String
    let gradient: Gradient
    let activity: ActivityData

    var body: some View {
        NavigationLink(destination: ActivityDetailView(activity: activity, gradient: gradient)) {
            MetricCard(title: title, value: value, icon: icon, gradient: gradient)
        }
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
    let description: String
}

// MARK: - Activity Detail View
struct ActivityDetailView: View {
    let activity: ActivityData
    let gradient: Gradient

    var body: some View {
        ZStack {
            // Full-screen gradient background
            LinearGradient(gradient: gradient, startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Text(activity.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text("Progress: \(activity.count)")
                    .font(.title2)
                    .foregroundColor(.white)
                Text(activity.description)
                    .font(.body)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Activity Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Recent Activity Graph
struct RecentActivityGraph: View {
    let activityData: [ActivityData]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Recent Activities")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.horizontal)

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
        }
    }
}

// MARK: - Preview
struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
