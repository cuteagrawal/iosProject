//
//  BudgetVIewController.swift
//  FinalDestination
//
//  Created by Jay Patel on 2024-04-09.
//

import UIKit
import SwiftUI

class BudgetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let contentView = BudgetSwiftUIView()
        let hostingController = UIHostingController(rootView: contentView)
        
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        hostingController.didMove(toParent: self)
        
    }
}
