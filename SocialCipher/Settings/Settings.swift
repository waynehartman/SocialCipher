//
//  Settings.swift
//  SocialCipher
//
//  Created by Wayne Hartman on 12/19/17.
//  Copyright © 2017 WayneHartman. All rights reserved.
//

import UIKit

private let SCUsernameExclusion = "SCUsernameExclusion"
private let SCHashtagExclusion  = "SCHashtagExclusion"
private let SCURLExclusion      = "SCURLExclusion"

internal struct Settings {
    let defaults = UserDefaults.standard
    
    internal var excludeUsername: Bool {
        get {
            return self.defaults.bool(forKey: SCUsernameExclusion)
        }
        set {
            self.defaults.set(newValue, forKey: SCUsernameExclusion)
        }
    }
    
    internal var excludeHashtag: Bool {
        get {
            return self.defaults.bool(forKey: SCHashtagExclusion)
        }
        set {
            self.defaults.set(newValue, forKey: SCHashtagExclusion)
        }
    }
    
    internal var excludeURL: Bool {
        get {
            return self.defaults.bool(forKey: SCURLExclusion)
        }
        set {
            self.defaults.set(newValue, forKey: SCURLExclusion)
        }
    }

    internal init() {
        defaults.register(defaults: [
            SCUsernameExclusion : true,
            SCHashtagExclusion :  true,
            SCURLExclusion : true
        ])
    }
}
