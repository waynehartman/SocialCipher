//
//  Cyphers.swift
//  SocialCypher
//
//  Created by Wayne Hartman on 12/16/17.
//  Copyright © 2017 WayneHartman. All rights reserved.
//

import UIKit

internal protocol Cypher {
    func encode(forString string: String) -> String
}

internal struct ROT13Cypher : Cypher {
    fileprivate var rot13Mapped = [Character:Character]()
    fileprivate let uppercase = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    fileprivate let lowercase = Array("abcdefghijklmnopqrstuvwxyz")

    internal init() {
        for (index, _) in uppercase.enumerated() {
            rot13Mapped[uppercase[index]] = uppercase[(index + 13) % 26]
            rot13Mapped[lowercase[index]] = lowercase[(index + 13) % 26]
        }
    }

    internal func encode(forString string: String) -> String {
        return String(string.map { rot13Mapped[$0] ?? $0 })
    }
}
