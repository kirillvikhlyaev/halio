//
//  CollectionViewCell.swift
//  Halio
//
//  Created by Tatyana Sidoryuk on 21.09.2022.
//

import UIKit
import Kingfisher

class CollectionViewCell: UICollectionViewCell {
    
    
    private lazy var posterView: UIImageView = {
        let poster = UIImageView()
        poster.clipsToBounds = true
        poster.layer.cornerRadius = 16
        poster.sizeToFit()
        poster.contentMode = .scaleAspectFill
        poster.translatesAutoresizingMaskIntoConstraints = false
        return poster
    }()
    
    private lazy var nameLabel: UILabel = {
        let name = UILabel()
        name.backgroundColor = K.AppColors.primary
        name.font = UIFont(name: "Abel-Regular", size: 15)
        name.text = "default"
        name.textColor = .white
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    private lazy var dateLabel: UILabel = {
        let date = UILabel()
        date.backgroundColor = K.AppColors.primary
        date.font = UIFont(name: "Abel-Regular", size: 12)
        date.text = "Default"
        date.textColor = .lightGray
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = K.AppColors.primary
        self.setupView()
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        self.contentView.addSubview(self.posterView)
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.dateLabel)
        self.backgroundColor = K.AppColors.primary
        
        NSLayoutConstraint.activate([
            self.posterView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.posterView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.posterView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.posterView.bottomAnchor.constraint(equalTo: self.nameLabel.topAnchor),
            self.nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.nameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.nameLabel.bottomAnchor.constraint(equalTo: self.dateLabel.topAnchor),
            self.nameLabel.heightAnchor.constraint(equalToConstant: 20),
            self.dateLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.dateLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.dateLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.dateLabel.heightAnchor.constraint(equalToConstant: 15),
        ])
    }
    
    func setupCell(title: String, author: String, posterURL: String) {
        self.nameLabel.text = title
        self.dateLabel.text = author
        let url = URL(string: posterURL ?? "https://viewsontop.com/wp-content/uploads/2020/01/placeholder.png")
        self.posterView.kf.setImage(with: url, placeholder: nil, options: nil, completionHandler: nil)
    }
}
