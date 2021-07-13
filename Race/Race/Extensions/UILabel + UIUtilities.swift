// Race
//
// Created by Владимир on 26.04.2021.
//

import Foundation
import UIKit

extension UIView {
    func applyCornerRadius(_ radius: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = radius
    }
    func makeShadow(opacity: Float, offSet: CGSize, radius: CGFloat) {
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
    }
}
