//
//  AppDelegate.swift
//  ABC
//
//  Created by MINGKYME on 2021/12/11.
//

import Cocoa
import Combine
import Transmission
@main
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
    var cancellables = Set<AnyCancellable>()
    func application(_ application: NSApplication, open urls: [URL]) {
        let userDefaults = UserDefaults.standard
        let url = userDefaults.string(forKey: "url") ?? ""
        let username = userDefaults.string(forKey: "username") ?? ""
        let password = userDefaults.string(forKey: "password") ?? ""
        
        if let transmissionUrl = URL(string: url){
            // URL(string: "/Users/mingky/Downloads/ubuntu-21.10-desktop-amd64.iso.torrent")!
            let client = Transmission(baseURL: transmissionUrl, username: username, password: password)
            client.request(.add(fileURL: urls[0]))
                        .sink(
                            receiveCompletion: { completion in
                                if case let .failure(error) = completion {
                                    print(error.localizedDescription)
                                    DispatchQueue.main.async {
                                        let a = NSAlert()
                                        a.messageText = "Fail"
                                        a.informativeText = error.localizedDescription
                                        a.addButton(withTitle: "OK")
                                        a.alertStyle = NSAlert.Style.critical
                                        a.runModal()
                                    }
                                }
                            },
                            receiveValue: { _ in
                                DispatchQueue.main.async {
                                    NSApplication.shared.terminate(self)
                                }
                            }
                        )
                        .store(in: &cancellables)
        }
    }
}
