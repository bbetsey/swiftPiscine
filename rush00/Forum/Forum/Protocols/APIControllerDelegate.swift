//
//  APIControllerDelegate.swift
//  Forum
//
//  Created by Artem Potekhin on 16.08.2022.
//

import Foundation
import UIKit

protocol APIControllerDelegate: AnyObject {
    func handleErrors(error: IntraError)
    func receiveAccessToken(token: String)
    func receiveUserInfo(info: UserInfo)
    func handleImage(image: UIImage)
}
