//
//  XcodeDetector.swift
//  XcodeOpener
//
//  Auto-detects installed Xcode versions
//

import Foundation

/// Represents a detected Xcode installation
public struct DetectedXcode: Hashable, Identifiable {
    public var id: String { path }
    
    /// Display name (e.g., "Xcode 15.2")
    public let name: String
    
    /// Version string (e.g., "15.2")
    public let version: String
    
    /// Build number (e.g., "15C500b")
    public let build: String
    
    /// Full path to Xcode.app
    public let path: String
    
    /// Bundle identifier
    public let bundleId: String
}

/// Utility to detect installed Xcode versions
public enum XcodeDetector {
    
    /// Common locations to search for Xcode
    private static let searchPaths = [
        "/Applications",
        NSHomeDirectory() + "/Applications"
    ]
    
    /// Detect all installed Xcode versions
    public static func detectAll() -> [DetectedXcode] {
        var xcodes: [DetectedXcode] = []
        
        for searchPath in searchPaths {
            xcodes.append(contentsOf: detectIn(directory: searchPath))
        }
        
        // Also check xcode-select path
        if let selectedPath = getXcodeSelectPath() {
            let appPath = selectedPath.replacingOccurrences(of: "/Contents/Developer", with: "")
            if let xcode = detectXcode(at: appPath), !xcodes.contains(where: { $0.path == xcode.path }) {
                xcodes.append(xcode)
            }
        }
        
        // Sort by version descending
        return xcodes.sorted { ($0.version, $0.build) > ($1.version, $1.build) }
    }
    
    /// Detect Xcode installations in a directory
    private static func detectIn(directory: String) -> [DetectedXcode] {
        var xcodes: [DetectedXcode] = []
        
        let fileManager = FileManager.default
        guard let contents = try? fileManager.contentsOfDirectory(atPath: directory) else {
            return []
        }
        
        for item in contents {
            // Match Xcode*.app
            guard item.hasPrefix("Xcode") && item.hasSuffix(".app") else { continue }
            
            let fullPath = (directory as NSString).appendingPathComponent(item)
            if let xcode = detectXcode(at: fullPath) {
                xcodes.append(xcode)
            }
        }
        
        return xcodes
    }
    
    /// Parse Xcode info from an app bundle
    private static func detectXcode(at path: String) -> DetectedXcode? {
        let plistPath = (path as NSString).appendingPathComponent("Contents/Info.plist")
        
        guard let plistData = FileManager.default.contents(atPath: plistPath),
              let plist = try? PropertyListSerialization.propertyList(from: plistData, format: nil) as? [String: Any]
        else {
            return nil
        }
        
        guard let bundleId = plist["CFBundleIdentifier"] as? String,
              bundleId == "com.apple.dt.Xcode"
        else {
            return nil
        }
        
        let version = plist["CFBundleShortVersionString"] as? String ?? "Unknown"
        let build = plist["CFBundleVersion"] as? String ?? ""
        let name = "Xcode \(version)"
        
        return DetectedXcode(
            name: name,
            version: version,
            build: build,
            path: path,
            bundleId: bundleId
        )
    }
    
    /// Get the currently selected Xcode path via xcode-select
    private static func getXcodeSelectPath() -> String? {
        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/usr/bin/xcode-select")
        task.arguments = ["-p"]
        
        let pipe = Pipe()
        task.standardOutput = pipe
        task.standardError = FileHandle.nullDevice
        
        do {
            try task.run()
            task.waitUntilExit()
            
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            return String(data: data, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines)
        } catch {
            return nil
        }
    }
    
    /// Get the currently selected Xcode
    public static func getSelectedXcode() -> DetectedXcode? {
        guard let path = getXcodeSelectPath() else { return nil }
        let appPath = path.replacingOccurrences(of: "/Contents/Developer", with: "")
        return detectXcode(at: appPath)
    }
}
