//
//  ViewController.swift
//  RandomUser
//
//  Created by Juan Jose Elias Navarro on 09/06/22.
//

import UIKit

class ViewController: UIViewController {
    
    weak var profileView: ProfileView?
    
    override func loadView() {
        let profileView: ProfileView = ProfileView(controller: self)
        self.profileView = profileView
        view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadNewUser()
    }

    func loadNewUser() {
        profileView?.tableView?.isHidden = true
        profileView?.animateLoading()
        Api.shared.getRandomUser { error, user in
            if let error = error {
                // TODO: show Error message
                print("error: \(error.localizedDescription)")
            } else {
                if let user = user {
                    self.profileView?.fillData(with: user)
                } else {
                    // TODO: show Error message
                }
            }
        }
    }
}

