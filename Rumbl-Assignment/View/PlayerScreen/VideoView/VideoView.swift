//  Rumbl-Assignment
//
//  Created by malikj on 05/01/20.
//  Copyright © 2020 malikj. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

protocol BackClickDelegate : AnyObject {
    
    func BackClicked()
}

class VideoView: UIView {
    
    weak var delegate:BackClickDelegate?
    var playerLayer: AVPlayerLayer?
    var player: AVPlayer?
    var isLoop: Bool = false
    var backArrowImage:UIImageView?
    var backImageArea: CGRect?

    private func setupView() {
         backArrowImage = UIImageView()
        let image = UIImage(named:  Constants.ImageNames.backIconImage) as UIImage?
        backArrowImage?.image = image;
        backArrowImage?.frame = CGRect(x: 20, y: 20, width: 20, height: 20)
        backImageArea = backArrowImage?.frame;
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleGesture(_:)))
        self.addGestureRecognizer(tapGesture)
        playerLayer!.addSublayer(backArrowImage!.layer)
    }
    
    @objc func handleGesture(_ gestureRecognizer: UIGestureRecognizer) {
        let p = gestureRecognizer.location(in: self)
        if backImageArea!.contains(p) {
            self.stop()
            delegate?.BackClicked()
        }
    }
    
    func configure(url: String) {
        if let videoURL = URL(string: url) {
            player = AVPlayer(url: videoURL)
            playerLayer = AVPlayerLayer(player: player)
            playerLayer?.frame = bounds
            playerLayer?.videoGravity = AVLayerVideoGravity.resize
            if let playerLayer = self.playerLayer {
                layer.addSublayer(playerLayer)
            }
            NotificationCenter.default.addObserver(self, selector: #selector(reachTheEndOfTheVideo(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem)
        }
    }
    
    func play() {
        if player?.timeControlStatus != AVPlayer.TimeControlStatus.playing {
            player?.play()
            setupView()
        }
    }
    
    func pause() {
        player?.pause()
    }
    
    func stop() {
        player?.pause()
    }
    
    @objc func reachTheEndOfTheVideo(_ notification: Notification) {
        if isLoop {
            player?.pause()
            player?.play()
        }
    }
}
