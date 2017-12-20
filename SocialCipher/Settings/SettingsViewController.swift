//
//  SettingsViewController.swift
//  SocialCipher
//
//  Created by Wayne Hartman on 12/19/17.
//  Copyright © 2017 WayneHartman. All rights reserved.
//

import UIKit

internal typealias SettingsChangeHandler = (() -> (Void))

internal class SettingsViewController: UITableViewController {
    @IBOutlet fileprivate var usernameCell: UITableViewCell!
    @IBOutlet fileprivate var hashtagCell: UITableViewCell!
    @IBOutlet fileprivate var urlCell: UITableViewCell!

    fileprivate var settings = Settings()
    fileprivate var handlers = [UITableViewCell: SwitchHandler]()
    
    internal var changeHandler: SettingsChangeHandler?

    override func viewDidLoad() {
        super.viewDidLoad()

        weak var weakSelf = self

        self.addSwitchToCell(cell: self.usernameCell, on: self.settings.excludeUsername) { (on: Bool) -> (Void) in
            weakSelf?.settings.excludeUsername = on
        }
        self.addSwitchToCell(cell: self.hashtagCell, on: self.settings.excludeHashtag) { (on: Bool) -> (Void) in
            weakSelf?.settings.excludeHashtag = on
        }
        self.addSwitchToCell(cell: self.urlCell, on: self.settings.excludeURL) { (on: Bool) -> (Void) in
            weakSelf?.settings.excludeURL = on
        }
    }

    fileprivate func addSwitchToCell(cell: UITableViewCell, on: Bool, handler: @escaping SwitchHandlerCompletion) {
        let swidch = UISwitch()
        swidch.isOn = on
        
        weak var weakSelf = self
        
        let switchHandler = SwitchHandler(swidch: swidch, handler: {(on: Bool) in
            handler(on)

            if let changeHandler = weakSelf?.changeHandler {
                changeHandler()
            }
        })

        self.handlers[cell] = switchHandler
        cell.accessoryView = swidch
    }
}

fileprivate typealias SwitchHandlerCompletion = ((Bool) -> (Void))

fileprivate class SwitchHandler {
    fileprivate let swidch: UISwitch
    fileprivate let handler: SwitchHandlerCompletion

    init(swidch: UISwitch, handler: @escaping SwitchHandlerCompletion) {
        self.swidch = swidch
        self.handler = handler

        swidch.addTarget(self, action: #selector(didToggleSwitch(_:)), for: .valueChanged)
    }

    @objc func didToggleSwitch(_ sender: UISwitch) {
        self.handler(sender.isOn)
    }
}

