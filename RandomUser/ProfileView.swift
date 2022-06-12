//
//  ProfileView.swift
//  RandomUser
//
//  Created by Juan Jose Elias Navarro on 09/06/22.
//

import UIKit

class ProfileView: UIView {

    unowned var controller: ViewController!
    var user: User?
    
    weak var lblLoading: UILabel?
    weak var loading: UIImageView?
    var timer: Timer?
    weak var tableView: UITableView?
    
    init(controller: ViewController) {
        self.controller = controller
        super.init(frame: .zero)
        
        backgroundColor = .bgColor
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let loading: UIImageView = UIImageView(image: UIImage(named: "loading_bg"))
        loading.contentMode = .scaleAspectFill
        loading.translatesAutoresizingMaskIntoConstraints = false
        self.loading = loading
        
        let lblLoading: UILabel = UILabel()
        lblLoading.translatesAutoresizingMaskIntoConstraints = false
        lblLoading.textAlignment = .center
        lblLoading.textColor = .textColor
        self.lblLoading = lblLoading
        
        loading.addSubview(lblLoading)
        
        let tableView: UITableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .bgColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(HeaderCell.self, forCellReuseIdentifier: HeaderCell.identifier)
        tableView.register(LoginCell.self, forCellReuseIdentifier: LoginCell.identifier)
        tableView.register(ButtonCell.self, forCellReuseIdentifier: ButtonCell.identifier)
        self.tableView = tableView
        
        addSubview(tableView)
        addSubview(loading)
        
        NSLayoutConstraint.activate([
            loading.centerYAnchor.constraint(equalTo: centerYAnchor),
            loading.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            loading.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
            loading.heightAnchor.constraint(equalTo: loading.widthAnchor, multiplier: 0.15),
            
            lblLoading.topAnchor.constraint(equalTo: loading.topAnchor, constant: 5),
            lblLoading.bottomAnchor.constraint(equalTo: loading.bottomAnchor, constant: -5),
            lblLoading.leadingAnchor.constraint(equalTo: loading.leadingAnchor, constant: 16),
            lblLoading.trailingAnchor.constraint(equalTo: loading.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    func animateLoading() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, delay: 0.0) {
                self.loading?.isHidden = false
            }
            self.lblLoading?.setTyping(text: "Loading...", characterDelay: 7)
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.write), userInfo: nil, repeats: true)
        }
    }
    
    func stopAnimatingLoading(completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .beginFromCurrentState) {
                self.loading?.isHidden = true
            } completion: { didFinish in
                completion()
            }
        }
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func write() {
        lblLoading?.setTyping(text: "Loading...", characterDelay: 7)
    }
    
    func fillData(with user: User) {
        stopAnimatingLoading() {
            DispatchQueue.main.async {
                self.tableView?.isHidden = false
                self.tableView?.reloadData()
            }
        }
        self.user = user
    }
    
}

extension ProfileView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if user != nil {
            return 3
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == HeaderCell.position {
            let cell: HeaderCell = tableView.dequeueReusableCell(withIdentifier: HeaderCell.identifier, for: indexPath) as! HeaderCell
            cell.config(with: user)
            return cell
        } else if indexPath.row == LoginCell.position {
            let cell: LoginCell = tableView.dequeueReusableCell(withIdentifier: LoginCell.identifier, for: indexPath) as! LoginCell
            cell.config(with: user)
            return cell
        } else if indexPath.row == ButtonCell.position {
            let cell: ButtonCell = tableView.dequeueReusableCell(withIdentifier: ButtonCell.identifier, for: indexPath) as! ButtonCell
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ProfileView: ButtonDelegate {
    func didTapOnButton() {
        controller.loadNewUser()
    }
}
