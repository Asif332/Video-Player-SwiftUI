//
//  ContentView.swift
//  CustomAVPlayerWithTabView
//
//  Created by Mohammad Asif on 05/07/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HomeTabView(viewModel: VideoPlayerViewModel(playlist: Media.playlist))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
