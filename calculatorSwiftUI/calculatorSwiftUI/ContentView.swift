//
//  ContentView.swift
//  calculatorSwiftUI
//
//  Created by Максим Неверовский on 07.02.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State var screenValue = "0"
    @State var currentOperation: Operation = .none
    @State var nextNumber = 0.0
    @State var answer = false
    @State var calc = false
    
    var body: some View {
        ZStack{
            Color.init("backgroundColor").edgesIgnoringSafeArea(.all)
            
            VStack{
                HStack {
                    Text("Calculator")
                        .font(.custom("MuseoSansCyrl-700", size: (UIScreen.main.bounds.width - (5*12)) / 11))
                        .padding(EdgeInsets(top: 24, leading: 24, bottom: 0, trailing: 0))
                    Spacer()
                }
                Spacer()
                ScreenView(screenValue: $screenValue, currentOperation: $currentOperation, nextNumber: $nextNumber)
                    .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                Spacer()
                KeyboardView(screenValue: $screenValue, currentOperation: $currentOperation, nextNumber: $nextNumber, answer: $answer, calc: $calc)
                    .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                Spacer()
            }
            .padding(.bottom, 20)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
