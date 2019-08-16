//
//  DaughterViewController.swift
//  Swift_Self
//
//  Created by MariyaShestakova on 8/6/19.
//  Copyright © 2019 MariyaShestakova. All rights reserved.
//

import Cocoa

class ChildViewController: NSViewController {

    var _parentController: ViewController!
    
    @IBOutlet weak var _cancelButton: NSButton!
    @IBOutlet weak var _okButton: NSButton!
    @IBOutlet weak var _textField: NSTextField!
    
    var onDone: (_ text: String, _ status: Bool, _ window: NSWindow) -> Void = {(text, status, window) in}
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do view setup here.
    }
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override func viewDidAppear()
    {
        _parentController.view.window?.addChildWindow(self.view.window!, ordered: NSWindow.OrderingMode.above)
    }
    
    @IBAction func cancelClicked(_ sender: Any)
    {
        actions(_textField.stringValue, false, self.view.window!)
    }
    
    @IBAction func okClicked(_ sender: Any)
    {
        actions(_textField.stringValue, true, self.view.window!)
    }
    
    func actions(_ text: String, _ status: Bool, _ window: NSWindow) -> Void
    {
        onDone(text, status, window)
        _parentController.view.window?.removeChildWindow(window)
        view.window?.close()
    }
}
