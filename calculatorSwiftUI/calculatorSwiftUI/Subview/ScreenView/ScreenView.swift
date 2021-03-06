//
//  ScreenView.swift
//  calculatorSwiftUI
//
//  Created by Максим Неверовский on 07.02.2022.
//

import SwiftUI

struct ScreenView: View {
    @ObservedObject private var screenViewModel: ScreenViewModel
    
    init(screenViewModel: ScreenViewModel){
        self.screenViewModel = screenViewModel
    }
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.init(Const.initColorGradient), Color.init(Const.finalColorGradient)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(maxWidth: .infinity, maxHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.init(Const.backgroundColor))
                        .shadow(color: Color.black, radius: 10, x: 0, y: 0)
                )
                .clipped()
            
            HStack{
                Text(Const.screenViewPlaceholder)
                    .kerning(4)
                    .lineLimit(1)
                    .font(.custom(Const.screenViewFont, size: (UIScreen.main.bounds.width - (5*12)) / 5.5))
                    .opacity(0.05)
                    .padding(.leading,20)
                Spacer()
            }
            
            HStack{
                Text(screenViewModel.screenValue)
                    .kerning(4)
                    .lineLimit(1)
                    .font(.custom(Const.screenViewFont, size: (UIScreen.main.bounds.width - (5*12)) / 5.5))
                    .padding(.leading,20)
                    .opacity(0.85)
                    .gesture(DragGesture(minimumDistance:0, coordinateSpace: .local)
                                .onEnded({ value in
                        if value.translation.width > 1 {
                            if screenViewModel.screenValue.count > 1 {
                                screenViewModel.screenValue = String(screenViewModel.screenValue.dropLast())
                            }
                        }
                    }))
                Spacer()
            }
        }
    }
}

struct ScreenView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ScreenView(screenViewModel: ScreenViewModel(screenValue: "0"))
                .previewLayout(.sizeThatFits)
        }
    }
}
