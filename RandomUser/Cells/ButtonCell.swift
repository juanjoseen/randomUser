//
//  ButtonCell.swift
//  RandomUser
//
//  Created by Juan Jose Elias Navarro on 12/06/22.
//

import UIKit

protocol ButtonDelegate {
    func didTapOnButton()
}

class ButtonCell: UITableViewCell {
    
    static let identifier: String = "buttonCell"
    static let position: Int = 2
    
    var delegate: ButtonDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .bgColor
        
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(actionButton), for: .touchUpInside)
        
        let imgBg: UIImageView = UIImageView(image: UIImage(named: "button_bg"))
        imgBg.translatesAutoresizingMaskIntoConstraints = false
        imgBg.contentMode = .scaleAspectFill
        
        let lblText: UILabel = UILabel()
        lblText.translatesAutoresizingMaskIntoConstraints = false
        lblText.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        lblText.textColor = .textColor
        lblText.text = "Generate new user"
        
        contentView.addSubview(button)
        button.addSubview(imgBg)
        button.addSubview(lblText)
        
        NSLayoutConstraint.activate([
            
            button.topAnchor.constraint(equalTo: contentView.topAnchor),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            imgBg.topAnchor.constraint(equalTo: button.topAnchor, constant: 16),
            imgBg.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: -16),
            imgBg.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 16),
            imgBg.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -16),
            imgBg.heightAnchor.constraint(equalToConstant: 50),
            
            lblText.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            lblText.centerYAnchor.constraint(equalTo: button.centerYAnchor)
        ])
    }
    
    @objc func actionButton() {
        delegate?.didTapOnButton()
    }
}
