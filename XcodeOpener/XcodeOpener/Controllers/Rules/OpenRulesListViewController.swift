//
//  OpenRulesListViewController.swift
//  XcodeOpener
//
//  Created by chen he on 2019/4/10.
//  Copyright © 2019 chen he. All rights reserved.
//

import Cocoa

class OpenRulesListViewController: NSViewController {

    @IBOutlet weak var rulesTableView: NSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        rulesTableView.allowsMultipleSelection = false
        rulesTableView.delegate = self
        rulesTableView.dataSource = self
    }
    
    @IBAction func addAction(_ sender: Any) {
        
        // open add sheet. then reload
        
        let addRuleViewController = NSStoryboard.rules.instantiateAddRuleViewController()
        addRuleViewController.callback = { [weak self] in
            ApplicationOpener.shared.addRule($0)
            self?.rulesTableView.reloadData()
        }
        
        presentAsSheet(addRuleViewController)
    }
    
    @IBAction func removeAction(_ sender: Any) {
        if rulesTableView.selectedRow == -1 {
            // select nothing
            return
        }
        
        let rule = ApplicationOpener.shared.rules[rulesTableView.selectedRow]
        ApplicationOpener.shared.removeRule(rule)
        
        rulesTableView.reloadData()
    }
}


extension OpenRulesListViewController: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let rule = ApplicationOpener.shared.rules[row]
        if tableColumn == tableView.tableColumns[0] {  // File Extension
            if let cell = tableView.makeView(withIdentifier: .ruleFileExtension, owner: nil) as? NSTableCellView {
                cell.textField?.stringValue = rule.condition.rawValue
                return cell
            }
        } else if tableColumn == tableView.tableColumns[1] {  // Alias
            if let cell = tableView.makeView(withIdentifier: .ruleAlias, owner: nil) as? NSTableCellView {
                cell.textField?.stringValue = rule.xcodeAlias.alias
                return cell
            }
        } else if tableColumn == tableView.tableColumns[2] { // Open With Path
            if let cell = tableView.makeView(withIdentifier: .ruleOpenWith, owner: nil) as? NSTableCellView {
                cell.textField?.stringValue = rule.execution
                return cell
            }
        }
        return nil
    }
}

extension OpenRulesListViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return ApplicationOpener.shared.rules.count
    }
}
