//
//  KeyboardView.swift
//  calculatorSwiftUI
//
//  Created by Максим Неверовский on 10.02.2022.
//

import SwiftUI

struct KeyboardView: View {
    
    @ObservedObject var model = ViewModel()
    
    @Binding var screenValue : String
    @Binding var currentOperation: Operation
    @Binding var nextNumber : Double
    @Binding var answer : Bool
    @Binding var calc : Bool
    
    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal]
    ]
    
    var body: some View {
        ForEach(buttons, id: \.self){ row in
            HStack(spacing: 16){
                ForEach(row, id: \.self){ item in
                    Button(action: {
                        self.buttonPress(button: item)
                    }, label: {
                        Text(item.rawValue)
                            .font(.custom(Const.buttonFont, size: 32))
                            .frame(width: self.buttonWidth(item: item), height: self.buttonHeight(), alignment: .center)
                            .background(item.buttonColor)
                            .foregroundColor(item.foregroundColor)
                            .cornerRadius(15)
                            .shadow(color: Color(Const.buttonLightShadowColor), radius: 5, x: -3, y: -3)
                            .shadow(color: Color(Const.buttonDarkShadowColor), radius: 5, x: 3, y: 3)
                    })
                }
            }
            .padding(.bottom, 6)
        }
    }
    
    func buttonPress(button: CalcButton) {
        
        var decimalNumber = Decimal(Double(self.screenValue) ?? 0)
        
        switch button {
        case .add, .subtract, .multiply, .divide:
            self.calc = true
            self.currentOperation = button.operation
            self.nextNumber = Double(self.screenValue) ?? 0
            
        case .equal:
            self.answer = true
            let nextValue = Decimal(self.nextNumber)
            let currentValue = Decimal(Double(self.screenValue) ?? 0)
            
            switch self.currentOperation {
            case .add: self.screenValue = "\(nextValue + currentValue)"
            case .subtract: self.screenValue = "\(nextValue - currentValue)"
            case .multiply: self.screenValue = "\(nextValue * currentValue)"
            case .divide: self.screenValue = "\(nextValue / currentValue)"
            case .none: break
            }
            
            if Double(self.screenValue) ?? 0 > Double(Int.max){
                self.screenValue = "Error"
                break
            }
            
            if round(Double(self.screenValue) ?? 0) == Double(self.screenValue) ?? 0{
                let number = Int(Double(self.screenValue) ?? 0)
                self.screenValue = String(number)
            }
            
            if self.screenValue.count > 10{
                transformToScientificFormat(decimalNumber: decimalNumber)
            }
                    
        case .negative:
            if self.screenValue.count >= 10{
                transformToScientificFormat(decimalNumber: decimalNumber)
            }
            if self.screenValue.contains("E"){
                checkScientificNumberForNegative()
            } else{
                checkRealNumberForNegative()
            }
                        
        case .percent:
            decimalNumber /= 100
            
            if String(describing: decimalNumber).count > 10{
                transformToScientificFormat(decimalNumber: decimalNumber)
            } else{
                self.screenValue = String(describing: decimalNumber)
            }
            
        case .clear:
            screenValue = "0"
         
        case .decimal:
            if self.screenValue.contains(".") == false{
                let number = button.rawValue
                self.screenValue = "\(screenValue)\(number)"
            }
                               
        default:
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
                    self.screenValue = newString
                    }
                }
            }
        }
    }
    
    func checkScientificNumberForNegative(){
        if self.screenValue[self.screenValue.startIndex] == "-"{
            self.screenValue.removeFirst()
        } else{
            self.screenValue = "-\(self.screenValue)"
        }
    }
    
    func checkRealNumberForNegative() {
        if round(Double(self.screenValue) ?? 0) == Double(self.screenValue) ?? 0{
            var number = Int(Double(self.screenValue) ?? 0)
            number *= (-1)
            self.screenValue = String(number)
        } else{
            var number = Double(self.screenValue) ?? 0
            number *= (-1.0)
            self.screenValue = String(number)
        }
    }
    
    func buttonWidth(item: CalcButton) -> CGFloat {
        if (item == .zero){
            return ((UIScreen.main.bounds.width - (4*12)) / 4) * 2
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4.3
    }
    
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4.3
    }
    
    func transformToScientificFormat(decimalNumber : Decimal) {
        let formatter = NumberFormatter()
        formatter.positiveFormat = Const.scientificFormat
        if let scientificFormatted = formatter.string(for: decimalNumber) {
            self.screenValue = String(scientificFormatted)
        }
    }
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView(screenValue: .constant("0"), currentOperation: .constant(.none), nextNumber: .constant(0), answer: .constant(false), calc: .constant(false))
            .previewLayout(.sizeThatFits)
    }
}
