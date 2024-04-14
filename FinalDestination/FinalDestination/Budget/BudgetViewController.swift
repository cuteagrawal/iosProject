//
//  BudgetVIewController.swift
//  FinalDestination
//
//  Created by Jay Patel on 2024-04-09.
//

import UIKit
import SwiftUI

/**
 * A ViewController which will load SwiftUI class when thid ViewController will be called
 */
class BudgetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Instance of BudgetSwiftUIView
        let contentView = BudgetSwiftUIView()
        
        // Adding BudgetSwiftUIView to hosting Controller
        let hostingController = UIHostingController(rootView: contentView)
        addChild(hostingController)
        
        // Set up auto layout constraints for the view
        view.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        hostingController.didMove(toParent: self)
    }
}
