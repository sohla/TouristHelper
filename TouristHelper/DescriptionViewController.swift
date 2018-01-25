//
//  DescriptionViewController.swift
//  TouristHelper
//
//  Created by Stephen OHara on 23/1/18.
//  Copyright © 2018 Stephen OHara. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleLabel.text = "searching..."

        NotificationCenter.default.reactive.notification(name: .locationSelected)
            .observeNext { notification in
                if let locationModelView = notification.object as? LocationModelView{
                    self.titleLabel.text = locationModelView.title
                }
            }.dispose(in: bag)
    }
}
