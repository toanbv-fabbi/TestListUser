//
//  ListUserViewController.swift
//  Test
//
//  Created by cmc on 14/12/2022.
//

import UIKit

class ListUserViewController: UIViewController {
    private var viewModel: ListUserViewModel
    
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(pullRefresh), for: .valueChanged)
        return refreshControl
    }()
    
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
    
    private func commonSetup() {
        listUserTableView.delegate = self
        listUserTableView.dataSource = self
        viewModel.delegate = self
        listUserTableView.refreshControl = refreshControl
        listUserTableView.register(UINib(nibName: String(describing: InfoUserTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: InfoUserTableViewCell.self))
    }
    
    @objc
    private func pullRefresh() {
        loadingView.startAnimating()
        viewModel.makeRequest()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        pullRefresh()
    }

}
extension ListUserViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.infoUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: InfoUserTableViewCell.self)) as? InfoUserTableViewCell
        else { return UITableViewCell() }
        cell.bindData(infoUser: viewModel.infoUsers[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailUserViewController(nibName: String(describing: DetailUserViewController.self), bundle: nil)
        detailViewController.infoUserDetail = viewModel.infoUsers[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}
extension ListUserViewController: ListUserDelegate {
    
    func updateList() {
        loadingView.stopAnimating()
        refreshControl.endRefreshing()
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
