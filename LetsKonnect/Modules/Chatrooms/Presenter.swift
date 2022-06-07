//
//  Presenter.swift
//  Chatrooms
//
//  Created by L on 2022/2/21.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources
import Models

protocol Presentation {
    
    typealias Input = ()
    
    typealias Output = (
        section: Driver<[ChatroomSection]>, ()
    )
    
    typealias Producer = (Presentation.Input) -> Presentation
    
    var input: Input { get }
    
    var output: Output { get }

}

class Presenter: Presentation {
    
    var input: Input
    
    var output: Output
    
    private let router: Routing
    
    private let useCases: UseCases
    
    private let dependencies: Dependencies
    
    private let bag = DisposeBag()
    
    typealias UseCases = (
        input:(
            fetchChatrooms: () -> Completable, ()
        ),
        output:(
            chatrooms: Observable<Set<Chatroom>>, ()
        )
    )
    
    typealias Dependencies = (router: Routing,
                              useCases: UseCases)
    
    init(input: Input,
         dependencies: Dependencies) {
        
        self.input = input
        
        self.router = dependencies.router
        
        self.useCases = dependencies.useCases
        
        self.dependencies = dependencies
        
        self.output = Presenter.output(input: self.input,
                                       useCases: self.useCases)
        
        self.process()
        
    }
    
}

private extension Presenter {
    
    static func output(input: Input,
                       useCases: UseCases) -> Output {
        
       let chatrooms = useCases.output
        .chatrooms
        .map(ChatroomViewModel.build(models:))
        .map(ChatroomSection.sections(usingItems:))
        .asDriver(onErrorJustReturn: [])
        
        return (
            section: chatrooms, ()
        )
    }
    
    func process() {
        
        self.useCases.input
            .fetchChatrooms()
            .debug("fetchChatrooms", trimOutput: false)
            .subscribe()
            .disposed(by: bag)
        
    }
}

struct ChatroomViewModel {
    
    let id: String
    let title: String
    let timestamp: BehaviorRelay<String> = BehaviorRelay(value: "")
    let statusMessage: BehaviorRelay<String> = BehaviorRelay(value: "")
    let unreadCount: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    
}

extension ChatroomViewModel {
    
    init(usingModel model: Chatroom) {
        self.id = model.id
        self.title = model.name
        self.statusMessage.accept(model.subject)
        self.timestamp.accept(model.createdAt.converToDate()?.timeAgoSinceNow() ?? "")
    }
    
    static func build(models: Set<Chatroom>) -> [ChatroomViewModel] {
        return models.compactMap({ ChatroomViewModel(usingModel: $0) })
    }
    
}

extension ChatroomViewModel: IdentifiableType, Equatable {
    
    typealias Identity = String
    
    var identity: String {
        return id
    }
    
    static func == (lhs: ChatroomViewModel, rhs: ChatroomViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
}

struct ChatroomSection {
    
    var header: Int
    var items: [Item]
    
}

extension ChatroomSection: AnimatableSectionModelType {
    
    typealias Item = ChatroomViewModel
    typealias Identity = Int
    
    var identity: Int {
        return header
    }
    
    init(original: ChatroomSection,
         items: [ChatroomViewModel]) {
        self = original
        self.items = items
    }
    
}

extension ChatroomSection {
    
    init(items: [Item]) {
        self.init(header: 0, items: items)
    }
    
    static func sections(usingItems items: [Item]) -> [ChatroomSection] {
        return [ChatroomSection.init(items: items)]
    }
    
}
