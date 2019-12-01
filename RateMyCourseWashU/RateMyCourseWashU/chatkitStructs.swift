//
//  chatkitStructs.swift
//  RateMyCourseWashU
//
//  Created by Zoe Wang on 11/30/19.
//  Copyright © 2019 438group. All rights reserved.
//

import Foundation
import SwiftJWT

struct Contact {
    var id: String
    var name: String
    var avatar_url: String
    var roomId: String
}

struct tokenClaim:Claims {
    let instance: String
    let iss: String
    let sub: String
    let exp: Date
    let iat: Date
    let su: Bool
}
