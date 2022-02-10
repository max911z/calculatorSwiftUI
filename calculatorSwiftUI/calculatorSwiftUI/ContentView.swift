//
//  ContentView.swift
//  calculatorSwiftUI
//
//  Created by Максим Неверовский on 07.02.2022.
//

import SwiftUI

struct ContentView: View {
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
                ScreenView()
                    .padding(EdgeInsets(top: 0, leading: 24, bottom: 25, trailing: 24))
                KeyboardView()
                    .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
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
