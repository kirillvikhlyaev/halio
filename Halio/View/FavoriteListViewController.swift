//
//  FavoriteListViewController.swift
//  Halio
//
//  Created by Кирилл on 20.09.2022.
//

import UIKit

class FavoriteListViewController: UIViewController {
    
    let pageLabel: UILabel = {
       let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        label.text = "Избранные"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = K.AppColors.primary
        self.view.addSubview(pageLabel)
        pageLabel.center = self.view.center
    }
}
