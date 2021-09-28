//
//  HeaderView.swift
//  WheatherApp
//
//  Created by Apple on 14/09/2021.
//

import UIKit

class HeaderView: UIView {

    // MARK: - Identifier
    
    static let identifier = "HeaderView"
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var contentViews: UIView!
    @IBOutlet weak var degreeLbl: UILabel!
    
    // MARK: - Variables
    
    // MARK: - Constants
    
    // MARK: - View LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    required init?(coder aDecoder: NSCoder)
    {
        super .init(coder: aDecoder)
        loadNib()
    }
    
    // MARK: - Custom Functions
    
    func loadNib(){
        Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)
        addSubview(contentViews)
        contentViews.frame = self.bounds
        contentViews.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
