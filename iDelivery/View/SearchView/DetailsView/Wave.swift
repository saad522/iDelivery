//
//  Wave.swift
//  iDelivery
//
//  Created by mac on 12/11/20.
//

import SwiftUI

struct Wave: Shape {
    var yOffset: CGFloat = 0.5
    
    var animatableData: CGFloat {
        get {
            return yOffset
        }
        set {
            yOffset = newValue
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        // Curve at the bottom
        path.addCurve(to: CGPoint(x: rect.minX, y: rect.maxY),
                      control1: CGPoint(x: rect.maxX * (0.75 - 0.25), y: rect.maxY + (rect.maxY * yOffset)),
                      control2: CGPoint(x: rect.maxX * (0.25 + 0.35), y: rect.maxY - (rect.maxY * (yOffset - 0.10))))
        
        path.closeSubpath()
        
        return path
    }
}

struct Wave_Previews: PreviewProvider {
    static var previews: some View {
        Wave()
            .stroke(Color.red, lineWidth: 5)
            .frame(height: 350)
        .padding()
    }
}
