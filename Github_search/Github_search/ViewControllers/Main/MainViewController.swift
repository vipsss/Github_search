//
//  MainViewController.swift
//  Github_search
//
//  Created by Mac User on 14.02.2023.
//

import UIKit

class MainViewController: ViewController {
    
    var viewModel: MainViewModel?
    private let networkManager = NetworkManager()
    private var keyPressTimer: Timer = Timer()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var loadingView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadingView.isHidden = true
        self.prepareTableView()
        self.renderViewModel(MainViewModel())
    }
    
    private func prepareTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.registerCell(type: ListItemCell.self)
    }
    
    private func prepareSearchBar() {
        self.searchBar.delegate = self
        
        self.tableView.registerCell(type: ListItemCell.self)
    }
    
    private func renderViewModel(_ model: MainViewModel) {
        self.viewModel = model
        self.title = model.title
        self.tableView.reloadData()
    }
    
    
    private func showDetails(repository: Repository) {
        let vc: DetailsViewController = DetailsViewController.instantiate(storyboard: .details)
        vc.model = repository
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func searchRepository(text: String) {
        self.loadingView.isHidden = false
        self.networkManager.searchRepository(query: text) { [weak self] items, error in
            DispatchQueue.main.async {
                self?.loadingView.isHidden = true
                
                guard error == nil else {
                    self?.showError(message: error!)
                    return
                }
                
                if let i = items {
                    self?.viewModel?.updateListItems(i)
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    private func showError(message :String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in

        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func searchTextTimer() {
        if let text = self.searchBar.text {
            self.searchRepository(text: text)
        }
    }
}


extension MainViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.listItems.count ?? 0
    }
            
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let item: Repository? = self.viewModel?.listItems[indexPath.row]
        
            let cell = tableView.dequeueCell(withType: ListItemCell.self, for: indexPath) as! ListItemCell
        cell.cellTitleLabel.text = item?.name ?? ""
        cell.cellSubtitleLabel.text = item?.description ?? ""
        if let img = item?.owner.avatar_url {
            let url = URL(string: img)!
            cell.cellImage.load(url: url)
        } else {
            cell.cellImage = nil
        }
        
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item: Repository? = self.viewModel?.listItems[indexPath.row]
        if let i = item {
            self.showDetails(repository: i)
        }
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        if (self.keyPressTimer.isValid) {
            self.keyPressTimer.invalidate()
        }
        self.keyPressTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(searchTextTimer), userInfo: nil, repeats: false)
    }
}
