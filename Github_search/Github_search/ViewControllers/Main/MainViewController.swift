//
//  MainViewController.swift
//  Github_search
//
//  Created by Mac User on 14.02.2023.
//

import UIKit

class MainViewController: ViewController {
    
    var viewModel: MainViewModel?

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.prepareTableView()
        self.renderViewModel(MainViewModel())
    }
    
    private func prepareTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.registerCell(type: ListItemCell.self)
    }
    
    private func renderViewModel(_ model: MainViewModel) {
        self.viewModel = model
        self.navigationController?.title = model.title
        self.tableView.reloadData()
    }
    
    
    private func showDetails() {
        let vc: DetailsViewController = DetailsViewController.instantiate(storyboard: .details)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension MainViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.listItems.count ?? 0
    }
            
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = self.viewModel?.listItems[indexPath.row] ?? "up"
        
        let cell = tableView.dequeueCell(withType: ListItemCell.self, for: indexPath) as! ListItemCell
        cell.cellTitleLabel.text = item
        cell.cellSubtitleLabel.text = item
        
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.showDetails()
    }
}
