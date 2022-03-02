//
//  ContentView.swift
//  calculatorSwiftUI
//
//  Created by Максим Неверовский on 07.02.2022.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var viewModel: MainViewModel
    
    var body: some View {
        ZStack{
            Color.init(Const.backgroundColor).edgesIgnoringSafeArea(.all)
            
            VStack{
                HStack {
                    Text(Const.appName)
                        .font(.custom(Const.appNameFont, size: (UIScreen.main.bounds.width - (5*12)) / 11))
                        .padding(EdgeInsets(top: 24, leading: 24, bottom: 0, trailing: 0))
                    Spacer()
                }
                Spacer()
                ScreenView(screenViewModel: viewModel.screenViewModel)
                    .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                Spacer()
                KeyboardView(keyboardViewModel: viewModel.keyboardViewModel)
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
