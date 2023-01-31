//
//  MetalTableViewCell.swift
//  BelBankApp
//
//  Created by Александра on 31.01.23.
//

import UIKit

enum Metal: Int {
    case silver = 0
    case gold = 1
    case platinum = 2
    
    var name: String {
        switch self {
            case .silver:
                return "Silver"
            case .gold:
                return "Gold"
            case .platinum:
                return "Platinum"
        }
    }
}

class MetalTableViewCell: UITableViewCell {
    
    static let id = String(describing: MetalTableViewCell.self)

    @IBOutlet weak var metalLabel: UILabel!
    @IBOutlet weak var fillialLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func set(info: MetalModel, metal: Metal) {
        let tenGrams: Double = {
            switch metal {
                case .silver:
                    print("\(info.silver10) \(info.fillialName)")
                    return Double(info.silver10) ?? 0
                case .gold:
                    return Double(info.gold10) ?? 0
                case .platinum:
                    return Double(info.platinum10) ?? 0
            }
        }()
        
        let twentyGrams: Double = {
            switch metal {
                case .silver:
                    return Double(info.silver20) ?? 0
                case .gold:
                    return Double(info.gold20) ?? 0
                case .platinum:
                    return Double(info.platinum20) ?? 0
            }
        }()
        
        let fiftyGrams: Double = {
            switch metal {
                case .silver:
                    return Double(info.silver50) ?? 0
                case .gold:
                    return Double(info.gold50) ?? 0
                case .platinum:
                    return Double(info.platinum50) ?? 0
            }
        }()
        
        metalLabel.text = "\(metal.name) 10g: \(tenGrams) BYN\n\(metal.name) 20g: \(twentyGrams) BYN\n\(metal.name) 50g: \(fiftyGrams) BYN"
        fillialLabel.text = info.fillialName
        addressLabel.text = "\(info.cityType) \(info.city), \(info.streetType) \(info.street), \(info.homeNumber)"
    }
    
}
