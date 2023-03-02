//
//  TimeFormatter.swift
//  Juicy Sweet Story
//
//  Created by Илья Мишин on 25.02.2023.
//

import Foundation

extension Double {
  func asString(style: DateComponentsFormatter.UnitsStyle) -> String {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.hour, .minute, .second, .nanosecond]
    formatter.unitsStyle = style
    return formatter.string(from: self) ?? ""
  }
}

extension Int {
    func secondsToTime() -> String {

            let (m,s) = ((self % 3600) / 60, (self % 3600) % 60)

            let m_string =  m < 10 ? "0\(m)" : "\(m)"
            let s_string =  s < 10 ? "0\(s)" : "\(s)"

            return "\(m_string):\(s_string)"
        }
}
