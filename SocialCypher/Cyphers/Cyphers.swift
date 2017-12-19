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
    fileprivate let exclusionExpressions: [NSRegularExpression]
    fileprivate var rot13Mapped = [Character:Character]()
    fileprivate let uppercase = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    fileprivate let lowercase = Array("abcdefghijklmnopqrstuvwxyz")

    internal init() {
        self.exclusionExpressions = [
            try! NSRegularExpression(pattern: ExlusionExpressions.username.rawValue, options: []),
            try! NSRegularExpression(pattern: ExlusionExpressions.hashtag.rawValue, options: []),
            try! NSRegularExpression(pattern: ExlusionExpressions.url.rawValue, options: [])
        ]

        for (index, _) in uppercase.enumerated() {
            rot13Mapped[uppercase[index]] = uppercase[(index + 13) % 26]
            rot13Mapped[lowercase[index]] = lowercase[(index + 13) % 26]
        }
    }

    internal func encode(forString string: String) -> String {
        let indexSet = NSMutableIndexSet()

        for expression in self.exclusionExpressions {
            let expressionMatches = expression.matches(in: string, options: [.withoutAnchoringBounds], range: NSRange.init(location: 0, length: string.count))

            for expressionMatch in expressionMatches {
                indexSet.add(in: expressionMatch.range)
            }
        }

        let transformation = string.enumerated().map { (arg) -> Character in
            let (index, char) = arg

            if indexSet.contains(index) {
                return char
            } else {
                return rot13Mapped[char] ?? char
            }
        }

        return String(transformation)
    }
}
