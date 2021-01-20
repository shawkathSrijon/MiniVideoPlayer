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
                            .updating($gestureOffset) { (value, state, _) in
                                state = value.translation.height
                            }
                            .onEnded(onEnd(value:))
                    )
            }
        }
        .onChange(of: gestureOffset) { value in
            onChanged()
        }
        .environmentObject(viewModel)
    }
    func onChanged() {
        if gestureOffset > 0 && !viewModel.isMiniPlayer && viewModel.offset + 75 <= viewModel.height {
            viewModel.offset = gestureOffset
            print(viewModel.offset)
        }
    }
    func onEnd(value: DragGesture.Value) {
        withAnimation(.default) {
            if !viewModel.isMiniPlayer {
                viewModel.offset = 0
                if value.translation.height > UIScreen.main.bounds.height / 3 {
                    viewModel.isMiniPlayer = true
                } else {
                    viewModel.isMiniPlayer = false
                }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
