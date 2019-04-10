//
//  AppDefaults.swift
//  XcodeOpener
//
//  Created by chen he on 2019/4/10.
//  Copyright © 2019 chen he. All rights reserved.
//

import Foundation


public class AppDefaults {
    static let shared = AppDefaults()
    @discardableResult init() {
        let defaults: [String: Any] = [
            AppKeys.startAtLogin.rawValue: false,
            AppKeys.menuOnly.rawValue: false
        ]
        UserDefaults.standard.register(defaults: defaults)
    }
}

public enum AppKeys: String {
    case startAtLogin = "startAtLogin"
    case menuOnly = "menuOnly"
    case xcodes = "xcodes"
    case rules = "rules"
}

extension AppDefaults: KeyValueStoreType {
    public func bool(for key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }
    
    public func setBool(for key: String, _ flag: Bool) {
        UserDefaults.standard.set(flag, forKey: key)
    }
    
    public func data(for key: String) -> Data? {
        return UserDefaults.standard.data(forKey:key)
    }
    
    public func setData(for key: String, _ data: Data) {
        UserDefaults.standard.setValue(data, forKey: key)
    }
}
