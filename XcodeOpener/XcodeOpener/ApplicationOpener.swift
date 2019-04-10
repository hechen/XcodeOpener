//
//  ApplicationOpener.swift
//  XcodeOpener
//
//  Created by chen he on 2019/4/10.
//  Copyright © 2019 chen he. All rights reserved.
//

import Cocoa
import CoreServices


enum XcodeFileExtension: String, CaseIterable, Codable {
    case project = "xcodeproj"
    case workspace = "xcworkspace"
}

class ApplicationOpener {
    
    static let shared = ApplicationOpener()
    
    private(set) var rules = [XcodeRule]()
    private(set) var xcodeAlias = [XcodeAlias]()
    
    init() {
        self.rules = AppDefaults.shared.openRules
        self.xcodeAlias = AppDefaults.shared.xcodeAliases
    }
    
    func setAsDeafultApp(for fileExtension: XcodeFileExtension) -> Bool {
        guard let UTI = UTI(for: fileExtension) else { return false }
        guard let bundleIdentifier = Bundle.main.bundleIdentifier else { return false }
        
        let status = LSSetDefaultRoleHandlerForContentType(UTI, LSRolesMask.all, bundleIdentifier as CFString)
        
        print("LSSetDefaultRoleHandlerForContentType return status: \(status)")
        
        // error code == 0 when success, or else valid error code.
        return status == 0
    }
    
    func open(_ file: URL) {        
        // using user-defined opener rules to open this file.
        let rule = rules.filter {
            $0.condition.rawValue == file.pathExtension
        }.first
        if rule == nil {
            // fallback policy
            return
        }
        let ret = NSWorkspace.shared.openFile(file.path, withApplication: rule!.execution, andDeactivate: true)
        
        print("Open File \(file) using Application \(rule!.execution) \( ret ? "Successfully" : "Failed" )")
    }
    
    /*
     This function is used to translate a type declared using another declaration mechanism (for example, MIME types)
     into a uniform type identifier.
     */
    private func UTI(for fileExtension: XcodeFileExtension) -> CFString? {
        let UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, fileExtension.rawValue as CFString, nil)?.takeRetainedValue()
        return UTI as CFString?
    }
    
        
    func removeRule(_ rule: XcodeRule) {
        rules.removeAll { $0 == rule }
        
        AppDefaults.shared.openRules = rules
    }
    
    func addRule(_ rule: XcodeRule) {
        rules.append(rule)
        
        AppDefaults.shared.openRules = rules
    }
    
    
    func addAlias(_ alias: XcodeAlias) {
        xcodeAlias.append(alias)
        
        AppDefaults.shared.xcodeAliases = xcodeAlias
    }
    
    func removeAlias(_ alias: XcodeAlias) {
        xcodeAlias.removeAll { $0 == alias }
        
        AppDefaults.shared.xcodeAliases = xcodeAlias
    }
}
