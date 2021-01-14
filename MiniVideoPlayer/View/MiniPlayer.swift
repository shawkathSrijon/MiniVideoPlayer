//
//  MiniPlayer.swift
//  MiniVideoPlayer
//
//  Created by Simec Sys Ltd. on 14/1/21.
//

import SwiftUI

struct MiniPlayer: View {
    var body: some View {
        VStack {
            VideoPlayerView()
                .frame(height: 250)
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
            }
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
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
