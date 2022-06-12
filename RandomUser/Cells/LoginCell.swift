//
//  LoginCell.swift
//  RandomUser
//
//  Created by Juan Jose Elias Navarro on 12/06/22.
//

import UIKit

class LoginCell: UITableViewCell {
    
    static let identifier: String = "loginCell"
    static let position: Int = 1
    
    weak var lblUuid: UILabel?
    weak var lblUsername: UILabel?
    weak var lblpassword: UILabel?
    weak var lblMd5: UILabel?
    weak var lblSha1: UILabel?
    weak var lblSha256: UILabel?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .bgColor
        let bgImage: UIImageView = UIImageView(image: UIImage(named: "section_bg"))
        bgImage.translatesAutoresizingMaskIntoConstraints = false
        
        let lblTitle: UILabel = UILabel()
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        lblTitle.text = "Login Info"
        lblTitle.textColor = .textColor
        
        let lblUuid: UILabel = UILabel()
        lblUuid.translatesAutoresizingMaskIntoConstraints = false
        lblUuid.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        lblUuid.textColor = .textColor
        lblUuid.adjustsFontSizeToFitWidth = true
        self.lblUuid = lblUuid
        
        let lblUsername: UILabel = UILabel()
        lblUsername.translatesAutoresizingMaskIntoConstraints = false
        lblUsername.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        lblUsername.textColor = .textColor
        lblUsername.adjustsFontSizeToFitWidth = true
        self.lblUsername = lblUsername
        
        let lblpassword: UILabel = UILabel()
        lblpassword.translatesAutoresizingMaskIntoConstraints = false
        lblpassword.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        lblpassword.textColor = .textColor
        lblpassword.adjustsFontSizeToFitWidth = true
        self.lblpassword = lblpassword
        
        let lblMd5: UILabel = UILabel()
        lblMd5.translatesAutoresizingMaskIntoConstraints = false
        lblMd5.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        lblMd5.textColor = .textColor
        lblMd5.adjustsFontSizeToFitWidth = true
        self.lblMd5 = lblMd5
        
        let lblSha1: UILabel = UILabel()
        lblSha1.translatesAutoresizingMaskIntoConstraints = false
        lblSha1.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        lblSha1.textColor = .textColor
        lblSha1.adjustsFontSizeToFitWidth = true
        self.lblSha1 = lblSha1
        
        let lblSha256: UILabel = UILabel()
        lblSha256.translatesAutoresizingMaskIntoConstraints = false
        lblSha256.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        lblSha256.textColor = .textColor
//        lblSha256.adjustsFontSizeToFitWidth = true
        lblSha256.numberOfLines = 4
        self.lblSha256 = lblSha256
        
        contentView.addSubview(bgImage)
        bgImage.addSubview(lblTitle)
        bgImage.addSubview(lblUuid)
        bgImage.addSubview(lblUsername)
        bgImage.addSubview(lblpassword)
        bgImage.addSubview(lblMd5)
        bgImage.addSubview(lblSha1)
        bgImage.addSubview(lblSha256)
        
        NSLayoutConstraint.activate([
            bgImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            bgImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            bgImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            bgImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            bgImage.heightAnchor.constraint(equalTo: bgImage.widthAnchor),
            
            lblTitle.topAnchor.constraint(equalTo: bgImage.topAnchor, constant: 16),
            lblTitle.centerXAnchor.constraint(equalTo: bgImage.centerXAnchor),
            lblTitle.heightAnchor.constraint(equalToConstant: 24),
            
            lblUuid.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 16),
            lblUuid.leadingAnchor.constraint(equalTo: bgImage.leadingAnchor, constant: 8),
            lblUuid.trailingAnchor.constraint(equalTo: bgImage.trailingAnchor, constant: -8),
            
            lblUsername.topAnchor.constraint(equalTo: lblUuid.bottomAnchor, constant: 8),
            lblUsername.leadingAnchor.constraint(equalTo: lblUuid.leadingAnchor),
            lblUsername.trailingAnchor.constraint(equalTo: lblUuid.trailingAnchor),
            
            lblpassword.topAnchor.constraint(equalTo: lblUsername.bottomAnchor, constant: 8),
            lblpassword.leadingAnchor.constraint(equalTo: lblUsername.leadingAnchor),
            lblpassword.trailingAnchor.constraint(equalTo: lblUsername.trailingAnchor),
            
            lblMd5.topAnchor.constraint(equalTo: lblpassword.bottomAnchor, constant: 8),
            lblMd5.leadingAnchor.constraint(equalTo: lblpassword.leadingAnchor),
            lblMd5.trailingAnchor.constraint(equalTo: lblpassword.trailingAnchor),
            
            lblSha1.topAnchor.constraint(equalTo: lblMd5.bottomAnchor, constant: 8),
            lblSha1.leadingAnchor.constraint(equalTo: lblMd5.leadingAnchor),
            lblSha1.trailingAnchor.constraint(equalTo: lblMd5.trailingAnchor),
            
            lblSha256.topAnchor.constraint(equalTo: lblSha1.bottomAnchor, constant: 8),
            lblSha256.leadingAnchor.constraint(equalTo: lblSha1.leadingAnchor),
            lblSha256.trailingAnchor.constraint(equalTo: lblSha1.trailingAnchor),
        ])
    }
    
    func config(with user: User?) {
        if let user = user {
            let strUuid: String = String(format: "UUID: %@", user.login.uuid)
            let attrStr: NSMutableAttributedString = NSMutableAttributedString(string: strUuid)
            attrStr.addAttributes([.font: UIFont.systemFont(ofSize: 15, weight: .light)], range: NSRange(location: 6, length: user.login.uuid.count))
            lblUuid?.attributedText = attrStr
            
            let strUser: String = String(format: "Username: %@", user.login.username)
            let attrUser: NSMutableAttributedString = NSMutableAttributedString(string: strUser)
            attrUser.addAttributes([.font: UIFont.systemFont(ofSize: 15, weight: .light)], range: NSRange(location: 10, length: user.login.username.count))
            lblUsername?.attributedText = attrUser
            
            let strPass: String = String(format: "Password: %@", user.login.password)
            let attrPass: NSMutableAttributedString = NSMutableAttributedString(string: strPass)
            attrPass.addAttributes([.font: UIFont.systemFont(ofSize: 15, weight: .light)], range: NSRange(location: 10, length: user.login.password.count))
            lblpassword?.attributedText = attrPass
            
            let strMd5: String = String(format: "MD5: %@", user.login.md5)
            let attrMd5: NSMutableAttributedString = NSMutableAttributedString(string: strMd5)
            attrMd5.addAttributes([.font: UIFont.systemFont(ofSize: 15, weight: .light)], range: NSRange(location: 5, length: user.login.md5.count))
            lblMd5?.attributedText = attrMd5
            
            let strSha1: String = String(format: "SHA1: %@", user.login.sha1)
            let attrSha1: NSMutableAttributedString = NSMutableAttributedString(string: strSha1)
            attrSha1.addAttributes([.font: UIFont.systemFont(ofSize: 15, weight: .light)], range: NSRange(location: 6, length: user.login.sha1.count))
            lblSha1?.attributedText = attrSha1
            
            let strSha256: String = String(format: "SHA256: %@", user.login.sha256)
            let attrSha256: NSMutableAttributedString = NSMutableAttributedString(string: strSha256)
            attrSha256.addAttributes([.font: UIFont.systemFont(ofSize: 15, weight: .light)], range: NSRange(location: 8, length: user.login.sha256.count))
            lblSha256?.attributedText = attrSha256
        }
    }
}
