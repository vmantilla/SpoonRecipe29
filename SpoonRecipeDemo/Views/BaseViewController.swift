//
//  BaseViewController.swift
//  SpoonRecipeDemo
//
//  Created by RAVIT SAS on 1/03/23.
//

import Foundation
import UIKit
import SwiftUI

class BaseViewController: UIViewController {
    
    func addView<Content>(rootView: Content) where Content: View {
        let childView = UIHostingController(rootView: rootView)
        addChild(childView)
        childView.view.frame = self.view.frame
        view.addSubview(childView.view)
        childView.didMove(toParent: self)
        self.navigationController?.navigationBar.isHidden = false
    }
    
}
