//
//  Rule.swift
//  XcodeOpener
//
//  Created by chen he on 2019/4/10.
//  Copyright © 2019 chen he. All rights reserved.
//

import Foundation


typealias ApplicationExecutionPath = String

struct XcodeRule: Codable {
    let condition: XcodeFileExtension
    var execution: ApplicationExecutionPath {
        return xcodeAlias.applicationPath
    }
    let xcodeAlias: XcodeAlias
}
extension XcodeRule: Equatable {}

extension XcodeRule {
    func match(_ anotherCond: XcodeFileExtension?) -> Bool {
        if let anotherCond = anotherCond {
            return condition == anotherCond
        }
        return false
    }
}

