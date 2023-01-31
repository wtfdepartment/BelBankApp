//
//  GemTableViewCell.swift
//  BelBankApp
//
//  Created by Александра on 31.01.23.
//

import UIKit

class GemTableViewCell: UITableViewCell {
    
    static let id = String(describing: GemTableViewCell.self)
    
    @IBOutlet weak var certificateLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func set(gem: GemModel) {
        self.certificateLabel.text = "\(gem.gemNumberOfAttestat)"
        self.costLabel.text = "\(gem.gemCost)"
        self.addressLabel.text = "\(gem.gemCityName)"
    }
    
}


