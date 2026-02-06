//
//  LaunchAtLogin.swift
//  XcodeOpener
//
//  Created by Chen He on 2019/4/11.
//  Updated for modern macOS APIs
//

import Foundation
import ServiceManagement

public struct LaunchAtLogin {
    private static let id = "app.chen.macos.XcodeOpenerLauncher"
    
    public static var isEnabled: Bool {
        get {
            if #available(macOS 13.0, *) {
                return SMAppService.loginItem(identifier: id).status == .enabled
            } else {
                // Fallback for older macOS - just check our stored preference
                return UserDefaults.standard.bool(forKey: "launchAtLogin")
            }
        }
        set {
            if #available(macOS 13.0, *) {
                do {
                    if newValue {
                        try SMAppService.loginItem(identifier: id).register()
                    } else {
                        try SMAppService.loginItem(identifier: id).unregister()
                    }
                } catch {
                    print("Failed to \(newValue ? "enable" : "disable") launch at login: \(error)")
                }
            } else {
                // Legacy API
                SMLoginItemSetEnabled(id as CFString, newValue)
            }
            UserDefaults.standard.set(newValue, forKey: "launchAtLogin")
        }
    }
}
