//
//  ConversationViewController.swift
//  SampleApp
//
//  Created by Luis Castillo on 7/25/19.
//  Copyright © 2019 LivePerson. All rights reserved.
//

import UIKit
import LPMessagingSDK
import LPAMS
import LPInfra

class ConversationViewController: UIViewController {

    //MARK: - Properties
    var account: String? = nil
    var conversationQuery: ConversationParamProtocol?

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    //MARK: - Actions
    public func backButtonPressed() {
        if let accountNumber = self.account {
            self.conversationQuery = LPMessagingSDK.instance.getConversationBrandQuery(accountNumber)
            if let conversationQueryParam = self.conversationQuery {
                LPMessagingSDK.instance.removeConversation(conversationQueryParam)
            }
        }
    }

    func menuButtonPressed() {
        var style = UIAlertController.Style.actionSheet

        if UIDevice.current.userInterfaceIdiom == .pad {
            style = .alert
        }

        let alertController = UIAlertController(title: "Menu", message: "Choose an option", preferredStyle: style)

        
        if let conversationQueryParam = self.conversationQuery {
            /**
             is how to resolve a conversation
             */
            let resolveAction = UIAlertAction(title: "Resolve", style: .default) { (alert: UIAlertAction) -> Void in
                if self.conversationQuery != nil {
                    LPMessagingSDK.instance.resolveConversation(conversationQueryParam)
                }
            }
            
            let urgentTitle = LPMessagingSDK.instance.isUrgent(conversationQueryParam) ? "Dismiss Urgent" : "Mark as Urgent"
            
            /**
             This is how to manage the urgency state of the conversation
             */
            let urgentAction = UIAlertAction(title: urgentTitle, style: .default) { (alert: UIAlertAction) -> Void in
                if LPMessagingSDK.instance.isUrgent(conversationQueryParam) {
                    LPMessagingSDK.instance.dismissUrgent(conversationQueryParam)
                } else {
                    LPMessagingSDK.instance.markAsUrgent(conversationQueryParam)
                }
            }
            
            alertController.addAction(resolveAction)
            alertController.addAction(urgentAction)
        }
        

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true)
    }
}
