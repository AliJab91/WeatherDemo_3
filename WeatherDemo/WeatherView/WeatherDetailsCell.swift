//
//  WeatherDetailsCell.swift
//  WeatherDemo
//
//  Created by Ali Jaber on 4/19/18.
//  Copyright © 2018 Ali Jaber. All rights reserved.
//

import UIKit

class WeatherDetailsCell: UITableViewCell {
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var weatherDate: UILabel!
    @IBOutlet weak var weatherDegree: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
}
