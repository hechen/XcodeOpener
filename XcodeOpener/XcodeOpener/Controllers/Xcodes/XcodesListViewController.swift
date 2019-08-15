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
        
        configTableView()
    }
    
    @IBAction func addXcodeAction(_ sender: Any) {
        
        let xcodeViewController = NSStoryboard.xcodes.instantiateAddXcodeViewController()
        xcodeViewController.callback = { [weak self] in
            ApplicationOpener.shared.addAlias($0)
            self?.xcodeVersionsList.reloadData()
        }
//        presentAsSheet(xcodeViewController)
        presentAsModalWindow(xcodeViewController)
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
