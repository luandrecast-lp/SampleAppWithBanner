//
//  ConversationViewController.swift
//  SampleApp
//
//  Created by Luis Castillo on 7/25/19.
//  Copyright © 2019 LivePerson. All rights reserved.
//

import UIKit
import LPMessagingSDK

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
            self.conversationQuery = LPMessaging.instance.getConversationBrandQuery(accountNumber)
            if let conversationQueryParam = self.conversationQuery {
                LPMessaging.instance.removeConversation(conversationQueryParam)
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
                    LPMessaging.instance.resolveConversation(conversationQueryParam)
                }
            }
            
            let urgentTitle = LPMessaging.instance.isUrgent(conversationQueryParam) ? "Dismiss Urgent" : "Mark as Urgent"
            
            /**
             This is how to manage the urgency state of the conversation
             */
            let urgentAction = UIAlertAction(title: urgentTitle, style: .default) { (alert: UIAlertAction) -> Void in
                if LPMessaging.instance.isUrgent(conversationQueryParam) {
                    LPMessaging.instance.dismissUrgent(conversationQueryParam)
                } else {
                    LPMessaging.instance.markAsUrgent(conversationQueryParam)
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
