//
//  XcodeAlias.swift
//  XcodeOpener
//
//  Created by chen he on 2019/4/10.
//  Copyright © 2019 chen he. All rights reserved.
//

import Foundation

struct XcodeAlias: Codable {
    let alias: String
    let applicationPath: String
    
    static func == (lhs: XcodeAlias, rhs: XcodeAlias) -> Bool {
        return lhs.alias == rhs.alias && lhs.applicationPath == rhs.applicationPath
    }
}
