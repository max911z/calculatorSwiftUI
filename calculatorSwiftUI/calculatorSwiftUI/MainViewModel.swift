//
//  MainViewModel.swift
//  calculatorSwiftUI
//
//  Created by Максим Неверовский on 22.02.2022.
//

import Foundation

protocol MainViewModelDelegate {
    func setScreenValue(screenValue: String)
    func setCurrentOperation(currentOperationAsString: String)
    func setNextNumber(nextNumber: Double)
    func setAnswer(answer: Bool)
    func setCalc(calc: Bool)
}

class MainViewModel: ObservableObject, MainViewModelDelegate {
    @Published var screenValue = "0" {
        didSet{
            if(keyboardViewModel.screenValue != screenValue){
                keyboardViewModel.screenValue = screenValue
            }
            
            if(screenViewModel.screenValue != screenValue){
                screenViewModel.screenValue = screenValue
            }
        }
    }

    @Published var currentOperation: Operation = .none {
        didSet {
            if(keyboardViewModel.currentOperation != currentOperation){
                keyboardViewModel.currentOperation = currentOperation
            }
        }
    }

    @Published var nextNumber = 0.0 {
        didSet {
            if(keyboardViewModel.nextNumber != nextNumber){
                keyboardViewModel.nextNumber = nextNumber
            }
        }
    }

    @Published var answer = false {
        didSet {
            if(keyboardViewModel.answer != answer){
                keyboardViewModel.answer = answer
            }
        }
    }

    @Published var calc = false {
        didSet {
            if(keyboardViewModel.calc != calc){
                keyboardViewModel.calc = calc
            }
        }
    }

    @Published var screenViewModel = ScreenViewModel(screenValue: "0")
    @Published var keyboardViewModel = KeyboardViewModel(screenValue: "0", currentOperation: .none, nextNumber: 0.0, answer: false, calc: false)

    init() {
        screenViewModel.mainViewModelDelegate = self
        keyboardViewModel.mainViewModelDelegate = self
    }

    func setScreenValue(screenValue: String) {
        self.screenValue = screenValue
    }

    func setCurrentOperation(currentOperationAsString: String) {
        if let operation = Operation(rawValue: currentOperationAsString) {
            currentOperation = operation
        }
    }

    func setNextNumber(nextNumber: Double) {
        self.nextNumber = nextNumber
    }

    func setAnswer(answer: Bool) {
        self.answer = answer
    }

    func setCalc(calc: Bool) {
        self.calc = calc
    }
}

