//
//  InfoUserTableViewCell.swift
//  Test
//
//  Created by cmc on 14/12/2022.
//

import UIKit

class InfoUserTableViewCell: UITableViewCell {

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        emailLabel.text = nil
        userNameLabel.text = nil
        nameLabel.text = nil
    }
    
    func bindData(infoUser: InfoUser) {
        if let name = infoUser.name {
            nameLabel.text = name
        }
        if let username = infoUser.username {
            userNameLabel.text = username
        }
        if let email = infoUser.email {
            emailLabel.text = email
        }
    }
    
}
