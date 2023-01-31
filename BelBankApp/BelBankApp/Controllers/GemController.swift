//
//  GemController.swift
//  BelBankApp
//
//  Created by Александра on 31.01.23.
//

import UIKit

class GemController: UIViewController {

    @IBOutlet weak var gemTableView: UITableView!

    var gems = [GemModel]()
      
      override func viewDidLoad() {
          super.viewDidLoad()
          gemTableView.dataSource = self
          registerCell()
          getData()
      }
      
      private func getData() {
          GemProvider().gemData { result in
              self.gems = result
              self.gemTableView.reloadData()
          } failure: {
          }
          
      }
      
      private func registerCell() {
          let nib = UINib(nibName: GemTableViewCell.id, bundle: nil)
          gemTableView.register(nib, forCellReuseIdentifier: GemTableViewCell.id)
      }
     
  }

  extension GemController: UITableViewDataSource {
      
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return gems.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: GemTableViewCell.id, for: indexPath)
          guard let gemCell = cell as? GemTableViewCell else {return cell}
          
          gemCell.set(gem: gems[indexPath.row])
          return gemCell
      }
      
      
  }


