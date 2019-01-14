//
//  AppDelegate.swift
//  bbcNews
//
//  Created by JJ Montes on 13/01/2019.
//  Copyright © 2019 jjmontes. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var navigationController: UINavigationController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //Check Jail Break
        if application.isDeviceJailbroken() {
            self.showDeviceJailbrokenAlert()
        }
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.navigationController = HomeAssembly.homePresenterNavigationController()
        self.navigationController?.isNavigationBarHidden = true
        self.window?.rootViewController = self.navigationController
        self.window?.makeKeyAndVisible()
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        self.refreshView()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    //Realiza el refresco de la pantalla, al volver de segundo plano.
    private func refreshView() {
        // Necesario para refrescar la infomración cuando se vuelve de segundo plano.
        if let nav = window?.rootViewController {
            //Si tenemos implementado en nuestra vista el protocolo, será ejecutado desde esta función.
            let top = nav.navigationController?.topViewController
            if let refresh = top as? BaseViewControllerRefresh {
                refresh.backToBackGroundRefresh()
            }
        }
    }
    
    private func showDeviceJailbrokenAlert() {
        let alert = UIAlertController(title: "Error!", message: "Your device is jailbroken. For security reasons this app can't be run on a jailbroken device. ", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Exit", style: UIAlertAction.Style.destructive, handler: { _ in exit(1) }))
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindow.Level.alert + 1
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.present(alert, animated: true, completion: nil)
    }
}
