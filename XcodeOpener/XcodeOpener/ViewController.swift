//
//  ViewController.swift
//  XcodeOpener
//
//  Created by chen he on 2019/4/10.
//  Copyright © 2019 chen he. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    
    @IBOutlet weak var xcodeListBox: NSBox!
    @IBOutlet weak var rulesBox: NSBox!
    
    
    
    @IBOutlet weak var startAtLoginButton: NSButton!
    
    @IBOutlet weak var menuOnlyButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        xcodeListBox.borderType = .noBorder
        rulesBox.borderType = .noBorder
        
        startAtLoginButton.isOn = AppDefaults.shared.startAtLogin
        menuOnlyButton.isOn = AppDefaults.shared.menuOnly
    }


    @IBAction func setSelfAsDefaultProjectOpener(_ sender: Any) {
        
        
        let success = ApplicationOpener.shared.setAsDeafultApp(for: .project)
        
        if success {
            print("Set Opener as \(XcodeFileExtension.project.rawValue) opener")
        } else {
            print("Set Opener Failed!")
        }
        
    }
    
    @IBAction func setSelfAsDefaultWorkspaceOpener(_ sender: Any) {
        
        let success = ApplicationOpener.shared.setAsDeafultApp(for: .workspace)
        
        if success {
            print("Set Opener as \(XcodeFileExtension.workspace.rawValue) opener")
        } else {
            print("Set Opener Failed!")
        }

        
    }

    @IBAction func startAtLoginChecked(_ sender: Any) {
        
    }
    
    @IBAction func menuOnlyChecked(_ sender: Any) {
        
    }
}

