//
//  VideoPlayerViewModel.swift
//  MiniVideoPlayer
//
//  Created by Simec Sys Ltd. on 14/1/21.
//

import SwiftUI

class VideoPlayerViewModel: ObservableObject {
    @Published var showPlayer: Bool = false
    @Published var offset: CGFloat = 0
    @Published var width: CGFloat = UIScreen.main.bounds.width
    @Published var height: CGFloat = 0
    @Published var isMiniPlayer: Bool = false
}
