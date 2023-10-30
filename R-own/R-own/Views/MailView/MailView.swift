//
//  MailView.swift
//  R-own
//
//  Created by Aman Sharma on 25/07/23.
//

import SwiftUI
import MessageUI

struct MailView: UIViewControllerRepresentable {
    @Binding var isShowingMailView: Bool
    let recipient: String
    let subject: String
    let body: String

    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let mailComposeViewController = MFMailComposeViewController()
        mailComposeViewController.mailComposeDelegate = context.coordinator
        mailComposeViewController.setToRecipients([recipient])
        mailComposeViewController.setSubject(subject)
        mailComposeViewController.setMessageBody(body, isHTML: false)
        return mailComposeViewController
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {
        // Update any additional configurations here if needed
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(isShowing: $isShowingMailView)
    }

    // Coordinator to handle the dismissal of the MFMailComposeViewController
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        @Binding var isShowing: Bool

        init(isShowing: Binding<Bool>) {
            _isShowing = isShowing
        }

        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            // Handle the result or error if needed
            isShowing = false
        }
    }
}

