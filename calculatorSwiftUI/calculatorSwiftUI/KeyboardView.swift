//
//  KeyboardView.swift
//  calculatorSwiftUI
//
//  Created by Максим Неверовский on 10.02.2022.
//

import SwiftUI

struct KeyboardView: View {
    
    @Binding var screenValue : String
    @Binding var currentOperation: Operation
    @Binding var nextNumber : Double
    @Binding var answer : Bool
    @Binding var calc : Bool
    
    let buttons: [[calcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal]
    ]
    
    var body: some View {
        ForEach(buttons, id: \.self){ i in
            HStack(spacing: 16){
                ForEach(i, id: \.self){ j in
                    Button(action: {
                        self.buttonPress(button: j)
                    }, label: {
                        Text(j.rawValue)
                            .font(.custom("Montserrat-Bold", size: 32))
                            .frame(width: self.buttonWidth(item: j), height: self.buttonHeight(), alignment: .center)
                            .background(j.buttonColor)
                            .foregroundColor(j.foregroundColor)
                            .cornerRadius(15)
                            .shadow(color: Color("lightShadow"), radius: 5, x: -3, y: -3)
                            .shadow(color: Color("darkShadow"), radius: 5, x: 3, y: 3)
                    })
                }
            }
            .padding(.bottom, 6)
        }
    }
    
    func buttonPress(button: calcButton) {
        
        
        switch button {
        case .add, .subtract, .multiply, .divide, .equal:
            if button == .add{
                self.calc = true
                self.currentOperation = .add
                //print("ScreenValue:", Double(self.screenValue) ?? 0)
                self.nextNumber = Double(self.screenValue) ?? 0
                //print("nextNumber:", self.nextNumber )
            }
            else if button == .subtract{
                self.calc = true
                self.currentOperation = .subtract
                self.nextNumber = Double(self.screenValue) ?? 0
            }
            else if button == .multiply{
                self.calc = true
                self.currentOperation = .multiply
                self.nextNumber = Double(self.screenValue) ?? 0
            }
            else if button == .divide{
                self.calc = true
                self.currentOperation = .divide
                self.nextNumber = Double(self.screenValue) ?? 0
            }
            else if button == .equal{
                self.answer = true
                //print(answer, "НАЖАТО РАВНО!")
                
                let nextValue = self.nextNumber
                let currentValue = Double(self.screenValue) ?? 0
                
                switch self.currentOperation {
                case .add: self.screenValue = "\(nextValue + currentValue)"
                case .subtract: self.screenValue = "\(nextValue - currentValue)"
                case .multiply: self.screenValue = "\(nextValue * currentValue)"
                case .divide: self.screenValue = "\(nextValue / currentValue)"
                case .none: break
                }
                
                if round(Double(self.screenValue) ?? 0) == Double(self.screenValue) ?? 0{
                    
                    let number = Int(Double(self.screenValue) ?? 0)
                    //print("answer", number)
                    self.screenValue = String(number)
                }
                
                let negativeNumber = Double(self.screenValue)
                
                if String(describing: negativeNumber).count > 10{
                    let formatter = NumberFormatter()
                    formatter.positiveFormat = "0.###E+0"
                    if let scientificFormatted = formatter.string(for: negativeNumber) {
                        self.screenValue = String(scientificFormatted)
                    }
                } else{
                    self.screenValue = String(describing: negativeNumber)
                }
                
               
            }
            
        case .negative:
            if round(Double(self.screenValue) ?? 0) == Double(self.screenValue) ?? 0{
                var number = Int(Double(self.screenValue) ?? 0)
                number *= (-1)
                    self.screenValue = String(number)
            } else{
                var number = Double(self.screenValue) ?? 0
                number *= (-1.0)
                    self.screenValue = String(number)
            }
            
            let negativeNumber = Double(self.screenValue)
            
            if String(describing: negativeNumber).count > 10{
                let formatter = NumberFormatter()
                formatter.positiveFormat = "0.###E+0"
                if let scientificFormatted = formatter.string(for: negativeNumber) {
                    self.screenValue = String(scientificFormatted)
                }
            } else{
                self.screenValue = String(describing: negativeNumber)
            }
            
                
           
        case .percent:
            var decimalNumber = Decimal(Double(self.screenValue) ?? 0)
            decimalNumber /= 100
            
            if String(describing: decimalNumber).count > 10{
                let formatter = NumberFormatter()
                formatter.positiveFormat = "0.###E+0"
                if let scientificFormatted = formatter.string(for: decimalNumber) {
                    self.screenValue = String(scientificFormatted)
                }
                
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
    
    func buttonWidth(item: calcButton) -> CGFloat {
        if (item == .zero){
            return ((UIScreen.main.bounds.width - (4*12)) / 4) * 2
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4.3
    }
    
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4.3
    }
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView(screenValue: .constant("0"), currentOperation: .constant(.none), nextNumber: .constant(0), answer: .constant(false), calc: .constant(false))
            .previewLayout(.sizeThatFits)
    }
}
