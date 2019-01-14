//
//  BaseViewController.swift
//  bbcNews
//
//  Created by JJ Montes on 13/01/2019.
//  Copyright © 2019 jjmontes. All rights reserved.
//

import Foundation
import UIKit

//Protocol to be defined by the screens that have to refresh their information when they return from the background.
protocol BaseViewControllerRefresh {
    func backToBackGroundRefresh()
}

//Base class, it is declared as a good practice to implement new functions in a global way in the application.
class BaseViewController: UIViewController {
    override func viewDidLoad() { super.viewDidLoad() }
    override func viewDidAppear(_ animated: Bool) { super.viewDidAppear(animated) }
    override func viewWillAppear(_ animated: Bool) { super.viewWillAppear(animated) }
    override func viewDidDisappear(_ animated: Bool) { super.viewDidDisappear(animated) }
    override func viewWillDisappear(_ animated: Bool) { super.viewWillDisappear(animated) }
    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning() }
}
