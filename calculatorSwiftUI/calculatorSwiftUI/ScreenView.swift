//
//  ScreenView.swift
//  calculatorSwiftUI
//
//  Created by Максим Неверовский on 07.02.2022.
//

import SwiftUI

struct ScreenView: View {

    var body: some View {
        GeometryReader { geometry in
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.init("initColor"), Color.init("finalColor")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .cornerRadius(10)
                .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
            Image("digitalPlaceholder")
                        .resizable()
                        .scaledToFit()
                .padding(EdgeInsets(top: 0, leading: 48, bottom: 0, trailing: 48))
        }.frame(width: geometry.size.width, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .center)
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
