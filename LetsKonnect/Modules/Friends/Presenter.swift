//
//  Presenter.swift
//  Friends
//
//  Created by L on 2022/2/21.
//

import Foundation

protocol Presentation {
    
    typealias Input = ()
    
    typealias Output = ()
    
    typealias Producer = (Presentation.Input) -> Presentation
    
    var input: Input { get }
    
    var output: Output { get }

}

class Presenter: Presentation {
    
    var input: Input
    
    var output: Output
    
    private let router: Routing
    
    private let useCases: useCases
    
    private let dependencies: Dependencies
    
    typealias useCases = (
        input:(),
        output:()
    )
    
    typealias Dependencies = (router: Routing,
                              useCases: useCases)
    
    init(input: Input,
         dependencies: Dependencies) {
        
        self.input = input
        
        self.output = Presenter.output(input: self.input)
        
        self.router = dependencies.router
        
        self.useCases = dependencies.useCases
        
        self.dependencies = dependencies
        
        self.process()
        
    }
    
}

private extension Presenter {
    
    static func output(input: Input) -> Output {
        return ()
    }
    
    func process() {
        
    }
}
