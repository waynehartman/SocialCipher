//
//  ViewController.swift
//  SocialCypher
//
//  Created by Wayne Hartman on 12/16/17.
//  Copyright © 2017 WayneHartman. All rights reserved.
//

import UIKit

internal class ViewController: UIViewController {
    @IBOutlet fileprivate var textInputView: UITextView!
    @IBOutlet fileprivate var textOutputView: UITextView!
    @IBOutlet fileprivate var countdownLabel: UILabel!
    @IBOutlet fileprivate var swapButton: UIButton!
    @IBOutlet fileprivate var clearButton: UIBarButtonItem!
    @IBOutlet fileprivate var hairLineConstraints: [NSLayoutConstraint]!

    private let maxChars = 280
    private let cypher: Cypher = ROT13Cypher()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupNotifications()
        self.updateCountdown()
        self.updateButtons()
        
        for constraint in self.hairLineConstraints {
            constraint.constant = 1.0 / UIScreen.main.scale
        }
    }
}

// MARK: -
// MARK: Utility Methods
// MARK: -

extension ViewController {
    fileprivate func updateButtons() {
        let enabled = self.textInputView.text.count > 0

        self.swapButton.isEnabled = enabled
        self.clearButton.isEnabled = enabled
    }
    
    fileprivate func updateCountdown() {
        let diff = maxChars - self.textInputView.text.count
        self.countdownLabel.text = String(diff)
    }
    
    fileprivate func encode(text: String) {
        let encodedText = self.cypher.encode(forString: text)
        self.textOutputView.text = encodedText
    }
}

// MARK: -
// MARK: Actions
// MARK: -

extension ViewController {
    @IBAction private func didSelectSwap(_ sender: Any) {
        self.textInputView.text = self.textOutputView.text
        self.textViewDidChange(self.textInputView)
    }

    @IBAction private func didSelectClearButton(_ sender: Any) {
        self.textInputView.text = ""
        self.textViewDidChange(self.textInputView)
    }
}

// MARK: -
// MARK: Notifications
// MARK: -

extension ViewController {
    fileprivate func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillResignActive(notification:)), name: Notification.Name.UIApplicationWillResignActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillResume(notification:)), name: Notification.Name.UIApplicationWillEnterForeground, object: nil)
    }
    
    @objc private func applicationWillResignActive(notification: Notification) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = self.textOutputView.text
    }
    
    @objc private func applicationWillResume(notification: Notification) {
        let pasteboard = UIPasteboard.general
        self.textInputView.text = pasteboard.string
        
        self.textViewDidChange(self.textInputView)
    }
}

// MARK: -
// MARK: UITextViewDelegate
// MARK: -

extension ViewController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.encode(text: textView.text)
        self.updateCountdown()
        self.updateButtons()
    }
}

