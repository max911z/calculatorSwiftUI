//
//  KeyboardView.swift
//  calculatorSwiftUI
//
//  Created by Максим Неверовский on 10.02.2022.
//

import SwiftUI

struct KeyboardView: View {
    @ObservedObject private var keyboardViewModel: KeyboardViewModel

    init(keyboardViewModel: KeyboardViewModel) {
        self.keyboardViewModel = keyboardViewModel
    }
    
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
                        keyboardViewModel.buttonSelected(button: item)
                    }, label: {
                        Text(item.rawValue)
                            .font(.custom(Const.buttonFont, size: 32))
                            .frame(width: buttonWidth(item: item), height: buttonHeight(), alignment: .center)
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
    
    func buttonWidth(item: CalcButton) -> CGFloat {
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
        KeyboardView(keyboardViewModel: KeyboardViewModel(screenValue: "0", currentOperation: .none, nextNumber: 0.0, answer: false, calc: false))
            .previewLayout(.sizeThatFits)
    }
}
