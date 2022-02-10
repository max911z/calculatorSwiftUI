//
//  KeyboardView.swift
//  calculatorSwiftUI
//
//  Created by Максим Неверовский on 10.02.2022.
//

import SwiftUI

struct KeyboardView: View {
    
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
        KeyboardView()
            .previewLayout(.sizeThatFits)
    }
}
