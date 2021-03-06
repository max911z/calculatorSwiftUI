//
//  calculatorSwiftUIApp.swift
//  calculatorSwiftUI
//
//  Created by Максим Неверовский on 07.02.2022.
//

import SwiftUI

@main
struct CalculatorSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()            
                .environmentObject(MainViewModel())
        }
    }
}
