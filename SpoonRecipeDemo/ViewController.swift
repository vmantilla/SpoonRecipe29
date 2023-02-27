//
//  ViewController.swift
//  SpoonRecipeDemo
//
//  Created by Ravit on 27/02/23.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navigationController = UINavigationController()
        let window = UIApplication.shared.windows.first!
        window.rootViewController = navigationController
        
        // Creamos una instancia del coordinator y lo iniciamos
        self.coordinator = Coordinator(navigationController: navigationController)
        self.coordinator?.start()
    }
}
