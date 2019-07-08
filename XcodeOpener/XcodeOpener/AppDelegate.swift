//
//  AppDelegate.swift
//  XcodeOpener
//
//  Created by chen he on 2019/4/10.
//  Copyright © 2019 chen he. All rights reserved.
//

import Cocoa

extension Notification.Name {
    static let killLauncher = Notification.Name("app.chen.macos.XcodeOpener.killLauncher")
}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        let launcherAppId = "app.chen.osx.XcodeOpenerLauncher"
        let runningApps = NSWorkspace.shared.runningApplications
        let isRunning = !runningApps.filter { $0.bundleIdentifier == launcherAppId }.isEmpty
        
        if isRunning {
            DistributedNotificationCenter.default().post(name: .killLauncher,
                                                         object: Bundle.main.bundleIdentifier!)
        }
        
        if let button = statusItem.button {
            button.image = NSImage(named:NSImage.Name("open"))
            constructMenu()
        }        
        AppModeSwitcher.mode = AppDefaults.shared.appMode
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func application(_ application: NSApplication, open urls: [URL]) {
        guard urls.count > 0 else { return }
        urls.forEach {
            ApplicationOpener.shared.open($0)
        }
    }
    
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        MainWindowController.shared.window?.makeKeyAndOrderFront(nil)
        return true
    }
}

extension AppDelegate {
    private func constructMenu() {
        let menu = NSMenu()
        
        menu.addItem(NSMenuItem(title: "Show Main Window", action: #selector(showMainWindow(_:)), keyEquivalent: "m"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Back to Xcode", action: #selector(recoverToApple(_:)), keyEquivalent: "r"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(terminate(_:)), keyEquivalent: "q"))
        
        statusItem.menu = menu
    }
    
    @objc func showMainWindow(_ sender: Any) {
        MainWindowController.shared.window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }
    
    @objc func terminate(_ sender: Any) {
        NSApp.terminate(sender)
    }
    
    @objc func recoverToApple(_ sender: Any) {
        _ = ApplicationOpener.shared.setDefaultApplication(.apple, for: .project)
        _ = ApplicationOpener.shared.setDefaultApplication(.apple, for: .workspace)
    }
}
