//
//  VideoPlayerViewModel.swift
//  CustomAVPlayerWithTabView
//
//  Created by Mohammad Asif on 05/07/22.
//

import Foundation

struct Reel: Identifiable {
    let id = UUID().uuidString
    let url: URL
    let media: Media
}

final class VideoPlayerViewModel {
    
    var playlist:[Media]
    init(playlist: [Media]) {
        self.playlist = playlist
    }
    
    //extracting Avplayer from media file
    public var reels: [Reel] {
      return  self.playlist.map { item -> Reel in
            return Reel(url: URL(string: item.url)!, media: item)
        }
    }
    
    func currentIndex(from id: String, reels:[Reel]) -> Int? {
        return reels.firstIndex(where: {$0.id == id})
    }
    
    func nextIndex(currentId: String, reels:[Reel]) -> Int? {
        if let index = self.currentIndex(from: currentId, reels: reels), (index + 1) < reels.count {
            return (index + 1)
        } else {
            return nil
        }
    }
}


struct Media: Identifiable {
    let id = UUID()
    let title: String
    let url: String
}

extension Media {
    static var playlist: [Media] = [
        .init(title: "First video", url: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4"),
        .init(title: "Second video", url: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4"),
        .init(title: "Third video", url: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4"),
    ]
}
