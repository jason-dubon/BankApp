//
//  AppDelegate.swift
//  Bankey
//
//  Created by Jason Dubon on 5/26/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    
    
    let loginViewController = LoginViewController()
    let onboardingContainerViewController = OnboardingContainerViewController()
    let dummyViewController = DummyViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        window?.rootViewController = loginViewController
        
        loginViewController.delegate = self
        
        //window?.rootViewController = onboardingContainerViewController
        
        onboardingContainerViewController.delegate = self
        
        //window?.rootViewController = dummyViewController
        
        dummyViewController.logoutDelegate = self
        
        //window?.rootViewController = OnboardingViewController(heroImageName: "car", titleText: "This will change your life!")
        return true
    }

}

extension AppDelegate {
    
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
     
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
        
    }
  
}

extension AppDelegate: LoginViewControllerDelegate {
    
    func didLogin() {
        if LocalState.hasOnboarded {
            setRootViewController(dummyViewController)
        } else {
            setRootViewController(onboardingContainerViewController)
        }
        
    }
    
    
}

extension AppDelegate: OnboardingContainerViewControllerDelegate {
    
    func didFinishOnboarding() {
        LocalState.hasOnboarded = true
        setRootViewController(dummyViewController)
    }
    
}

extension AppDelegate: LogoutDelegate {
   
    func didLogout() {
        setRootViewController(loginViewController)
    }
    
    
    
}




