//
//  ScreenView.swift
//  calculatorSwiftUI
//
//  Created by Максим Неверовский on 07.02.2022.
//

import SwiftUI

struct ScreenView: View {
    
    private var textFrameWidth: CGFloat = 400
    private var textFrameHeight: CGFloat = 70
    
    var body: some View {
        GeometryReader{g in
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
                    Text("0000000000")
                        .font(.custom("Digital", size: g.size.height > g.size.width ? g.size.width * 0.18: g.size.height * 0.18))
                        .opacity(0.2)
                        .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 0))
                    Spacer()
                }
                
                HStack{
                    Text("0000")
                        .font(.custom("Digital", size: g.size.height > g.size.width ? g.size.width * 0.18: g.size.height * 0.18))
                        .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 0))
                    Spacer()
                }
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
