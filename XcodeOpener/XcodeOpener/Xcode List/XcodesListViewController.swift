//
//  XcodesListVIewController.swift
//  XcodeOpener
//
//  Created by chen he on 2019/4/10.
//  Copyright © 2019 chen he. All rights reserved.
//

import Cocoa

class XcodesListViewController: NSViewController {


    @IBOutlet weak var xcodeVersionsList: NSTableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        xcodeVersionsList.allowsMultipleSelection = false
        xcodeVersionsList.delegate = self
        xcodeVersionsList.dataSource = self
    }
    
    @IBAction func addXcodeAction(_ sender: Any) {
        
        let xcodeViewController = NSStoryboard.xcodes.instantiateAddXcodeViewController()
        xcodeViewController.callback = { [weak self] in
            ApplicationOpener.shared.addAlias($0)
            self?.xcodeVersionsList.reloadData()
        }
        presentAsSheet(xcodeViewController)
    }
    
    
    @IBAction func removeXcodeAction(_ sender: Any) {
        if xcodeVersionsList.selectedRow == -1 {
            // select nothing
            return
        }
        
        let alias = ApplicationOpener.shared.xcodeAlias[xcodeVersionsList.selectedRow]
        ApplicationOpener.shared.removeAlias(alias)
    }
}


extension XcodesListViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return ApplicationOpener.shared.xcodeAlias.count
    }
}

extension XcodesListViewController: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let xcodeAlias = ApplicationOpener.shared.xcodeAlias[row]
        if tableColumn == tableView.tableColumns[0] {
            if let cell = tableView.makeView(withIdentifier: .xcodeAlias, owner: nil) as? NSTableCellView {
                cell.textField?.stringValue = xcodeAlias.alias
                return cell
            }
        } else if tableColumn == tableView.tableColumns[1] {
            if let cell = tableView.makeView(withIdentifier: .application, owner: nil) as? NSTableCellView {
                cell.textField?.stringValue = xcodeAlias.applicationPath
                return cell
            }
        }
        return nil
    }
}
