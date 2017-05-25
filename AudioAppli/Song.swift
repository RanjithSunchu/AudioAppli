//
//  Song.swift
//  MusicApp
//
//  Created by HungDo on 7/25/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

struct Song {
    
    var title: String
    var singer: String?
    var imageURL: String?
    var url: String
    
    fileprivate static var samplePlaylist: [Song]!
    
    static func getSamplePlaylist() -> [Song] {
        if let playlist = samplePlaylist {
            return playlist
        }
        
        samplePlaylist = [
            Song(title: "Anh đang nơi đâu", singer: "Miu Lê", imageURL: "miu", url: "AnhDangNoiDau-MiuLe"),
            Song(title: "Mất trí nhớ", singer: "Chi Dân", imageURL: "chi-dan", url: "MatTriNho-ChiDan"),
            Song(title: "Đếm ngày xa em", singer: "OnlyC, Lou Hoàng", imageURL: "onlyc-louhoang", url: "DemNgayXaEm-OnlyCLouHoang")
        ]
        
        return samplePlaylist
    }
    
}
