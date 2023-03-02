//
//  PreviewProvider.swift
//  Juicy Sweet Story
//
//  Created by Илья Мишин on 26.02.2023.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}

class DeveloperPreview {
    
    static let instance = DeveloperPreview()
    let vm = GameViewModel()
    
    private init() {}
}
