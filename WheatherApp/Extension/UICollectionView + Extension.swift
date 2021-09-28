//
//  FlowLayout.swift
//  WheatherApp
//
//  Created by Apple on 13/09/2021.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func updateFLow( itemSpacing: CGFloat = 5,  lineSpacing: CGFloat = 5, _ ishorizontal: Bool) {
        let flow = UICollectionViewFlowLayout()
        flow.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flow.minimumInteritemSpacing = itemSpacing
        flow.minimumLineSpacing = lineSpacing
        flow.scrollDirection = ishorizontal ? .horizontal : .vertical
        
        // Apply flow layout
        self.setCollectionViewLayout(flow, animated: true)
    }
    
    func isScrollEnable(isEnable: Bool) {
        self.isScrollEnabled = isEnable
    }
    
    func clearBackground() {
        self.backgroundColor = .clear
        self.backgroundView = UIView(frame: .zero)
    }
    func updateFLowTwo( itemSpacing: CGFloat = 5,  lineSpacing: CGFloat = 5, _ ishorizontal: Bool) {
        let flow = UICollectionViewFlowLayout()
        flow.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flow.minimumInteritemSpacing = itemSpacing
        flow.minimumLineSpacing = lineSpacing
        flow.scrollDirection = ishorizontal ? .horizontal : .vertical
        
        // Apply flow layout
        self.setCollectionViewLayout(flow, animated: true)
    }
}
