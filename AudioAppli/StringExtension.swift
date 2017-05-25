//
//  StringExtension.swift
//  MusicApp
//
//  Created by HungDo on 7/26/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

extension String {
    
    static func createRandomString() -> String {
        let numberOfCharacters = Int(arc4random_uniform(UInt32(maximumNumberOfCharacters)))
        return (0 ... numberOfCharacters)
            .map { _ in createRandomCharacter() }
            .reduce("") { (first, second) -> String in first + second }
        
    }
    
    fileprivate static var maximumNumberOfCharacters = 15
    fileprivate static var characters: [String] = ["a", "b", "c", "d", "e", "f", "A", "B", "1", "2", "3", "4", "5", "!", "/", "?", "*", "$"]
    
    fileprivate static func createRandomCharacter() -> String {
        let index = Int(arc4random_uniform(UInt32(characters.count)))
        return characters[index]
    }
    
}
