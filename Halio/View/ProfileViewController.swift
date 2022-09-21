//
//  ProfileViewController.swift
//  Halio
//
//  Created by Кирилл on 20.09.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let stack: UIStackView = {
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .equalSpacing
        $0.spacing = 10
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = K.AppColors.primary
        
        buttonsInit()
        initStackConstraints()
        
    }
    
    
    func initStackConstraints() {
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: +40),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: +40),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
        ])
    }
    
    func buttonsInit() {
        let avatar = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        avatar.image = UIImage(named: K.Images.placeholder)
        avatar.layer.masksToBounds = false
        avatar.clipsToBounds = true
        avatar.layer.cornerRadius = avatar.frame.height/2
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.widthAnchor.constraint(equalToConstant: 150).isActive = true
        avatar.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        let username = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        username.text = "Walter White"
        username.font = .systemFont(ofSize: 21, weight: .bold)
        username.textColor = K.AppColors.white
        username.textAlignment = .center
        
        
        let email = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        email.text = "breakingbad@icloud.com"
        email.font = .systemFont(ofSize: 16, weight: .bold)
        email.textColor = UIColor.gray
        email.textAlignment = .center
        
        self.view.addSubview(stack)
        
        stack.addArrangedSubview(avatar)
        stack.addArrangedSubview(username)
        stack.addArrangedSubview(email)
    }
    
}
