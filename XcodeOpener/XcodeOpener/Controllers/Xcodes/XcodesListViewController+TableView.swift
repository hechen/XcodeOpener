//
//  XcodesListViewController+TableView.swift
//  XcodeOpener
//
//  Created by chen he on 2019/7/8.
//  Copyright © 2019 chen he. All rights reserved.
//

import AppKit


fileprivate enum Column: Int {
    case alias
    case application
}


extension XcodesListViewController {
    func configTableView() {
        xcodeVersionsList.allowsMultipleSelection = false
        xcodeVersionsList.delegate = self
        xcodeVersionsList.dataSource = self
    }
}

extension XcodesListViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return ApplicationOpener.shared.xcodeAlias.count
    }
}

extension XcodesListViewController: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        guard row < ApplicationOpener.shared.xcodeAlias.count, let column = Column(rawValue: row) else { return nil }
        
        let xcodeAlias = ApplicationOpener.shared.xcodeAlias[row]
        
        var itemIdentifier: NSUserInterfaceItemIdentifier?
        var text: String?
        
        switch column {
        case .alias:
            itemIdentifier = .xcodeAlias
            text = xcodeAlias.alias
        case .application:
            itemIdentifier = .application
            text = xcodeAlias.applicationPath
        }
        
        guard let cellID = itemIdentifier, let cellText = text else { return nil }
        let cell = tableView.makeView(withIdentifier: cellID, owner: nil) as? NSTableCellView
        cell?.textField?.stringValue = cellText
        return cell
    }
}
