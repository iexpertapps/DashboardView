//
//  UINavigationControllerExtension.swift
//  DashboardView
//
//  Created by Syed Zia ur Rehman on 06/12/2024.
//


import UIKit
// Configure UINavigationBar appearance globally
extension UINavigationController {
    static func configureAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().tintColor = .white // Back button color
    }
}
