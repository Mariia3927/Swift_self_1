//
//  DaughterViewController.swift
//  Swift_Self
//
//  Created by MariyaShestakova on 8/6/19.
//  Copyright © 2019 MariyaShestakova. All rights reserved.
//

import Cocoa

class ChildViewController: NSViewController {

    var parentController: ViewController!
    
    @IBOutlet weak var _cancelButton: NSButton!
    @IBOutlet weak var _okButton: NSButton!
    @IBOutlet weak var _textField: NSTextField!
    
    var onDone: (_ text: String, _ canceled: Bool, _ window: NSWindow) -> Void = {(text, canceled, window) in}
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func viewDidAppear()
    {
        parentController.view.window?.addChildWindow(self.view.window!, ordered: NSWindow.OrderingMode.above)
    }
    
    @IBAction func cancelClicked(_ sender: Any)
    {
        buttonClicked(textValue: _textField.stringValue, cancelValue: false, childWindow: self.view.window!)
    }
    
    @IBAction func okClicked(_ sender: Any)
    {
        buttonClicked(textValue: _textField.stringValue, cancelValue: true, childWindow:self.view.window!)
    }
    
    func buttonClicked(textValue text: String, cancelValue canceled: Bool, childWindow window: NSWindow) -> Void
    {
        onDone(text, canceled, window)
        parentController.view.window?.removeChildWindow(window)
        view.window?.close()
    }
}
