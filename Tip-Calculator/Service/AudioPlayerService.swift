//
//  AudioPlayerService.swift
//  Tip-Calculator
//
//  Created by berfin doksöz on 15.08.2023.
//

import Foundation
import AVFAudio

protocol AudioPlayerService {
    func playSound()
}

final class DefaultAudioPlayer: AudioPlayerService {
    
    private var player: AVAudioPlayer?
    
    func playSound() {
        let path = Bundle.main.path(forResource: "click", ofType: "m4a")!
        let url = URL(fileURLWithPath: path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        }catch(let error){
            print(error.localizedDescription)
        }
    }
}
