//
//  AnimateLabelText.swift
//  ChartTracker
//
//  Created by Nicholas Repaci on 8/8/21.
//

import Foundation
import UIKit


class AnimateLabelText {
    func animateLabel(labelToAnimate: UILabel) {
        labelToAnimate.text = ""
        let titleText = "ChartTracker"
        var charIndex = 0.0
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.25 * charIndex, repeats: false) { (timer) in
                labelToAnimate.text?.append(letter)
            }
            charIndex += 1
        }
        labelToAnimate.layer.zPosition = 1
    }
}
