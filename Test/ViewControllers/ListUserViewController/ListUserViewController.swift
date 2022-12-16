//
//  ListUserViewController.swift
//  Test
//
//  Created by cmc on 14/12/2022.
//

import UIKit

class ListUserViewController: UIViewController {
    var viewModel: ListUserViewModel
    
    init(viewModel: ListUserViewModel = ListUserViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: ListUserViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var listUserTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        commonSetup()
    }
    
    func commonSetup() {
        listUserTableView.delegate = self
        listUserTableView.dataSource = self
        viewModel.delegate = self
    }

}
extension ListUserViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: InfoUserTableViewCell.self)) as? InfoUserTableViewCell
        else { return UITableViewCell() }
        cell.bindData(infoUser: viewModel.users[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
extension ListUserViewController: ListUserDelegate {
    
    func updateList() {
        listUserTableView.reloadData()
    }
    
    func showAlert(with message: String) {
        let alert = UIAlertController(title: "Something error...",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
}
