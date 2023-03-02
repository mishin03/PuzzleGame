//
//  HapticManager.swift
//  Juicy Sweet Story
//
//  Created by Илья Мишин on 28.02.2023.
//

import Foundation
import SwiftUI

final class HapticManager {
    
    static let shared = HapticManager()
    
    private let generator = UINotificationFeedbackGenerator()
    
    private init() {}
    
    func trigger(_ notification: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(notification)
    }
}

func haptic(_ notification: UINotificationFeedbackGenerator.FeedbackType)  {
    if UserDefaults.standard.bool(forKey: UserDefaultsKey.hapticsEnabled) {
        HapticManager.shared.trigger(notification)
    }
}
