// Race
//
//  Created by Владимир on 26.04.2021.
//

import Foundation
import UIKit

extension UIViewController {
    static func instantiate() -> Self {
    let name = String(describing: Self.self)
    let storyboard = UIStoryboard(name: name, bundle: Bundle.main)
    guard let viewController = storyboard.instantiateViewController(identifier: name) as? Self else {
    fatalError("cant init View Controller")
}
    return viewController
}
}

extension UIViewController {
    static func instantiateMainVC() -> Self {
    let name = String(describing: Self.self)
    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    guard let viewController = storyboard.instantiateViewController(identifier: name) as? Self else {
    fatalError("cant init View Controller")
}
    return viewController
}
}
