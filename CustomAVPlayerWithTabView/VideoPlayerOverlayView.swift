//
//  VideoPlayerOverlayView.swift
//  CustomAVPlayerWithTabView
//
//  Created by Mohammad Asif on 05/07/22.
//

import SwiftUI
import AVKit

struct VideoPlayerOverlayView: View {
    
    @Binding var reel: Reel
    let player: AVPlayer
    
    var body: some View {
        
        ZStack {
            // safe check
            Image(systemName: player.timeControlStatus == .playing ? "pause" : "play")
                .font(.title)
                .foregroundColor(.white)
                .padding()
            // Player control for play pause
            Color.black
                .opacity(0.01)
                .frame(width: 150, height: 150)
                .onTapGesture {
                    // play pause player
                    if player.timeControlStatus == .playing {
                        player.pause()
                    } else {
                        player.play()
                    }
                }
            
            TopBar().padding(.vertical, 50)
        }
        
    }
}

struct TopBar: View {
    private var paddigConstant = 0
    @State var lineLimit: Int = 0
    @State var isCollapsed: Bool = false
    @State var lineCount: Int = 1
    @State var isAnimating: Bool = false
    @State var currentIndex: Int = 0
    
    var body: some View {
        ZStack(alignment: .topLeading){
            topBarView
        }
    }
    
    private var topBarView: some View{
        GeometryReader { geometry in
            
            VStack(alignment: .leading){
                HStack(alignment: .center, spacing: 5){
                    ForEach(0..<5) { index in
                        Rectangle()
                            .fill(Color(.white).opacity((index > self.currentIndex - 1) ? 0.30 : 1.0))
                            .frame(width: (geometry.size.width - CGFloat(self.paddigConstant)) / CGFloat(5), height: 2)
                    }
                }.padding(.horizontal, 24)
                    .padding(.top, 24)
                HStack(alignment: .top){
                    VStack{
                        Text("Topic Name")
                            .foregroundColor(.black)
                            .padding(.horizontal, 8)
                    }
                    .frame( height: 24)
                    .background(Rectangle().fill(.gray).cornerRadius(4))
                    .padding(.top, 5)
                    .padding(.leading, 24)
                    Spacer()
                    Text("X")
                        .font(.title3)
                        .frame(width: 24, height: 24)
                        .foregroundColor(.white)
                        .padding(.trailing, 24)
                }
                Spacer()
                discriptionView
                    .padding(.bottom, 10)
                    .padding(.leading, 24)
            }
        }
    }
}

private var discriptionView: some View{
    VStack(alignment: .leading){
        HStack{
            Text("MA")
                .frame(width: 30, height: 30)
                .foregroundColor(.white)
                .background(.gray)
                .clipShape(Circle())
            Text("Mohammad Asif")
                .foregroundColor(.white)
        }
        Text( "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.")
            .foregroundColor(.white)
            .padding(.trailing, 20)
    }
}
