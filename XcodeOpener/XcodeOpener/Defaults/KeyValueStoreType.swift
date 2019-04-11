//
//  KeyValueStoreType.swift
//  XcodeOpener
//
//  Created by chen he on 2019/4/10.
//  Copyright © 2019 chen he. All rights reserved.
//

import Foundation




protocol KeyValueStoreType: class {
    func bool(for key: String) -> Bool
    func setBool(for key: String, _ flag: Bool)
    
    func data(for key: String) -> Data?
    func setData(for key: String, _ data: Data)
    
    func int(for key: String) -> Int
    func setInt(for key: String, _ value: Int)
}
extension KeyValueStoreType {
    var startAtLogin: Bool {
        get {
            return bool(for: AppKeys.startAtLogin.rawValue)
        }
        set {
            setBool(for: AppKeys.startAtLogin.rawValue, newValue)
        }
    }
    var menuOnly: Bool {
        get {
            return bool(for: AppKeys.menuOnly.rawValue)
        }
        set {
            setBool(for: AppKeys.menuOnly.rawValue, newValue)
        }
    }
    
    
    var openRules: Array<XcodeRule> {
        get {
            
            guard let data = data(for: AppKeys.rules.rawValue) else { return [] }
            

            guard let rules = try? JSONDecoder().decode([XcodeRule].self, from: data) else {
                return []
            }
            
            return rules
        }
        set {
            
            guard let data = try? JSONEncoder().encode(newValue) else {
                return
            }
            
            setData(for: AppKeys.rules.rawValue, data)
        }
    }
    
    
    var xcodeAliases: Array<XcodeAlias> {
        get {
            
            guard let data = data(for: AppKeys.xcodes.rawValue) else { return [] }            
            guard let xcodes = try? JSONDecoder().decode([XcodeAlias].self, from: data) else {
                return []
            }
            return xcodes
        }
        set {
            
            guard let data = try? JSONEncoder().encode(newValue) else {
                return
            }
            
            setData(for: AppKeys.xcodes.rawValue, data)
        }
    }
    
    var appMode: ApplicationMode {
        get {
            guard let mode = ApplicationMode(rawValue: int(for: AppKeys.appMode.rawValue)) else { return .menuAndDock }
            return mode
        }
        set {
            setInt(for: AppKeys.appMode.rawValue, newValue.rawValue)
        }
    }
}
