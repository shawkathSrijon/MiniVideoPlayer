//
//  MiniPlayer.swift
//  MiniVideoPlayer
//
//  Created by Simec Sys Ltd. on 14/1/21.
//

import SwiftUI

struct MiniPlayer: View {
    @EnvironmentObject var viewModel: VideoPlayerViewModel
    
    var body: some View {
        VStack {
            HStack {
                VideoPlayerView()
                    .frame(width: viewModel.isMiniPlayer ? 150 : viewModel.width, height: viewModel.isMiniPlayer ? 70 : getFrame())
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                VideoControls()
            )
            GeometryReader { geometry in
                ScrollView {
                    VStack(spacing: 18) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Sea Creature That Made Megalodon Disappear Is Still Alive")
                                .font(.callout)
                            Text("1.2M Views")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        HStack {
                            PlayBackVideoButtons(image: "hand.thumbsup", title: "123K")
                            PlayBackVideoButtons(image: "hand.thumbsdown", title: "11K")
                            PlayBackVideoButtons(image: "square.and.arrow.up", title: "Share")
                            PlayBackVideoButtons(image: "square.and.arrow.down", title: "Download")
                            PlayBackVideoButtons(image: "message", title: "Live Chat")
                        }
                        Divider()
                        VStack(spacing: 15) {
                            ForEach(videos) { video in
                                VideoCardView(video: video)
                            }
                        }
                    }
                    .padding()
                }
                .onAppear {
                    viewModel.height = geometry.frame(in: .global).height + 250
                }
            }
            .background(Color.white)
            .opacity(viewModel.isMiniPlayer ? 0 : getOpacity())
            .frame(height: viewModel.isMiniPlayer ? 0 : nil)
        }
        .background(
            Color.white
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    withAnimation {
                        viewModel.width = UIScreen.main.bounds.width
                        viewModel.isMiniPlayer.toggle()
                    }
                }
        )
    }
    // Getting frame and opacity while dragging
    func getFrame() -> CGFloat {
        let progress = viewModel.offset / (viewModel.height - 100)
        if 1 - progress <= 1.0 {
            let videoHeight = (1 - progress) * 250
            if videoHeight < 75 {
                let percent = videoHeight / 75
                let videoWidth = percent * UIScreen.main.bounds.width
                DispatchQueue.main.async {
                    if videoWidth > 150 {
                        viewModel.width = videoWidth
                    }
                }
                return 75
            }
            DispatchQueue.main.async {
                viewModel.width = UIScreen.main.bounds.width
            }
            return videoHeight
        }
        return 250
    }
    func getOpacity() -> Double {
        let progress = viewModel.offset / (viewModel.height)
        if progress <= 1 {
            return Double(1 - progress)
        }
        return 1
    }
}

struct MiniPlayer_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct PlayBackVideoButtons: View {
    var image: String
    var title: String
    
    var body: some View {
        Button(action: {}) {
            VStack(spacing: 8) {
                Image(systemName: image)
                    .font(.title3)
                Text(title)
                    .fontWeight(.semibold)
                    .font(.caption)
            }
        }
        .foregroundColor(.black)
        .frame(maxWidth: .infinity)
    }
}
struct VideoControls: View {
    @EnvironmentObject var player: VideoPlayerViewModel
    
    var body: some View {
        HStack(spacing: 15) {
            Rectangle()
                .fill(Color.clear)
                .frame(width: 150, height: 75)
            VStack(alignment: .leading, spacing: 6) {
                Text("Sea Creature That Made Megalodon Disappear Is Still Alive")
                    .font(.callout)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .lineLimit(1)
                Text("BRIGHT SIDE")
                    .fontWeight(.bold)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Button(action: {}) {
                Image(systemName: "pause.fill")
                    .font(.title2)
                    .foregroundColor(.black)
            }
            Button(action: {
                player.showPlayer.toggle()
                player.offset = 0
                player.isMiniPlayer.toggle()
            }) {
                Image(systemName: "xmark")
                    .font(.title2)
                    .foregroundColor(.black)
            }
        }
    }
}
