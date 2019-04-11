//
//  DefaultsSettingViewController.swift
//  XcodeOpener
//
//  Created by chen he on 2019/4/11.
//  Copyright © 2019 chen he. All rights reserved.
//

import Cocoa

class DefaultsSettingViewController: NSViewController {
    
    @IBOutlet weak var xcodeWorkspaceCheckedButton: NSButton!
    @IBOutlet weak var xcodeProjCheckedButton: NSButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        xcodeProjCheckedButton.isOn = ApplicationOpener.shared.checkDefaultApplication(for: .project)
        xcodeWorkspaceCheckedButton.isOn = ApplicationOpener.shared.checkDefaultApplication(for: .workspace)
    }
    
    
    @IBAction func setSelfAsDefaultProjectOpener(_ sender: Any) {
        _ = ApplicationOpener.shared.setDefaultApplication(for: .project)
    }
    
    @IBAction func setSelfAsDefaultWorkspaceOpener(_ sender: Any) {
        _ = ApplicationOpener.shared.setDefaultApplication(for: .workspace)
    }
    
    @IBAction func OKAction(_ sender: Any) {
        if ApplicationOpener.shared.checkDefaultApplication(for: .project)
            && ApplicationOpener.shared.checkDefaultApplication(for: .workspace) {
            dismiss(sender)
        }
    }
    
    @IBAction func quitAction(_ sender: Any) {
        NSApp.terminate(nil)
    }
}
