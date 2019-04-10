//
//  AddXcodeViewController.swift
//  XcodeOpener
//
//  Created by chen he on 2019/4/10.
//  Copyright © 2019 chen he. All rights reserved.
//

import Cocoa


typealias AddXodeAliasHandler = (XcodeAlias)->Void

class AddXcodeViewController: NSViewController {
    
    @IBOutlet weak var xcodeApplicationTextField: NSTextField!
    
    @IBOutlet weak var xcodeAliasTextField: NSTextField!

    
    public var callback: AddXodeAliasHandler?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func selectXcodeAction(_ sender: Any) {
        let openPanel = NSOpenPanel()
        do {
           let applicationFolderURL = try FileManager.default.url(for: .applicationDirectory, in: .systemDomainMask, appropriateFor: nil, create: false)
            openPanel.directoryURL = applicationFolderURL
        } catch {
            print("Acquire User's Application Folder Failed. \(error)")
        }
        
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseDirectories = false
        openPanel.canChooseFiles = true
        openPanel.canCreateDirectories = false
        openPanel.begin { [weak self] r in
            if r == .OK, let path = openPanel.url?.path {
                self?.xcodeApplicationTextField.stringValue = path
            }
        }
    }
    
    @IBAction func OKAction(_ sender: Any) {
        let alias = xcodeAliasTextField.stringValue
        let application = xcodeApplicationTextField.stringValue
        if alias.isEmpty || application.isEmpty {
            return
        }
        
        let xcodeAlias = XcodeAlias(alias: alias, applicationPath: application)
        callback?(xcodeAlias)
        
        dismiss(sender)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(sender)
    }
}
