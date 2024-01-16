//
//  RecommendViewController.swift
//  BeeringApp
//
//  Created by Madeline on 2024/01/16.
//

// RecommendViewController.swift

import UIKit
import Kingfisher

class RecommendViewController: UIViewController {
    
    @IBOutlet weak var beerImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    let apiManager = APIManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func recommendButtonTapped(_ sender: UIButton) {
        fetchRandomBeer()
    }
    
    func fetchRandomBeer() {
        apiManager.fetchRandomBeer { [weak self] beer in
            DispatchQueue.main.async {
                if let beer = beer {
                    self?.updateUI(with: beer)
                } else {
                    // 에러 처리 또는 사용자에게 알림
                }
            }
        }
    }
    
    func updateUI(with beer: Beer) {
        nameLabel.text = beer.name
        descriptionLabel.text = beer.description
        if let url = URL(string: beer.image_url ?? "") {
            beerImage.kf.setImage(with: url)
        }
    }
}
