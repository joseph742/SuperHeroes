//
//  ImageView+Extension.swift
//  SuperHeroes
//
//  Created by Joseph Umoru on 14/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView{
    func loadImage(at url: URL) {
      UIImageLoader.loader.load(url, for: self)
    }

    func cancelImageLoad() {
      UIImageLoader.loader.cancel(for: self)
    }
}
