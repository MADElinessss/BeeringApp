//
//  ViewController.swift
//  BeeringApp
//
//  Created by Madeline on 2024/01/16.
//

import Kingfisher
import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var list: [Beer] = []
    var filterList : [Beer] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    let manager = APIManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        loadData()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let xib = UINib(nibName: BeerListTableViewCell.identifier, bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: BeerListTableViewCell.identifier)
    }
    
    func loadData() {
        manager.callRequest { [weak self] beers in
            self?.list = beers.sorted { $0.name < $1.name }
            self?.tableView.reloadData()
        }
        filterList = list
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BeerListTableViewCell.identifier) as! BeerListTableViewCell
        
        let beer = list[indexPath.row]
        cell.nameLabel.text = beer.name
        cell.descriptionLabel.text = beer.description
        if let url = URL(string: beer.image_url ?? "") {
            cell.beerImageView.kf.setImage(with: url)
        }
        
        return cell
    }
}

extension ListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var filterData: [Beer] = []
        for item in list {
            if item.name.contains(searchBar.text!) || item.description.contains(searchBar.text!) {
                filterData.append(item)
            }
        }
        filterList = filterData
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var filterData: [Beer] = []
        for item in list {
            if item.name.contains(searchBar.text!) || item.description.contains(searchBar.text!) {
                filterData.append(item)
            }
        }
        filterList = filterData
        view.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filterList = list
        searchBar.text = ""
        view.endEditing(true)
    }
}
