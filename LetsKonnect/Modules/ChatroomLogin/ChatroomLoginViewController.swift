//
//  ChatroomLoginViewController.swift
//  ChatroomLogin
//
//  Created by L on 2022/2/11.
//

import UIKit
import RxSwift
import RxCocoa

class ChatroomLoginViewController: UIViewController {
    
    @IBOutlet weak var titleLbael: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var userEmail: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    private var presenter: Presentation!
    
    var presenterProducer: Presentation.Producer!

    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = presenterProducer((
            username: self.userName.rx.text.orEmpty.asDriver(),
            email: self.userEmail.rx.text.orEmpty.asDriver(),
            login: self.loginButton.rx.tap.asDriver(),
            signUp: self.signUpButton.rx.tap.asDriver()
        ))
        
        self.setupUI()
        self.setupBinding()
        
    }
    
    @IBAction func clickLogin(_ sender: Any) {
        
    }
    
}

private extension ChatroomLoginViewController {
    
    func setupUI() {
        self.avatarImageView.image = UIImage.init(named: "icon_female",in: Bundle(for: ChatroomLoginViewController.self),with: nil)
        self.loginButton.setImage(UIImage.init(named: "login",
                                               in: Bundle(for: ChatroomLoginViewController.self),
                                               with: nil),
                                  for: .normal)
    }
    
    func setupBinding() {
        
        presenter.onput.enableLogin
            .debug("Enable Login Driver", trimOutput: false)
            .drive(self.loginButton.rx.isEnabled)
            .disposed(by: self.bag)
        
    }
}
