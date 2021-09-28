//
//  AppSingelton.swift
//  Travel
//
//  Created by Dev ILI on 06/08/2021.
//

import Foundation
//
//  AppSingleton.swift
//  KSC
//
//  Created by developer on 19/03/2021.
//

import Foundation
import UIKit

enum IPHONESIZE: String {
    case Iphone12
    case Iphone10
    case other
    case none
}

class AppSingleton: NSObject {
    
    // MARK: - Shared instance
    static let shared = AppSingleton()
    
    // MARK: - Shared Variables
    // APP Delegate
    let appDelegate: AppDelegate!
    
    // App Variables
    
    // MARK: - Init
    override init() {
        appDelegate = UIApplication.shared.delegate as? AppDelegate
    }
    
    // MARK: - Shared methods
    func getStoryboardReference(storyboard: StoryboardReference) -> UIStoryboard {
        return UIStoryboard(name: storyboard.rawValue, bundle: nil)
    }
    
    func navigateView(viewRef: ViewControllerReference, storyboard: StoryboardReference) -> UIViewController {
        let view = getStoryboardReference(storyboard: storyboard).instantiateViewController(withIdentifier: viewRef.rawValue)
        return view
    }
    
    func setRoot(_ view: UIViewController) {
        if let scene = UIApplication.shared.connectedScenes.first {
            guard let windowScene = (scene as? UIWindowScene) else { return }
            let window: UIWindow = UIWindow(frame: windowScene.coordinateSpace.bounds)
            self.appDelegate.window = window
            window.windowScene = windowScene
            window.rootViewController = view
            window.makeKeyAndVisible()
        }
    }
    
    
}
