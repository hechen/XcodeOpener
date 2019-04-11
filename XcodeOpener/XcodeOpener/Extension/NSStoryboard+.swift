//
//  Extension.swift
//  XcodeOpener
//
//  Created by chen he on 2019/4/10.
//  Copyright © 2019 chen he. All rights reserved.
//

import Cocoa

fileprivate enum CellIdentifiers {
    static let xcode = "XcodeCellID"
    static let application = "XcodeApplicationCellID"
    
    static let ruleFileExtension = "ruleFileExtensionCellID"
    static let ruleAlias = "ruleAliasCellID"
    static let ruleOpenWith = "ruleOpenWithCellID"
}

extension NSUserInterfaceItemIdentifier {
    static let xcodeAlias = NSUserInterfaceItemIdentifier(rawValue: CellIdentifiers.xcode)
    static let application = NSUserInterfaceItemIdentifier(rawValue: CellIdentifiers.application)
    
    static let ruleFileExtension = NSUserInterfaceItemIdentifier(rawValue: CellIdentifiers.ruleFileExtension)
    static let ruleAlias = NSUserInterfaceItemIdentifier(rawValue: CellIdentifiers.ruleAlias)
    static let ruleOpenWith = NSUserInterfaceItemIdentifier(rawValue: CellIdentifiers.ruleOpenWith)
}


extension NSStoryboard.Name {
    public static let xcodes = NSStoryboard.Name("Xcodes")
    public static let rules = NSStoryboard.Name("Rules")
    public static let main = NSStoryboard.Name("Main")
}

extension NSStoryboard {
    static let xcodes = NSStoryboard(name: .xcodes, bundle: nil)
    static let rules = NSStoryboard(name: .rules, bundle: nil)
    static let main = NSStoryboard(name: .main, bundle: nil)
}


extension NSStoryboard.SceneIdentifier {
    public static let mainWindowController = NSStoryboard.SceneIdentifier("MainWindowController")
    public static let addRuleViewController = NSStoryboard.SceneIdentifier("addRuleViewController")
    public static let addXcodeViewController = NSStoryboard.SceneIdentifier("addXcodeViewController")
    public static let defaultsSettingViewController = NSStoryboard.SceneIdentifier("DefaultsSettingViewController")
}

extension NSStoryboard {
    func instantiateAddXcodeViewController() -> AddXcodeViewController {
        let vc = instantiateController(withIdentifier: .addXcodeViewController) as! AddXcodeViewController
        return vc
    }
    func instantiateAddRuleViewController() -> AddRuleViewController {
        let vc = instantiateController(withIdentifier: .addRuleViewController) as! AddRuleViewController
        return vc
    }
    func instantiateMainWindowController() -> MainWindowController {
        let vc = instantiateController(withIdentifier: .mainWindowController) as! MainWindowController
        return vc
    }
    func instantiateDefaultsSettingViewController() -> DefaultsSettingViewController {
        let vc = instantiateController(withIdentifier: .defaultsSettingViewController) as! DefaultsSettingViewController
        return vc
    }
}

