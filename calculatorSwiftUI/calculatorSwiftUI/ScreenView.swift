//
//  ScreenView.swift
//  calculatorSwiftUI
//
//  Created by Максим Неверовский on 07.02.2022.
//

import SwiftUI

struct ScreenView: View {
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.init("initColor"), Color.init("finalColor")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(maxWidth: .infinity, maxHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.init("backgroundColor"))
                        .shadow(color: Color.black, radius: 9, x: 0, y: 0)
                )
                .clipped()
            HStack{
                Text("8888888888")
                    .lineLimit(1)
                    .font(.custom("Digital", size: (UIScreen.main.bounds.width - (5*12)) / 5.25))
                    .opacity(0.05)
                    .padding(.leading,20)
                Spacer()
            }            
            HStack{
                Text("8888")
                    .lineLimit(1)
                    .font(.custom("Digital", size: (UIScreen.main.bounds.width - (5*12)) / 5.25))
                    .padding(.leading,20)
                Spacer()
            }
        }
    }
}

struct ScreenView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ScreenView()
                .previewLayout(.sizeThatFits)
        }
    }
}
