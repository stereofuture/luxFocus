//
//  ViewController.swift
//  LuxFocusRedux
//
//  Created by Brian Dorn on 10/17/18.
//  Copyright © 2018 Brian Dorn. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    var namedApplications = [String: String]()
    var namedApplicationsKeys = [String]()
    var namedApplicationValues = [String]()
    
    @IBOutlet weak var ReclassifyAmbiguous: NSButton!
    @IBOutlet weak var ReclassifyFocus: NSButton!
    @IBOutlet weak var ReclassifyFree: NSButton!
    @IBOutlet weak var tableView: NSTableView!
    
    override func viewDidAppear() {
        super.viewDidAppear()
        getNamedApplications()
        updateNamedApplications()
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    override func viewWillDisappear() {
        UserDefaults.standard.set(namedApplications, forKey: "storedNamedApps")
    }
    
    func getNamedApplications(){
        if let storedNamedApps = UserDefaults.standard.object(forKey: "storedNamedApps") {
            namedApplications = (storedNamedApps as? [String: String])!
            namedApplicationsKeys = Array(namedApplications.keys)
            namedApplicationValues = Array(namedApplications.values)
            print(namedApplications)
        }
    }
    
    // MARK:  - TableView for ApplicationTable
    func numberOfRows(in tableView: NSTableView) -> Int {
        return namedApplications.count
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if convertFromNSUserInterfaceItemIdentifier((tableColumn?.identifier)!) == "ApplicationColumn" {
            if let cell = tableView.makeView(withIdentifier: convertToNSUserInterfaceItemIdentifier("ApplicationCell"), owner: self) as? NSTableCellView {
                cell.textField?.stringValue = namedApplicationsKeys[row]
                return cell
            }
        } else {
            if let cell = tableView.makeView(withIdentifier: convertToNSUserInterfaceItemIdentifier("ClassificationCell"), owner: self) as? NSTableCellView {
                cell.textField?.stringValue = namedApplicationValues[row]
                return cell
            }
        }

        return nil
    }
    
    func updateNamedApplications() {
        namedApplicationsKeys = Array(namedApplications.keys)
        namedApplicationValues = Array(namedApplications.values)
        tableView.reloadData()
    }

    @IBAction func classifyClickedAsAmbiguous(_ sender: Any) {
        if tableView.selectedRow >= 0  {
            let selectedApplicationKey = namedApplicationsKeys[tableView.selectedRow]
            namedApplications.updateValue("Ambiguous", forKey: selectedApplicationKey)
            updateNamedApplications()
        }
        
    }
    
    @IBAction func classifyClickedAsFocus(_ sender: Any) {
        if tableView.selectedRow >= 0  {
            let selectedApplicationKey = namedApplicationsKeys[tableView.selectedRow]
            namedApplications.updateValue("Focus", forKey: selectedApplicationKey)
            updateNamedApplications()
        }
    }
    
    @IBAction func classifyClickedAsFree(_ sender: Any) {
        if tableView.selectedRow >= 0  {
            let selectedApplicationKey = namedApplicationsKeys[tableView.selectedRow]
            namedApplications.updateValue("Free", forKey: selectedApplicationKey)
            updateNamedApplications()
        }
    }

}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSUserInterfaceItemIdentifier(_ input: NSUserInterfaceItemIdentifier) -> String {
	return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToNSUserInterfaceItemIdentifier(_ input: String) -> NSUserInterfaceItemIdentifier {
	return NSUserInterfaceItemIdentifier(rawValue: input)
}
