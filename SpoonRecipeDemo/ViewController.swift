//
//  ViewController.swift
//  SpoonRecipeDemo
//
//  Created by Ravit on 27/02/23.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    var coordinator: Coordinator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var coordinator = Coordinator(navigationController: self)
        // Wait for 3 seconds and replace the view
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            // Create the SwiftUI view
            let swiftUIView = MainView(coordinator: coordinator)

            // Wrap the SwiftUI view in a UIHostingController
            let hostingController = UIHostingController(rootView: swiftUIView)

            // Add the hosting controller as a child view controller of this view controller
            self.addChild(hostingController)

            // Add the hosting controller's view to this view controller's view hierarchy
            self.view.addSubview(hostingController.view)

            // Set the hosting controller's frame to the bounds of this view controller's view
            hostingController.view.frame = self.view.bounds

            // Tell the hosting controller that it has been moved to the current view controller
            hostingController.didMove(toParent: self)
        }
    }
}
