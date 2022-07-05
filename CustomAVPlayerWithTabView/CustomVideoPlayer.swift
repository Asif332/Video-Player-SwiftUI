//
//  CustomVideoPlayer.swift
//  CustomAVPlayerWithTabView
//
//  Created by Mohammad Asif on 05/07/22.
//

import SwiftUI
import AVKit

struct CustomVideoPlayer : UIViewControllerRepresentable {
    
    var player : AVPlayer
    var playNextItem: (_ currentReel:String) ->  Void
    @Binding var currentId: String
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> AVPlayerViewController{
        let view = AVPlayerViewController()
        view.player = player
        view.showsPlaybackControls = false
        view.videoGravity = .resizeAspectFill
        // repeating playback
        player.actionAtItemEnd = .pause
        NotificationCenter.default.addObserver(context.coordinator, selector: #selector(context.coordinator.restartPlayback), name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        return view
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        
    }
    
    class Coordinator: NSObject {
        
        var parent : CustomVideoPlayer
        
        init(parent: CustomVideoPlayer) {
            self.parent = parent
        }
        
        @objc func restartPlayback() {
            parent.player.seek(to: .zero)
            parent.playNextItem(parent.currentId)
        }
    }
}
