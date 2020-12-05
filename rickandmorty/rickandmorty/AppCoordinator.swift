//
//  AppCoordinator.swift
//  rickandmorty
//
//  Created by Edno Fedulo on 05/12/20.
//  Copyright © 2020 Edno Fedulo. All rights reserved.
//

import Foundation
import UIKit

protocol CoordinatorProtocol {
    var window: UIWindow { get }
    var navigationController:UINavigationController? { get }
    func start()
}

class AppCoordinator:CoordinatorProtocol {
    
    var window: UIWindow
    var navigationController: UINavigationController?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        
    }
    
    
}
