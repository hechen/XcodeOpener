//
//  RulesListViewController+TableView.swift
//  XcodeOpener
//
//  Created by chen he on 2019/7/8.
//  Copyright © 2019 chen he. All rights reserved.
//

import AppKit

fileprivate
enum Column: Int {
    case fileExtension = 0
    case alias
    case openWith
}

extension RulesListViewController {
    func configTableView() {
        rulesTableView.allowsMultipleSelection = false
        rulesTableView.delegate = self
        rulesTableView.dataSource = self
    }
}

extension RulesListViewController: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard row < ApplicationOpener.shared.rules.count,  let column = Column(rawValue: row) else {
            return nil
        }
        
        let rule = ApplicationOpener.shared.rules[row]
        var text: String?
        var itemIdentifier: NSUserInterfaceItemIdentifier?
        
        switch column {
        case .fileExtension:
            itemIdentifier = .ruleFileExtension
            text = rule.condition.rawValue
        case .alias:
            itemIdentifier = .ruleAlias
            text = rule.xcodeAlias.alias
        case .openWith:
            itemIdentifier = .ruleOpenWith
            text = rule.execution
        }
        
        guard let cellID = itemIdentifier, let cellText = text else { return nil }
        
        let cell = tableView.makeView(withIdentifier: cellID, owner: nil) as? NSTableCellView
        cell?.textField?.stringValue = cellText
        return cell
    }
}

extension RulesListViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return ApplicationOpener.shared.rules.count
    }
}
