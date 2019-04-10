//
//  Rule.swift
//  XcodeOpener
//
//  Created by chen he on 2019/4/10.
//  Copyright © 2019 chen he. All rights reserved.
//

import Foundation


typealias ApplicationExecutionPath = String


protocol Rule {
    var condition: XcodeFileExtension { get }
    var execution: ApplicationExecutionPath { get }
}


struct XcodeRule: Rule, Codable {
    let condition: XcodeFileExtension
    var execution: ApplicationExecutionPath {
        return xcodeAlias.applicationPath
    }
    let xcodeAlias: XcodeAlias
    
    static func == (lhs: XcodeRule, rhs: XcodeRule) -> Bool {
        return lhs.condition == rhs.condition && lhs.xcodeAlias == rhs.xcodeAlias
    }
}
