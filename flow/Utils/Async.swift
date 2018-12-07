//
//  Async.swift
//  flow
//
//  Created by Usuario on 12/5/18.
//  Copyright © 2018 Consoni. All rights reserved.
//

import Foundation

func onMainDo<T>(_ firstMainBlock: @escaping () -> Void,
                 onBackgroundDo backgroundBlock: @escaping () -> T,
                 thenOnMainDo mainBlock: @escaping (T) -> Void) {
  DispatchQueue.main.async {
    firstMainBlock()
    DispatchQueue.global(qos: .background).async {
      let result = backgroundBlock()
      DispatchQueue.main.async {
        mainBlock(result)
      }
    }
  }
}
