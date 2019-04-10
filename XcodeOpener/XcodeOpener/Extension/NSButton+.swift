//
//  NSButton+.swift
//  XcodeOpener
//
//  Created by chen he on 2019/4/10.
//  Copyright © 2019 chen he. All rights reserved.
//

import Cocoa

extension NSButton {
    var isOn: Bool {
        get {
            return self.state == .on
        }
        set {
            self.state = newValue ? .on : .off
        }
    }
}
