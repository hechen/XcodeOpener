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
            
            switch mode {
                
            case .menuAndDock:
                break
            case .menuOnly:
                break
            case .background:
                break                
                
            }
            
            AppDefaults.shared.appMode = newValue
        }
        get {
            return AppDefaults.shared.appMode
        }
    }
}
