//
//  HomeTabView.swift
//  CustomAVPlayerWithTabView
//
//  Created by Mohammad Asif on 05/07/22.
//

import SwiftUI
import AVKit

struct HomeTabView: View {
    let viewModel: VideoPlayerViewModel
    @State var currentReel = ""
    @State var reels: [Reel] = []
    let index: Int
    let player = AVPlayer()

    var body: some View {
        GeometryReader { proxy in
            let size =  proxy.size
            // Horizontal page tab view
            ZStack {
                CustomVideoPlayer(player: player, playNextItem: { currentId in
                    if let nextIndex = viewModel.nextIndex(currentId: currentId, reels: reels) {
                        currentReel = reels[nextIndex].id
                    } else {
                        print("player pause")
                        self.player.pause()
                    }
                }, currentId: $currentReel)
                TabView(selection: $currentReel) {
                    ForEach($reels) { $reel in
                        VideoPlayerOverlayView(reel: $reel, player: player)
                        .frame(height: size.height)
                        .ignoresSafeArea(.all, edges: .top)
                        .tag(reel.id)
                    }
                }
                // setting max height.
                .frame(height: size.height)
                .tabViewStyle(.page(indexDisplayMode: .never))
                .onChange(of: currentReel) { (_) in
                    // playing current video
                    if let index = viewModel.currentIndex(from: currentReel, reels: reels) {
                        print("index onChange = \(index)")
                        let playerItem = AVPlayerItem(url: reels[index].url)
                        self.player.replaceCurrentItem(with: playerItem)
                        self.player.play()

                    }
                }
            }
        }
        .ignoresSafeArea(.all, edges: .top)
        .background(Color.black.ignoresSafeArea())
        .navigationBarTitle("Player View", displayMode: .inline)
        // setting initial reel
        .onAppear() {
            reels = self.viewModel.reels
            currentReel = reels[index].id
        }
        .onDisappear() {
            self.player.replaceCurrentItem(with: nil)
            self.player.pause()
        }
    }
}

struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView(viewModel: VideoPlayerViewModel(playlist: []), index: 1)
    }
}
