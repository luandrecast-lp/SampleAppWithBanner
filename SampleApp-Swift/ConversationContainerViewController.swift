//
//  ConversationContainerViewController.swift
//  SampleApp
//
//  Created by Luis Castillo on 7/25/19.
//  Copyright © 2019 LivePerson. All rights reserved.
//

import UIKit
import LPMessagingSDK
import LPAMS
import LPInfra

class ConversationContainerViewController: UIViewController {

    //MARK: - Properties
    @IBOutlet weak var bannerContainerView: UIView!
    @IBOutlet weak var conversationContainerView: UIView!
    
    var accountNumber: String? = nil {
        didSet {
            conversationViewController.account = accountNumber
        }
    }
    var conversationQueryProtocol: ConversationParamProtocol? {
        didSet {
            conversationViewController.conversationQuery = conversationQueryProtocol
        }
    }
    
    lazy var conversationViewController: ConversationViewController = {
        return ConversationViewController()
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        //adding the child controller
        conversationViewController.view.frame = conversationContainerView.bounds
        conversationContainerView.addSubview(conversationViewController.view)
        addChild(conversationViewController)
        conversationViewController.didMove(toParent: self)
    }
    
    //MARK: - Actions
    @IBAction func backButtonPressed() {
        conversationViewController.backButtonPressed()
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func menuButtonPressed() {
        conversationViewController.menuButtonPressed()
    }
}
