//
//  SignUpViewController.swift
//  ChatroomSignUp
//
//  Created by L on 2022/3/24.
//

import UIKit
import RxSwift
import RxCocoa

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var backToLoginButton: UIButton!
    
    private var presenter: Presentation!
    
    var presenterProducer: Presentation.Producer!
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = presenterProducer((
            username: self.usernameTextField.rx.text.orEmpty.asDriver(),
            password: self.passwordTextField.rx.text.orEmpty.asDriver(),
            email: self.emailTextField.rx.text.orEmpty.asDriver(),
            signup: self.signUpButton.rx.tap.asDriver(),
            backToLogin: self.backToLoginButton.rx.tap.asDriver()
        ))
        
        self.setupUI()
        self.setupBinding()
    }
    
    
}

private extension SignUpViewController {
    
    func setupUI() {
        self.avatarImageView.image = UIImage.init(named: "icon_male",in: Bundle(for: type(of: self)),with: nil)
        self.signUpButton.setImage(UIImage.init(named: "login",
                                               in: Bundle(for: type(of: self)),
                                               with: nil),
                                  for: .normal)
    }
    
    func setupBinding() {
        presenter.output.enableSignUp
            .debug("Enable SignUp Driver", trimOutput: false)
            .drive(self.signUpButton.rx.isEnabled)
            .disposed(by: self.bag)
    }
    
}
