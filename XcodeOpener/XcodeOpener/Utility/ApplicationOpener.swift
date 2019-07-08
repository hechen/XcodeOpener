//
//  ApplicationOpener.swift
//  XcodeOpener
//
//  Created by chen he on 2019/4/10.
//  Copyright © 2019 chen he. All rights reserved.
//

import Cocoa
import CoreServices

public protocol FileExtension {
    var type: String { get }
}

// register all Xcode-related files only.
enum XcodeFileExtension: String, CaseIterable, Codable {
    case project = "xcodeproj"
    case workspace = "xcworkspace"
}
extension XcodeFileExtension: FileExtension {
    var type: String {
        return self.rawValue
    }
}

enum XcodeApplication: String {
    case apple = "com.apple.dt.Xcode"
    case opener = "app.chen.macos.XcodeOpener"
}


extension URL {
    var fileExtension: XcodeFileExtension? {
        return XcodeFileExtension(rawValue: self.pathExtension)
    }
}

class ApplicationOpener {
    static let shared = ApplicationOpener()
    
    private(set) var rules = [XcodeRule]()
    private(set) var xcodeAlias = [XcodeAlias]()
    
    init() {
        self.rules = AppDefaults.shared.openRules
        self.xcodeAlias = AppDefaults.shared.xcodeAliases
    }
    
    // use user-defined opener rules to open this file.
    func open(_ file: URL) {
        let rule = rules.filter { $0.match(file.fileExtension) }.first
        if rule == nil {
            // TODO fallback policy
            return
        }
        
        NSWorkspace.shared.openFile(file.path, withApplication: rule!.execution, andDeactivate: true)
    }
    
    func setDefaultApplication(_ application: XcodeApplication = .opener, for xcodeExtension: XcodeFileExtension) -> Bool {
        switch application {
        case .opener:
            return setAsDeafultApp(for: xcodeExtension)
        case .apple:
            return recoverDefaultApp(for: xcodeExtension)
        }
    }
    
    func checkDefaultApplication(for xcodeExtension: XcodeFileExtension) -> Bool {
        return checkDefaultApp(for: xcodeExtension, is: .opener)
    }
    
    
    // MARK: - Add && Remove
    
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


extension ApplicationOpener {
    
    func recoverDefaultApp(for fileExtension: FileExtension) -> Bool {
        guard let UTI = UTI(for: fileExtension) else { return false }
        // error code == 0 when success, or else valid error code.
        return LSSetDefaultRoleHandlerForContentType(UTI, LSRolesMask.all, XcodeApplication.apple.rawValue as CFString) == 0
    }
    
    func setAsDeafultApp(for fileExtension: FileExtension) -> Bool {
        guard let UTI = UTI(for: fileExtension) else { return false }
        // error code == 0 when success, or else valid error code.
        return LSSetDefaultRoleHandlerForContentType(UTI, LSRolesMask.all, XcodeApplication.opener.rawValue as CFString) == 0
    }
    
    func checkDefaultApp(for fileExtension: FileExtension, is application: XcodeApplication) -> Bool {
        guard let UTI = UTI(for: fileExtension) else { return false }
        let defaultHandler = LSCopyDefaultRoleHandlerForContentType(UTI, LSRolesMask.all)?.takeRetainedValue() as String?
        return defaultHandler == application.rawValue
    }
    
    /*
     This function is used to translate a type declared using another declaration mechanism (for example, MIME types)
     into a uniform type identifier.
     */
    private func UTI(for fileExtension: FileExtension) -> CFString? {
        let UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension,
                                                        fileExtension.type as CFString, nil)?.takeRetainedValue()
        return UTI as CFString?
    }
}
