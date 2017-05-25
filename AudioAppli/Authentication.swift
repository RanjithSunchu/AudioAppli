//
//  Authentication.swift
//  MusicApp
//
//  Created by HungDo on 7/24/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

class Authentication {
    
    var username: String?
    var password: String?
    
    func validate() -> Bool {
        return true
    }
    
    func validate(username: String?, password: String?) -> Bool {
        self.username = username
        self.password = password
        
        return validate()
    }
    
}
