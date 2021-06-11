//
//  Video.swift
//  YoutubeDesign
//
//  Created by Dastan Zhapay on 06.06.2021.
//

import UIKit

class Video: NSObject {
    var thumbnailImageName: String?
    var title: String?
    var numberOfViews: NSNumber?
    var uploadDate: NSDate?
    
    var channel: Channel?
}

class Channel: NSObject {
    var name: String?
    var profileImageName: String?
}
