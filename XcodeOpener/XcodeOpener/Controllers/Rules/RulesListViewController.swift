//
//  OpenRulesListViewController.swift
//  XcodeOpener
//
//  Created by chen he on 2019/4/10.
//  Copyright © 2019 chen he. All rights reserved.
//

import Cocoa

class RulesListViewController: NSViewController {
    
    @IBOutlet weak var rulesTableView: NSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
    }
    
    @IBAction func addAction(_ sender: Any) {
        // open add sheet. then reload
        
        let addRuleViewController = NSStoryboard.rules.instantiateAddRuleViewController()
        addRuleViewController.ruleDidChange = { [weak self] in
            ApplicationOpener.shared.addRule($0)
            self?.rulesTableView.reloadData()
        }
        presentAsSheet(addRuleViewController)
    }
    
    @IBAction func removeAction(_ sender: Any) {
        if rulesTableView.selectedRow == -1 {
            return
        }
        
        let rule = ApplicationOpener.shared.rules[rulesTableView.selectedRow]
        ApplicationOpener.shared.removeRule(rule)
        
        rulesTableView.reloadData()
    }
}

