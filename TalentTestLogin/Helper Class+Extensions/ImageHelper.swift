//
//  ImageHelper.swift
//  TalentTestLogin
//
//  Created by Rajeev Radhakrishnan on 21/02/2019.
//  Copyright © 2019 Rajeev Radhakrishnan. All rights reserved.
//

import UIKit
import SVGKit

extension UIImageView
{
    func loadSVGImage(url:String)
    {
        let svgImage = SVGKImage(contentsOf: URL(string: url))
        self.image = svgImage?.uiImage
    }
}
