//
//  Home.swift
//  letsplays
//
//  Created by nktn on 2017/06/25.
//  Copyright © 2017年 nakatani. All rights reserved.
//

import UIKit
import SwiftyJSON

public struct Home: CustomStringConvertible {
    let appId: String?
    let title: String?
    let publisher: String?
    let imgURL: URL?
    let linkURL: URL?
    
    public var description: String {
        return "<appId=\(String(describing: appId))"
            + ", title=\(String(describing: title))"
            + ", publisher=\(String(describing: publisher))"
            + ", imgURL=\(String(describing: imgURL))"
            + ", linkURL=\(String(describing: linkURL))>"
    }
    
    init(json: JSON) {
        self.appId = json["id"]["attributes"]["im:id"].string ?? ""
        self.title = json["im:name"]["label"].string ?? ""
        self.publisher = json["im:artist"]["label"].string ?? ""
        let link_str = json["link"]["attributes"]["href"].string ?? ""
        let link_url_str = String(format: "%@", link_str)
        self.linkURL = URL(string: link_url_str)
        
        if let images = json["im:image"].array, images.count > 0 {
            let original_icon_url_str = json["im:image"][0]["label"].string ?? ""
            let icon_url_str = String(format: "%@", original_icon_url_str)
            self.imgURL = URL(string: icon_url_str)
        }
        else {
            self.imgURL = nil
        }
    }
}
