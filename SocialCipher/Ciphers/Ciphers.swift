//
//  Ciphers.swift
//  SocialCipher
//
//  Created by Wayne Hartman on 12/16/17.
//  Copyright © 2017 WayneHartman. All rights reserved.
//

import UIKit

internal protocol Cipher {
    init(exclusionExpressions: [ExlusionExpressions])
    func encode(forString string: String) -> String
}

internal struct ROT13Cipher : Cipher {
    fileprivate let exclusionExpressions: [NSRegularExpression]
    fileprivate var rot13Mapped = [Character:Character]()
    fileprivate let uppercase = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    fileprivate let lowercase = Array("abcdefghijklmnopqrstuvwxyz")

    internal init(exclusionExpressions: [ExlusionExpressions]) {
        var regex = [NSRegularExpression]()
        
        for expression in exclusionExpressions {
            let regexp = try! NSRegularExpression(pattern: expression.rawValue, options: [])
            regex.append(regexp)
        }

        self.exclusionExpressions = regex

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

        let transformation = string.enumerated().map { (enumeratedChar) -> Character in
            if indexSet.contains(enumeratedChar.offset) {
                return enumeratedChar.element
            } else {
                return rot13Mapped[enumeratedChar.element] ?? enumeratedChar.element
            }
        }

        return String(transformation)
    }
}
