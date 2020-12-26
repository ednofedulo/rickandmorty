//
//  TransitionController.swift
//  rickandmorty
//
//  Created by Edno Fedulo on 13/12/20.
//  Copyright © 2020 Edno Fedulo. All rights reserved.
//

import UIKit


// NavigationController Delegate for Transition Coordinator
class TransitionCoordinator: NSObject, UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            return PushAnimator()
        case .pop:
            return PopAnimator()
        default:
            return nil
        }
    }
}
