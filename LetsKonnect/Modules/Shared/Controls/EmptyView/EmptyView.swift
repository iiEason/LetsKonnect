//
//  EmptyView.swift
//  EmptyView
//
//  Created by L on 2022/2/22.
//

import UIKit

public final class EmptyView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var emptyImageView: UIImageView!
    
    @IBOutlet weak var emptyTitle: UILabel!
    
    @IBOutlet weak var emptySubTitle: UILabel!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    public func configure(image: UIImage,
                          title: String,
                          subtitle: String) {
        self.emptyImageView.image = image
        self.emptyTitle.text = title
        self.emptySubTitle.text = subtitle
    }
    
}

private extension EmptyView {
    
    func setup() {
        
        if let view = Bundle(for: type(of: self)).loadNibNamed("EmptyView", owner: self, options: nil)?.first as? UIView {
            self.addSubview(view)
        }
        
        backgroundColor = .clear
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
    }
    
    
}
