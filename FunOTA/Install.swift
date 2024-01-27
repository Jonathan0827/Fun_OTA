import SwiftUI
import CoreServices
import Foundation
func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentsDirectory = paths[0]
    return documentsDirectory
}
func InstallIPA(_ appName: String) {
    consoleManager.print("Installing Fun")
    let IPAPath = "\(getDocumentsDirectory().absoluteString.replacingOccurrences(of: "file://", with: ""))/tmp-\(appName)_OTA_Installation_File.ipa"
    spawnRoot("\(SBFApplication(applicationBundleIdentifier: "com.opa334.TrollStore").bundleURL.path)/trollstorehelper", ["install", IPAPath])
    consoleManager.print("Installing Fun")
    if FileManager.default.fileExists(atPath: IPAPath) {
        do {
            try FileManager.default.removeItem(atPath: IPAPath)
            consoleManager.print("Removed used IPA")
        } catch {
            consoleManager.print("Error: \(error)")
        }
    }
}

func DownloadIPA(_ appName: String) {
    consoleManager.print("Downloading IPA")
    do {
//        let IPAPath = "/var/mobile/Documents/tmp-Fun_OTA_Upgrade.ipa"
        let IPAPath = "\(getDocumentsDirectory().absoluteString.replacingOccurrences(of: "file://", with: ""))/tmp-\(appName)_OTA_Installation_File.ipa"
        let docPaths = try FileManager.default.contentsOfDirectory(at: getDocumentsDirectory(), includingPropertiesForKeys: nil)
        for docPath in docPaths where docPath.pathExtension == "ipa" {
            try FileManager.default.removeItem(at: docPath)
        }
        FileManager.default.createFile(atPath: IPAPath, contents: try Data(contentsOf: URL(string: "https://jonathan.kro.kr/Fun_iOS_Rewrite/\(appName).ipa")!))
        consoleManager.print("Downloaded IPA")
    } catch {
        print(error)
        consoleManager.print("Error: \(error)")
    }
}

func installApp(_ type: Bool) {
    DownloadIPA(type ? "Fun" : "FunOTA")
    InstallIPA(type ? "Fun" : "FunOTA")
}
