//
//  MetalController.swift
//  BelBankApp
//
//  Created by Александра on 31.01.23.
//

import UIKit

class MetalController: UIViewController {

    @IBOutlet weak var metalSegmentControl: UISegmentedControl!
    @IBOutlet weak var metalTableView: UITableView!
    
    private var info = [MetalModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        metalTableView.dataSource = self
        metalTableView.delegate = self
        registerCell()
        GemProvider().getMetals { info in
            self.info = info
            self.metalTableView.reloadData()
        } failure: { description in
            print(description)
        }

    }

    private func registerCell() {
        let nib = UINib(nibName: MetalTableViewCell.id, bundle: nil)
        metalTableView.register(nib, forCellReuseIdentifier: MetalTableViewCell.id)
    }
    
    @IBAction func metalDidChange(_ sender: Any) {
        metalTableView.reloadData()
    }
    
}

extension MetalController: UITableViewDelegate {
    
}

extension MetalController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return info.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = metalTableView.dequeueReusableCell(withIdentifier: MetalTableViewCell.id, for: indexPath)
        guard let infoCell = cell as? MetalTableViewCell else { return cell }
        
        infoCell.set(info: info[indexPath.row], metal: Metal(rawValue: metalSegmentControl.selectedSegmentIndex) ?? .silver)
        return infoCell
    }
    
}
