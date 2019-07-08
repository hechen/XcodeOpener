//
//  LaunchAtLogin.swift
//  XcodeOpener
//
//  Created by chen he on 2019/4/11.
//  Copyright © 2019 chen he. All rights reserved.
//

import Foundation
import ServiceManagement

public struct LaunchAtLogin {
    private static let id = "app.chen.macos.XcodeOpenerLauncher"
    public static var isEnabled: Bool {
        get {
            guard let jobs = (SMCopyAllJobDictionaries(kSMDomainUserLaunchd).takeRetainedValue() as? [[String: AnyObject]]) else {
                return false
            }
            let job = jobs.first { $0["Label"] as! String == id }
            return job?["OnDemand"] as? Bool ?? false
        }
        set {
            SMLoginItemSetEnabled(id as CFString, newValue)
        }
    }
}

