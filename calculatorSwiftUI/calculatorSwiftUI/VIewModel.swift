//
//  VIewModel.swift
//  calculatorSwiftUI
//
//  Created by Максим Неверовский on 20.02.2022.
//

import Foundation
import Combine
import SwiftUI 

final class ViewModel: ObservableObject{
    
    
    // input
    @Published var screenValue: String = ""
    // output
    @Published var currentWeather = WeatherDetail.placeholder
    
    init() {
        $city
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .removeDuplicates()
            .flatMap { (city:String) -> AnyPublisher <WeatherDetail, Never> in
                WeatherAPI.shared.fetchWeather(for: city)
              }
            .assign(to: \.currentWeather , on: self)
            .store(in: &self.cancellableSet)
   }
    
    private var cancellableSet: Set<AnyCancellable> = []
    
}
