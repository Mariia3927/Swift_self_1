//
//  ViewController.swift
//  Swift_Self
//
//  Created by MariyaShestakova on 8/5/19.
//  Copyright © 2019 MariyaShestakova. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var _table: NSTableView!
    var _tableData = [Data]()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        _table.delegate = self
        _table.dataSource = self
    }

    override var representedObject: Any?
    {
        didSet
        {
        }
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?)
    {
        if let child = segue.destinationController as? ChildViewController
        {
            child._parentController = self
            child.onDone = { (text, status, window) in child._parentController.addData(data: Data(_text: text, _state: status, _window: window)) }
        }
    }
    
    @IBAction func showChildWindowClicked(_ sender: NSButton)
    {
       
    }
    
    @IBAction func closeAllChildWindowsClicked(_ sender: NSButton)
    {
        for item in (self.view.window?.childWindows)!
        {
            item.close()
        }
    }
    
    func addData(data: Data) -> Void
    {
        if data._state == true
        {
            _tableData.append(data)
            updateTableData()
        }
    }
    
    func updateTableData() -> Void
    {
        _table.reloadData()
    }
}



extension ViewController: NSTableViewDataSource
{
    func numberOfRows(in tableView: NSTableView) -> Int
    {
        return _tableData.count
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
        var content = ""
        var cellID = ""
        
        var item: Data
        if row <= _tableData.count
        {
            item = _tableData[row]
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
            content = item._text
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
