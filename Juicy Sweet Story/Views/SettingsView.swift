//
//  SettingsView.swift
//  Juicy Sweet Story
//
//  Created by Илья Мишин on 26.02.2023.
//

import SwiftUI
import AVFAudio

struct SettingsView: View {
    
    @AppStorage(UserDefaultsKey.hapticsEnabled) private var isHapticsEnabled: Bool = true
    @AppStorage(UserDefaultsKey.soundEnabled) private var isSoundEnabled: Bool = true
    @Environment(\.presentationMode) var presentationMode
    @State private var audioPlayer: AVAudioPlayer!

    var body: some View {
        ZStack {
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image("SettingsBackButton")
                        .frame(alignment: .leading)
                }
                Spacer()
            }
            HStack {
                Image("Settings1")
                    .resizable()
                    .frame(width: 160, height: 50, alignment: .center)
            }
            Spacer()
            
            VStack(spacing: 20) {
                HStack(spacing: 15) {
                    Button {
                        
                    } label: {
                        Image("Sound")
                    }
                    
                    Button {
                        withAnimation {
                            isSoundEnabled.toggle()
                        }
                        if audioPlayer != nil && audioPlayer.isPlaying {
                            if isSoundEnabled == true {
                                audioPlayer.stop()
                            } else {
                                audioPlayer.play()
                            }
                        }
                    } label: {
                        Image(isSoundEnabled ? "XMark" : "CheckMark")
                    }
                }
                HStack(spacing: 15) {
                    Button {
                        
                    } label: {
                        Image("Vibro")
                    }
                    Button {
                        withAnimation {
                            isHapticsEnabled.toggle()
                        }
                    } label: {
                        Image(isHapticsEnabled ? "XMark" : "CheckMark")
                    }
                    
                }
                Button {
                    
                } label: {
                    Image("RateUs")
                }
                
            }
            .offset(y: UIScreen.main.bounds.height / 4)
        }
        .navigationBarBackButtonHidden()
        .offset(y: UIScreen.main.bounds.height / -2.6)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("Background")
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        ).ignoresSafeArea()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
