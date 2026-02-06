//
//  AppModeSwitcher.swift
//  XcodeOpener
//
//  Created by Chen He on 2019/4/11.
//  Updated for modern macOS APIs
//

import Cocoa

public struct AppModeSwitcher {
    public static var mode: ApplicationMode {
        set {
            switch newValue {
            case .menuAndDock:
                // Regular app with dock icon and menu bar
                NSApp.setActivationPolicy(.regular)
                MainWindowController.shared.window?.makeKeyAndOrderFront(nil)
                NSApp.activate(ignoringOtherApps: true)
                
            case .menuOnly:
                // Accessory app (menu bar only, no dock icon)
                NSApp.setActivationPolicy(.accessory)
                
            case .background:
                // Background app (no UI)
                NSApp.setActivationPolicy(.prohibited)
            }
            AppDefaults.shared.appMode = newValue
        }
        get {
            return AppDefaults.shared.appMode
        }
    }
}
