//
//  Presenter.swift
//  Tabbar
//
//  Created by L on 2022/2/21.
//

protocol Presentation {
    
    
    
}

class Presenter: Presentation {
    
    weak var view: TabbarView?
    
    typealias useCases = ()
    
    var useCases: useCases
    
    init(useCases: useCases) {
        self.useCases = useCases
    }
}
