//
//  ListUserViewModel.swift
//  Test
//
//  Created by cmc on 14/12/2022.
//

import UIKit

protocol ListUserDelegate: AnyObject {
    func updateList()
    func showAlert(with message: String)
}

class ListUserViewModel {
    weak var delegate: ListUserDelegate?
    var infoUsers = [InfoUser]()
    let useCase: ListUserUseCase
    
    init(useCase: ListUserUseCase = DefaultListUserUseCase()) {
        self.useCase = useCase
    }
    
    func makeRequest() {
        useCase.getListUser { [weak self] result in
            switch result {
            case .failure(let error):
                self?.delegate?.showAlert(with: error.localizedDescription)
            case .success(let newInfoUsers):
                self?.infoUsers = newInfoUsers
                self?.delegate?.updateList()
            }
        }
    }
}
