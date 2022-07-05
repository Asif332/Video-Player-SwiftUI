//
//  ContentView.swift
//  CustomAVPlayerWithTabView
//
//  Created by Mohammad Asif on 05/07/22.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Video Playlist! ")
                    .font(.title)
                    .foregroundColor(.white)
                List(Media.playlist.indices, id:\.self) { idx in
                    NavigationLink {
                        HomeTabView(viewModel: VideoPlayerViewModel(playlist: Media.playlist), index: idx)
                    } label: {
                        Label(Media.playlist[idx].title, systemImage: "play")
                    }
                }
            }
        }
        .navigationBarTitle (Text("Video Player"), displayMode: .inline)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
