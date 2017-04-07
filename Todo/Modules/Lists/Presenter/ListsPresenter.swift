//
//  ListsPresenter.swift
//  Todo
//
//  Created by Axel Le Bot on 06/04/2017.
//  Copyright © 2017 Axel Le Bot. All rights reserved.
//

import Foundation

class ListsPresenter: ListsPresentation {
    
    weak var view: ListsView?
    var interactor: ListsUseCase!
    var router: ListsWireframe!
    
    var lists: [List] = [] {
        didSet {
            if lists.count > 0 {
                view?.showListsData(lists)
            } else {
                view?.showNoContentScreen()
            }
        }
    }
    
    func viewDidLoad() {
        interactor.fetchLists()
        view?.showActivityIndicator()
    }
    
    func didSelectList(_ list: List) {
        router.presentItems(forList: list)
    }
    
    func didClickAddButton(){
        router.presentAddList()
    }
}

extension ListsPresenter: ListsInteractorOutput {
    
    func listsFetched(_ lists: [List]) {
        self.lists = lists
        view?.hideActivityIndicator()
    }
    
    internal func listsFetchFailed() {
        view?.showNoContentScreen()
        view?.hideActivityIndicator()
    }
}
