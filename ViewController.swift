//
//  ViewController.swift
//  Swift_Self
//
//  Created by MariyaShestakova on 8/5/19.
//  Copyright © 2019 MariyaShestakova. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var openDaughterWindow: NSButton!
    @IBOutlet weak var closeAllDaughterWindows: NSButton!
    @IBOutlet weak var table: NSTableView!
    
    var tableData = [Data]()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any?
    {
        didSet
        {
        // Update the view, if already loaded.
        }
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?)
    {
        if let child = segue.destinationController as? DaughterViewController
        {
            child.parentController = self
        }
    }
    
    @IBAction func ShowDaughterWindowClicked(_ sender: NSButton)
    {
       
    }
    
    @IBAction func CloseAllDaughterWindowsClicked(_ sender: NSButton)
    {
        for item in (self.view.window?.childWindows)!
        {
            item.close()
        }
    }
    
    func addData(data: Data) -> Void
    {
        tableData.append(data)
        UpdateTableData()
    }
    
    func UpdateTableData() -> Void
    {
        table.reloadData()
    }
}



extension ViewController: NSTableViewDataSource
{
    func numberOfRows(in tableView: NSTableView) -> Int
    {
        return tableData.count
    }
}

extension ViewController: NSTableViewDelegate
{
    fileprivate enum CellIdentifiers
    {
        static let numberCell = "numberCellID"
        static let textCell = "textCellID"
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView?
    {
        var content: String = ""
        var cellID: String = ""
        
        var item: Data
        if row <= tableData.count
        {
            item = tableData[row]
        }
        else
        {
            return nil
        }
        
        if tableColumn == tableView.tableColumns[0]
        {
            content = String(row)
            cellID = CellIdentifiers.numberCell
        }
        else if tableColumn == tableView.tableColumns[1]
        {
            content = item.text
            cellID = CellIdentifiers.textCell
        }
        
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellID), owner: nil) as? NSTableCellView
        {
            cell.textField?.stringValue = content
            return cell
        }
        return nil
    }
}
