//
//  MapCollectionViewCell.swift
//  BelBankApp
//
//  Created by Александра on 30.01.23.
//

import UIKit

class MapCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    private func setUpUI() {
        container.backgroundColor = .systemGray
        titleLabel.textColor = .systemBlue
        container.layer.cornerRadius = 12
        container.layer.borderWidth = self.isSelected ? 2 : 0
        
    }
    
    func setUpCell(title: String) {
        titleLabel.text = title
    }

}
