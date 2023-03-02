//
//  Juicy_Sweet_StoryApp.swift
//  Juicy Sweet Story
//
//  Created by Илья Мишин on 24.02.2023.
//

import SwiftUI

@main
struct Juicy_Sweet_StoryApp: App {
    @StateObject private var vm = GameViewModel()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(vm)
        }
    }
}
