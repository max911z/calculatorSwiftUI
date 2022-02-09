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
                        .font(.custom("MuseoSansCyrl-700", size: 28))
                    Spacer()
                } .padding(EdgeInsets(top: 24, leading: 24, bottom: 24, trailing: 0))
                
                ScreenView()
                    .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                    
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
