//
//  ViewController.swift
//  ABC
//
//  Created by MINGKYME on 2021/12/11.
//
import Combine
import Cocoa
import Transmission
class ViewController: NSViewController, NSWindowDelegate {
    
    @IBOutlet weak var urlTextField: NSTextField!
    @IBOutlet weak var usernameTextField: NSTextField!
    @IBOutlet weak var passwordSecureTextField: NSSecureTextField!
    @IBAction func saveButton(_ sender: Any) {
        
        let url = urlTextField.stringValue
        let username = usernameTextField.stringValue
        let password = passwordSecureTextField.stringValue
        let userDefaults = UserDefaults.standard
        userDefaults.set(url, forKey: "url")
        userDefaults.set(username, forKey: "username")
        userDefaults.set(password, forKey: "password")
        
        let a = NSAlert()
        a.messageText = "Saved"
        a.informativeText = "Data saved"
        a.addButton(withTitle: "OK")
        a.alertStyle = NSAlert.Style.informational
        a.runModal()
    }
    var cancellables = Set<AnyCancellable>()
    override func viewDidLoad() {
        super.viewDidLoad()
        let userDefaults = UserDefaults.standard
        urlTextField.stringValue = userDefaults.string(forKey: "url") ?? ""
        usernameTextField.stringValue = userDefaults.string(forKey: "username") ?? ""
        passwordSecureTextField.stringValue = userDefaults.string(forKey: "password") ?? ""
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    override func viewDidAppear() {
        self.view.window?.delegate = self
    }
    func windowShouldClose(_ sender: NSWindow) -> Bool {
        NSApplication.shared.terminate(self)
        return true
    }

}

