//
//  DetailContentView.swift
//  PineTar_Example
//
//  Created by Tommy Martin on 5/16/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import youtube_ios_player_helper

class DetailContentView: UIView{
    @IBOutlet weak var playerView: YTPlayerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        playerView.layer.cornerRadius = 4
        playerView.layer.masksToBounds = true
        self.playerView.load(withVideoId: "G7yP4-ofcFQ")
    }
}
