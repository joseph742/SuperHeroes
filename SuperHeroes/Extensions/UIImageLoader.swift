//
//  UIImageLoader.swift
//  SuperHeroes
//
//  Created by Joseph Umoru on 14/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import Foundation
import UIKit

class UIImageLoader {
    
    static let loader = UIImageLoader()

    private let imageLoader = ImageLoader()
    private var uuidMap = [UIImageView: UUID]()

    private init() {}
    
    func load(_ url: URL, for imageView: UIImageView) {
      let token = imageLoader.loadImage(url) { result in
          defer { self.uuidMap.removeValue(forKey: imageView) }
          
          switch result {
              case .failure(let error):
                  print(error.localizedDescription)
              case .success(let image):
                  DispatchQueue.main.async {
                      imageView.image = image
                  }
          }
          
      }
      
      if let token = token {
        uuidMap[imageView] = token
      }
    }

  func cancel(for imageView: UIImageView) {
    if let uuid = uuidMap[imageView] {
      imageLoader.cancelLoad(uuid)
      uuidMap.removeValue(forKey: imageView)
    }
  }
}
