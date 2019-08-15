//
//  DaughterViewController.swift
//  Swift_Self
//
//  Created by MariyaShestakova on 8/6/19.
//  Copyright © 2019 MariyaShestakova. All rights reserved.
//

import Cocoa

class DaughterViewController: NSViewController {

    var parentController: ViewController!
    
    @IBOutlet weak var cancelButton: NSButton!
    @IBOutlet weak var okButton: NSButton!
    @IBOutlet weak var textField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func viewDidAppear() {
        parentController.view.window?.addChildWindow(self.view.window!, ordered: NSWindow.OrderingMode.above)
    }
    
    @IBAction func CancelClicked(_ sender: Any) {
        
        parentController.view.window?.removeChildWindow(self.view.window!)
        view.window?.close()
    }
    
    @IBAction func OkClicked(_ sender: Any) {
        let currentData: Data = Data(text: textField.stringValue, state: true, window: self.view.window!)
        
        func closure() -> Void
        {
             parentController.addData(data: currentData)
        }
        
        closure()
        
        parentController.view.window?.removeChildWindow(self.view.window!)
        view.window?.close()
    }
}
