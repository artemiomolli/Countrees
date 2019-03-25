//
//  PopupViewController.swift
//  AllCountries
//
//  Created by Артём Гуральник on 3/25/19.
//  Copyright © 2019 Guralnyk Artem. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController {

    @IBOutlet weak var bordersLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func cancelAction(_ sender: Any) {
        
        removeFromParent()
        view.removeFromSuperview()
    }
}
