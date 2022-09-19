//
//  AppDelegate.swift
//  PetFinder
//
//  Created by Justin Maronde on 9/19/22.
//

import UIKit
import Reachability

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let reachability = try! Reachability()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        setupReachability()
        
        PetfinderAPIManager.shared.fetchAccessToken() { isSuccess in
          if !isSuccess {
            print("Error fetching access token")
          }
        }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        window?.rootViewController = HomeViewController()
        
        return true
    }
    
    private func setupReachability() {
        //Setup an observer for Reachability.
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)),
                                               name: .reachabilityChanged, object: reachability)
        
        //Start up reachability.
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }

    @objc func reachabilityChanged(note: Notification) {
      let reachability = note.object as! Reachability

      switch reachability.connection {
          case .wifi:
            print("Reachable via WiFi")
          case .cellular:
            print("Reachable via Cellular")
          case .unavailable:
            print("Network not reachable")
          case .none:
            print("Network not reachable")
      }
    }

}

