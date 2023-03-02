//
//  CustomCorners.swift
//  Juicy Sweet Story
//
//  Created by Илья Мишин on 26.02.2023.
//

import SwiftUI

struct CustomCorners: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
