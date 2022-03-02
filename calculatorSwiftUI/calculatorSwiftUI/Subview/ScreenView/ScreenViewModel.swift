//
//  ScreenViewModel.swift
//  calculatorSwiftUI
//
//  Created by Максим Неверовский on 02.03.2022.
//

import Foundation

class ScreenViewModel: ObservableObject {
    @Published var screenValue: String{
        didSet{
            mainViewModelDelegate?.setScreenValue(screenValue: screenValue)
        }
    }
    
    var mainViewModelDelegate: MainViewModelDelegate?
    
    init(screenValue: String) {
        self.screenValue = screenValue
    }
}
