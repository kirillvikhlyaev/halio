//
//  SongCell.swift
//  Halio
//
//  Created by Tatyana Sidoryuk on 21.09.2022.
//

import UIKit

class SongCell: UITableViewCell {
    
    var songsArray = ["Первая", "Вторая", "Третья", "Четвертая", "Пятая", "Шестая", "Седьмая"]
    var namesArray = ["Автор 1", "Автор 2", "Автор 3", "Автор 4", "Автор 5", "Автор 6", "Автор 7"]
    

    public lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textColor = UIColor(red: 0.831, green: 0.831, blue: 0.831, alpha: 1)
        label.font = UIFont(name: "Abel-Regular", size: 25)
        return label
    } ()
    
    public lazy var secondLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "Daily mixes"
        label.textColor = UIColor(red: 0.831, green: 0.831, blue: 0.831, alpha: 1)
        label.font = UIFont(name: "Abel-Regular", size: 14)
        return label
    } ()
    
    private lazy var songsCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = K.AppColors.primary
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        return collectionView
    } ()
    
    override init (style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView () {
        self.backgroundColor = K.AppColors.primary
        self.addSubview(contentView)
        self.contentView.backgroundColor = K.AppColors.primary
        self.contentView.addSubview(self.headerLabel)
        self.contentView.addSubview(self.secondLabel)
        self.contentView.addSubview(self.songsCollection)
        
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.headerLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0),
            self.headerLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0),
            self.headerLabel.heightAnchor.constraint(equalToConstant: 40),
            
            self.secondLabel.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: 0),
            self.secondLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0),
            self.secondLabel.heightAnchor.constraint(equalToConstant: 30),
            
            self.songsCollection.topAnchor.constraint(equalTo: self.secondLabel.bottomAnchor, constant: 16),
            self.songsCollection.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0),
            self.songsCollection.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0),
            self.songsCollection.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16)
        ])
    }
}


extension SongCell: UICollectionViewDelegateFlowLayout {
    private var sideInset: CGFloat { return 15 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (collectionView.bounds.height)
        return CGSize(width: height/1.3, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        self.sideInset
    }
}

extension SongCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.songsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell

        self.backgroundColor = .black
        cell.setupCell(
            title: songsArray[indexPath.row],
            author: namesArray[indexPath.row],
            posterURL: "placeholder.jpeg"
        )

        return cell
    }
    
    //TODO: Необходимо сделать переход на страницу плеера
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Cell index: \(indexPath.row)")
    }
 
}

