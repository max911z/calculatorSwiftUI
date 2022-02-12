//
//  CalcButtons.swift
//  calculatorSwiftUI
//
//  Created by Максим Неверовский on 10.02.2022.
//

import Foundation
import SwiftUI

enum calcButton: String{
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "–"
    case divide = "/"
    case multiply = "x"
    case clear = "AC"
    case equal = "="
    case decimal = "."
    case percent = "%"
    case negative = "-/+"
    
    var buttonColor: Color{
        switch self {
        case .subtract, .add, .divide, .multiply, .equal:
            return Color.init(Const.darkButtonColor)
        default:
            return Color.init(Const.lightButtonColor)
        }
    }
    
    var foregroundColor: Color{
        switch self {
        case .subtract, .add, .divide, .multiply, .equal:
            return Color.init(Const.lightButtonColor)
        default:
            return Color.init(Const.darkButtonColor)
        }
    }
}

enum Operation {
    case add, subtract, multiply, divide, none
}
