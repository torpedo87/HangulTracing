//
//  AppDelegate.swift
//  HangulTracing
//
//  Created by junwoo on 2017. 11. 3..
//  Copyright © 2017년 samchon. All rights reserved.
//

import UIKit
import SnapKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    let sceneCoordinator = SceneCoordinator()
    self.window = sceneCoordinator.window
    let localService = LocalService()
    let audioPlayer = SoundPlayer()
    let categoryViewModel = CategoryViewModel(localService: localService,
                                              sceneCoordinator: sceneCoordinator,
                                              audioPlayer: audioPlayer)
    let categoryScene = Scene.category(categoryViewModel)
    sceneCoordinator.transition(to: categoryScene, type: .root)
    
    let navigationBarAppearace = UINavigationBar.appearance()
    navigationBarAppearace.tintColor = UIColor.white
    navigationBarAppearace.barTintColor = UIColor.clear
    navigationBarAppearace.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    return true
  }
  
  func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
    let presentedViewController = UIHelper.topViewController()
    if presentedViewController is orientationIsOnlyLandScapeRight {
      return .landscapeRight
    }
    return .portrait
  }

}

protocol orientationIsOnlyLandScapeRight {}
class UIHelper {
  
  class func topViewController() -> UIViewController? {
    let helper = UIHelper()
    return helper.topViewControllerWithRootViewController(rootViewController: UIApplication.shared.keyWindow?.rootViewController)
  }
  
  private func topViewControllerWithRootViewController(rootViewController:UIViewController?) -> UIViewController?
  {
    if(rootViewController != nil)
    {
      // UINavigationController
      if let navigationController = rootViewController as? UINavigationController,
        let visibleViewController = navigationController.visibleViewController {
        return self.topViewControllerWithRootViewController(rootViewController: visibleViewController)
      }
      
      if rootViewController!.presentedViewController != nil {
        let presentedViewController = rootViewController!.presentedViewController
        return self.topViewControllerWithRootViewController(rootViewController: presentedViewController!)
      } else {
        return rootViewController
      }
    }
    return nil
  }
  
}


