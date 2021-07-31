//
//  Animations.swift
//  ChartTracker
//
//  Created by Nicholas Repaci on 7/31/21.
//

import Foundation
import UIKit

class Animations {

func animateLines(view1: UIView, view2: UIView) {
    UIView.animate(withDuration: 0.6,
                   animations: {
                    view1.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
                    view2.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
                   },
                   completion: { _ in
                    UIView.animate(withDuration: 0.6) {
                        view1.transform = CGAffineTransform.identity
                        view2.transform = CGAffineTransform.identity
                    }
                   })
}

func animateGetChartButton(button: UIButton) {
    UIView.animate(withDuration: 0.09,
                   animations: {
                    button.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                   },
                   completion: { _ in
                    UIView.animate(withDuration: 0.09) {
                        button.transform = CGAffineTransform.identity
                    }
                   })
}
}
