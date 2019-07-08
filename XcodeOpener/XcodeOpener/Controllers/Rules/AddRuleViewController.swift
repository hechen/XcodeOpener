//
//  AddRuleViewController.swift
//  XcodeOpener
//
//  Created by chen he on 2019/4/10.
//  Copyright © 2019 chen he. All rights reserved.
//

import Cocoa

typealias AddRuleHandler = (XcodeRule)->Void

class AddRuleViewController: NSViewController {
    
    @IBOutlet weak var extensionListButton: NSPopUpButton!
    
    @IBOutlet weak var xcodeAliasListButton: NSPopUpButton!
    
    public var ruleDidChange: AddRuleHandler?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        XcodeFileExtension.allCases.forEach {
            extensionListButton.addItem(withTitle: $0.rawValue)
        }
        ApplicationOpener.shared.xcodeAlias.forEach {
            xcodeAliasListButton.addItem(withTitle: $0.alias)
        }
    }
    
    @IBAction func OKAction(_ sender: Any) {
        guard let selectedExtension = extensionListButton.selectedItem?.title, let fileExtension = XcodeFileExtension(rawValue: selectedExtension) else {
            return
        }
        let xcodeAliasIndex = xcodeAliasListButton.indexOfSelectedItem
        guard xcodeAliasIndex >= 0 && xcodeAliasIndex < ApplicationOpener.shared.xcodeAlias.count else { return }
        
        let xcodeRule = XcodeRule(condition: fileExtension,
                                  xcodeAlias: ApplicationOpener.shared.xcodeAlias[xcodeAliasIndex])
        ruleDidChange?(xcodeRule)
        
        dismiss(sender)
    }
    
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(sender)
    }
}
