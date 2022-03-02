//
//  VIewModel.swift
//  calculatorSwiftUI
//
//  Created by Максим Неверовский on 20.02.2022.
//

import Foundation

class KeyboardViewModel: ObservableObject {
    @Published var screenValue: String {
        didSet {
            mainViewModelDelegate?.setScreenValue(screenValue: screenValue)
        }
    }
    
    @Published var currentOperation: Operation {
        didSet {
            mainViewModelDelegate?.setCurrentOperation(currentOperationAsString: currentOperation.rawValue)
        }
    }
    
    @Published var nextNumber: Double {
        didSet {
            mainViewModelDelegate?.setNextNumber(nextNumber: nextNumber)
        }
    }
    
    @Published var answer: Bool {
        didSet {
            mainViewModelDelegate?.setAnswer(answer: answer)
        }
    }
    
    @Published var calc: Bool {
        didSet {
            mainViewModelDelegate?.setCalc(calc: calc)
        }
    }
    
    var mainViewModelDelegate: MainViewModelDelegate?
    
    init(screenValue: String, currentOperation: Operation, nextNumber: Double, answer: Bool, calc: Bool) {
        self.screenValue = screenValue
        self.currentOperation = currentOperation
        self.nextNumber = nextNumber
        self.answer = answer
        self.calc = calc
    }
    
    func buttonSelected(button: CalcButton){        
        var decimalNumber = Decimal(Double(self.screenValue) ?? 0)
        
        switch button {
        case .add, .subtract, .multiply, .divide:
            calc = true
            currentOperation = button.operation
            nextNumber = Double(screenValue) ?? 0
            
        case .equal:
            self.answer = true
            let nextValue = Decimal(nextNumber)
            let currentValue = Decimal(Double(screenValue) ?? 0)
            equalAction(nextValue: nextValue, currentValue: currentValue, decimalNumber: decimalNumber)
            
        case .negative:
            negativeAction(decimalNumber: decimalNumber)
            
        case .percent:
            decimalNumber /= 100
            percentAction(decimalNumber: decimalNumber)
            
        case .clear:
            screenValue = "0"
            
        case .decimal:
            decimalAction(button: button)
            
        default:
            numberAction(button: button)
        }
    }
    
    func equalAction(nextValue: Decimal, currentValue: Decimal, decimalNumber: Decimal){
        switch currentOperation {
        case .add: screenValue = "\(nextValue + currentValue)"
        case .subtract: screenValue = "\(nextValue - currentValue)"
        case .multiply: screenValue = "\(nextValue * currentValue)"
        case .divide: screenValue = "\(nextValue / currentValue)"
        case .none: break
            
        }
        if Double(screenValue) ?? 0 > Double(Int.max){
            screenValue = "Error"
            return
        }
        
        if round(Double(screenValue) ?? 0) == Double(screenValue) ?? 0{
            let number = Int(Double(screenValue) ?? 0)
            screenValue = String(number)
        }
        
        if screenValue.count > 10{
            transformToScientificFormat(decimalNumber: decimalNumber)
        }
    }
    
    func negativeAction(decimalNumber: Decimal){
        if screenValue.count >= 10{
            transformToScientificFormat(decimalNumber: decimalNumber)
        }
        if screenValue.contains("E"){
            checkScientificNumberForNegative()
        } else{
            checkRealNumberForNegative()
        }
    }
    
    func percentAction(decimalNumber: Decimal){
        if String(describing: decimalNumber).count > 10{
            transformToScientificFormat(decimalNumber: decimalNumber)
        } else{
            screenValue = String(describing: decimalNumber)
        }
    }
    
    func decimalAction(button: CalcButton){
        if screenValue.contains(".") == false{
            let number = button.rawValue
            screenValue = "\(screenValue)\(number)"
        }
    }
    
    func numberAction(button: CalcButton){
        let number = button.rawValue
        if calc == true {
            screenValue = ""
            calc = false
        }
        if answer == true {
            screenValue = number
            answer = false
        }
        else{
            if screenValue == "0" {
                screenValue = number
            } else {
                let newString = "\(screenValue)\(number)"
                let maxSize = 10
                if newString.count <= maxSize {
                    screenValue = newString
                }
            }
        }
    }
    
    func transformToScientificFormat(decimalNumber : Decimal) {
        let formatter = NumberFormatter()
        formatter.positiveFormat = Const.scientificFormat
        if let scientificFormatted = formatter.string(for: decimalNumber) {
            self.screenValue = String(scientificFormatted)
        }
    }
    
    func checkScientificNumberForNegative(){
        if screenValue[screenValue.startIndex] == "-"{
            screenValue.removeFirst()
        } else{
            screenValue = "-\(screenValue)"
        }
    }
    
    func checkRealNumberForNegative() {
        if round(Double(screenValue) ?? 0) == Double(screenValue) ?? 0{
            var number = Int(Double(screenValue) ?? 0)
            number *= (-1)
            screenValue = String(number)
        } else{
            var number = Double(screenValue) ?? 0
            number *= (-1.0)
            screenValue = String(number)
        }
    }
}

