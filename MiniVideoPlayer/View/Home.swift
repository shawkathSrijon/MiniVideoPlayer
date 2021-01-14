//
//  Home.swift
//  MiniVideoPlayer
//
//  Created by Simec Sys Ltd. on 14/1/21.
//

import SwiftUI

struct Home: View {
    @StateObject var viewModel = VideoPlayerViewModel()
    @GestureState var gestureOffset: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(videos) { video in
                        VideoCardView(video: video)
                            .onTapGesture {
                                withAnimation {
                                    viewModel.showPlayer.toggle()
                                }
                            }
                    }
                }
            }
            if viewModel.showPlayer {
                MiniPlayer()
                    .transition(.move(edge: .bottom))
                    .offset(y: viewModel.offset)
                    .gesture(
                        DragGesture()
                            .onChanged(onChanged(value:))
                            .onEnded(onEnd(value:))
                    )
            }
        }
    }
    func onChanged(value: DragGesture.Value) {
        viewModel.offset = value.translation.height
    }
    func onEnd(value: DragGesture.Value) {
        withAnimation(.default) {
            viewModel.offset = 0
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
