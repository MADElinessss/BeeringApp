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
    let manager = APIManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("1")
        configureTableView()
        loadData()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let xib = UINib(nibName: BeerListTableViewCell.identifier, bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: BeerListTableViewCell.identifier)
        
        print("configureTableView - 완료")
    }
    
    func loadData() {
        print("loadData - 시작")
        manager.callRequest { [weak self] beers in
            DispatchQueue.main.async {
                print("API 응답 받음, 맥주 개수: \(beers.count)")
                self?.list = beers.sorted { $0.name < $1.name }
                self?.tableView.reloadData()
                print("loadData - 완료, 테이블 뷰 리로드")
            }
        }
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection: \(list.count)")
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
        print("cellForRowAt[\(indexPath.row)] - \(beer.name)")

        return cell
    }
    
}
