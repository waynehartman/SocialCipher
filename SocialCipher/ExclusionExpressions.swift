//
//  ExclusionExpressions.swift
//  SocialCipher
//
//  Created by Wayne Hartman on 12/18/17.
//  Copyright © 2017 WayneHartman. All rights reserved.
//

import UIKit

internal enum ExlusionExpressions : String {
    case username = "(?:^|\\s|$|[.])@[\\p{L}0-9_]*"
    case hashtag = "(?:^|\\s|$)#[\\p{L}0-9_]*"
    case url = "(^|[\\s.:;?\\-\\]<\\(])((https?://|www\\.|pic\\.)[-\\w;/?:@&=+$\\|\\_.!~*\\|'()\\[\\]%#,☺]+[\\w/#](\\(\\))?)(?=$|[\\s',\\|\\(\\).:;?\\-\\[\\]>\\)])"
}
