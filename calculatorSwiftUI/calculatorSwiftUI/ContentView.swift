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
                } .padding(.leading, 24)
                
                ScreenView()
                    
                Spacer()
            } .padding(.top, 24)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
