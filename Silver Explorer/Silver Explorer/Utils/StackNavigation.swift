//
//  StackNavigation.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/07/27.
//

import UIKit

func moveToContentVC(homeVC: UIViewController, content: Content, storyBoardID: String) {
    let storyboard = UIStoryboard(name: content.rawValue, bundle: nil)
    let nextVC = storyboard.instantiateViewController(withIdentifier: storyBoardID)
    
    homeVC.navigationController?.pushViewController(nextVC, animated: true)
}

func moveToUIExploreVC(vc: UIViewController) {
    let storyboard = UIStoryboard(name: "UIExplore", bundle: nil)
    guard let nextVC = storyboard.instantiateViewController(withIdentifier: "UIExploreViewController") as? UIExploreViewController else { return }
    
    nextVC.arCharacterDelegate = vc as! ARCharacterSelectViewController
    vc.navigationController?.pushViewController(nextVC, animated: true)
}

func moveBacktoHome(vc: UIViewController) {
    vc.navigationController?.popToRootViewController(animated: true)
}
