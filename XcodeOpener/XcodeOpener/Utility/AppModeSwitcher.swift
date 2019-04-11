//
//  AppModeSwitcher.swift
//  XcodeOpener
//
//  Created by chen he on 2019/4/11.
//  Copyright © 2019 chen he. All rights reserved.
//

import Foundation

public struct AppModeSwitcher {
    public static var mode: ApplicationMode {
        set {
            var transformState = ProcessApplicationTransformState(kProcessTransformToForegroundApplication)
            switch newValue {
            case .menuAndDock:
                MainWindowController.shared.window?.makeKeyAndOrderFront(nil)                
            case .menuOnly:
                transformState = ProcessApplicationTransformState(kProcessTransformToUIElementApplication)
            case .background:
                transformState = ProcessApplicationTransformState(kProcessTransformToBackgroundApplication)
            }
            var psn = ProcessSerialNumber(highLongOfPSN: 0, lowLongOfPSN: UInt32(kCurrentProcess))
            if TransformProcessType(&psn, transformState) == 0 {
                AppDefaults.shared.appMode = newValue
            }
        }
        get {
            return AppDefaults.shared.appMode
        }
    }
}
