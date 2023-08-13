//
//  StackNavigation.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/07/27.
//

import UIKit

func moveBacktoHome(vc: UIViewController) {

    
}

func moveToContentDescriptionVC(homeVC: UIViewController) {
    let storyboard = UIStoryboard(name: "ContentDescription", bundle: nil)
    let nextVC = storyboard.instantiateViewController(withIdentifier: String(describing: ContentDescriptionViewController.self)) as! ContentDescriptionViewController
    
    nextVC.homeDelegate = homeVC as! HomeViewController
    homeVC.navigationController?.pushViewController(nextVC, animated: true)
}

func moveToContentVC(vc: UIViewController, content: Content) {
    var contentVC: UIViewController!

    switch content {
    case .UIExplore:
        let storyboard = UIStoryboard(name: content.rawValue, bundle: nil)
        contentVC = storyboard.instantiateViewController(withIdentifier: String(describing: ARCharacterSelectViewController.self))
    case .ARKiosk:
        let storyboard = UIStoryboard(name: "KioskMainBoard", bundle: nil)
        contentVC = storyboard.instantiateViewController(withIdentifier: String(describing: KioskMainBoardViewController.self))
    case .AIExplore:
        let storyboard = UIStoryboard(name: "Scanner", bundle: nil)
        contentVC = storyboard.instantiateViewController(withIdentifier: String(describing: ScannerViewController.self))
    default:
        return
    }
    
    vc.navigationController?.pushViewController(contentVC, animated: true)
}

func moveToUIExploreVC(vc: UIViewController) {
    let storyboard = UIStoryboard(name: Content.UIExplore.rawValue, bundle: nil)
    guard let nextVC = storyboard.instantiateViewController(withIdentifier: String(describing: UIExploreViewController.self)) as? UIExploreViewController else { return }
    
    nextVC.arCharacterDelegate = vc as! ARCharacterSelectViewController
    vc.navigationController?.pushViewController(nextVC, animated: true)
}

func moveToARKioskVC(vc: UIViewController) {
    let storyboard = UIStoryboard(name: "ARKiosk", bundle: nil)
    guard let nextVC = storyboard.instantiateViewController(withIdentifier: "ARKioskViewController") as? ARKioskViewController else { return }
    vc.present(nextVC, animated: true)
//    vc.navigationController?.pushViewController(nextVC, animated: true)
}

func moveToKioskHomeVC (vc : UIViewController)
{
    let storyboard = UIStoryboard(name: "KioskMainBoard", bundle: nil)
    guard let nextVC = storyboard.instantiateViewController(withIdentifier: "KioskMainBoardViewController") as? KioskMainBoardViewController else { return }
  
    vc.navigationController?.pushViewController(nextVC, animated: true)
}

func moveToMenuSelection(vc: UIViewController) {
    let storyboard = UIStoryboard(name: "KioskMainBoard", bundle: nil)
    guard let nextVC = storyboard.instantiateViewController(withIdentifier: "MenuSelectionViewController") as? MenuSelectionViewController else { return }
    vc.navigationController?.pushViewController(nextVC, animated: true)
}
