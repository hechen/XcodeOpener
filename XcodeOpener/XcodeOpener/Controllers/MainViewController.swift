//
//  MainViewController.swift
//  XcodeOpener
//
//  Created by chen he on 2019/4/10.
//  Copyright © 2019 chen he. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {
    @IBOutlet weak var xcodeListBox: NSBox!
    @IBOutlet weak var ruleListBox: NSBox!
    @IBOutlet weak var startAtLoginButton: NSButton!
    @IBOutlet weak var switchAppModeButton: NSPopUpButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        xcodeListBox.borderType = .noBorder
        ruleListBox.borderType = .noBorder
        startAtLoginButton.isOn = LaunchAtLogin.isEnabled
        
        switchAppModeButton.selectItem(at: AppDefaults.shared.appMode.rawValue)
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        if !ApplicationOpener.shared.checkDefaultApplication(for: .project) || !ApplicationOpener.shared.checkDefaultApplication(for: .workspace) {
            presentAsModalWindow(NSStoryboard.main.instantiateDefaultsSettingViewController())
        }
    }
    
    @IBAction func startAtLoginChecked(_ sender: Any) {
        LaunchAtLogin.isEnabled = startAtLoginButton.isOn
    }
    
    @IBAction func switchApplicationMode(_ sender: Any) {
        guard let mode = ApplicationMode(rawValue: switchAppModeButton.indexOfSelectedItem) else { return }
        AppModeSwitcher.mode = mode
    }
}
