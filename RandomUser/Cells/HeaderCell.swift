//
//  HeaderCell.swift
//  RandomUser
//
//  Created by Juan Jose Elias Navarro on 11/06/22.
//

import UIKit

class HeaderCell: UITableViewCell {
    
    static let identifier: String = "headerCell"
    static let position: Int = 0
    
    private weak var imgProfile: UIImageView?
    private weak var lblName: UILabel?
    private weak var lblMail: UILabel?
    private weak var lblDoB: UILabel?
    private weak var txtPhones: UITextView?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .bgColor
        
        let bgImage: UIImageView = UIImageView(image: UIImage(named: "profile_bg"))
        bgImage.translatesAutoresizingMaskIntoConstraints = false
        bgImage.contentMode = .scaleAspectFit
        
        let imgProfile: UIImageView = UIImageView()
        imgProfile.translatesAutoresizingMaskIntoConstraints = false
        imgProfile.contentMode = .scaleAspectFit
        self.imgProfile = imgProfile
        
        bgImage.addSubview(imgProfile)
        
        let lblName: UILabel = UILabel()
        lblName.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        lblName.translatesAutoresizingMaskIntoConstraints = false
        lblName.textColor = .textColor
        lblName.numberOfLines = 1
        lblName.adjustsFontSizeToFitWidth = true
        self.lblName = lblName
        
        let lblMail: UILabel = UILabel()
        lblMail.font = UIFont.systemFont(ofSize: 12, weight: .light)
        lblMail.translatesAutoresizingMaskIntoConstraints = false
        lblMail.textColor = .textColor
        lblMail.numberOfLines = 1
        lblMail.adjustsFontSizeToFitWidth = true
        self.lblMail = lblMail
        
        let lblDoB: UILabel = UILabel()
        lblDoB.font = UIFont.systemFont(ofSize: 12)
        lblDoB.translatesAutoresizingMaskIntoConstraints = false
        lblDoB.textColor = .textColor
        lblDoB.numberOfLines = 0
        self.lblDoB = lblDoB
        
        let txtPhones: UITextView = UITextView(frame: .zero)
        txtPhones.translatesAutoresizingMaskIntoConstraints = false
        txtPhones.isEditable = false
        txtPhones.dataDetectorTypes = .link
        txtPhones.font = UIFont.systemFont(ofSize: 12, weight: .light)
        txtPhones.textColor = .textColor
        txtPhones.backgroundColor = .bgColor
        txtPhones.isSelectable = true
        txtPhones.delegate = self
        self.txtPhones = txtPhones
        
        contentView.addSubview(bgImage)
        contentView.addSubview(lblName)
        contentView.addSubview(lblMail)
        contentView.addSubview(lblDoB)
        contentView.addSubview(txtPhones)
        
        NSLayoutConstraint.activate([
            bgImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1.0/3.0),
            bgImage.heightAnchor.constraint(equalTo: bgImage.widthAnchor),
            bgImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            bgImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            bgImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            imgProfile.topAnchor.constraint(equalTo: bgImage.topAnchor, constant: 5),
            imgProfile.bottomAnchor.constraint(equalTo: bgImage.bottomAnchor, constant: -5),
            imgProfile.leadingAnchor.constraint(equalTo: bgImage.leadingAnchor, constant: 5),
            imgProfile.trailingAnchor.constraint(equalTo: bgImage.trailingAnchor, constant: -5),
            
            lblName.topAnchor.constraint(equalTo: bgImage.topAnchor),
            lblName.leadingAnchor.constraint(equalTo: bgImage.trailingAnchor, constant: 16),
            lblName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            lblMail.topAnchor.constraint(equalTo: lblName.bottomAnchor, constant: 4),
            lblMail.leadingAnchor.constraint(equalTo: lblName.leadingAnchor),
            lblMail.trailingAnchor.constraint(equalTo: lblName.trailingAnchor),
            
            lblDoB.topAnchor.constraint(equalTo: lblMail.bottomAnchor, constant: 12),
            lblDoB.leadingAnchor.constraint(equalTo: lblMail.leadingAnchor),
            lblDoB.trailingAnchor.constraint(equalTo: lblMail.trailingAnchor),
            
            txtPhones.topAnchor.constraint(equalTo: lblDoB.bottomAnchor, constant: 0),
            txtPhones.leadingAnchor.constraint(equalTo: lblDoB.leadingAnchor, constant: -6),
            txtPhones.trailingAnchor.constraint(equalTo: lblDoB.trailingAnchor),
            txtPhones.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    func config(with user: User?) {
        if let user = user {
            lblName?.text = String(format: "%@ %@ %@", user.name.title, user.name.first, user.name.last).trimmingCharacters(in: .whitespacesAndNewlines)
            lblMail?.text = user.email
            lblDoB?.text = String(format: "Age: %d", user.dob.age)
            imgProfile?.loadFrom(URLAddress: user.picture.medium, completion: {
                self.imgProfile?.layer.cornerRadius = (self.imgProfile?.frame.width ?? 250) / 2.0
                self.imgProfile?.clipsToBounds = true
            })
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4
            
            txtPhones?.textColor = .textColor
            let strPhones: String = String(format: "Phone: %@\nCell: %@", user.phone, user.cell)
            let attrStr: NSMutableAttributedString = NSMutableAttributedString(string: strPhones)
            attrStr.addAttributes([
                .paragraphStyle: paragraphStyle,
                .foregroundColor: UIColor.textColor
            ], range: NSRange(location: 0, length: strPhones.count))
            attrStr.addAttributes([
                .font: UIFont.systemFont(ofSize: 12, weight: .regular),
                .foregroundColor: UIColor.systemBlue,
                .link: URL(string: String(format: "tel://%@", user.phone.replacingOccurrences(of: " ", with: "-")))!
            ], range: NSRange(location: 7, length: user.phone.count))
            attrStr.addAttributes([
                .font: UIFont.systemFont(ofSize: 12, weight: .regular),
                .foregroundColor: UIColor.systemBlue,
                .link: URL(string: String(format: "tel://%@", user.cell.replacingOccurrences(of: " ", with: "-")))!
            ], range: NSRange(location: strPhones.count-user.cell.count, length: user.cell.count))
            
            
            txtPhones?.attributedText = attrStr
        }
    }
}

extension HeaderCell: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return true
    }
}
