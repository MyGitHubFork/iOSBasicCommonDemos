//
//  Photo.swift
//  GooglyPuff
//
//  Created by Bjørn Olav Ruud on 06.08.14.
//  Copyright (c) 2014 raywenderlich.com. All rights reserved.
//

import AssetsLibrary
import UIKit

typealias PhotoDownloadCompletionBlock = (image: UIImage?, error: NSError?) -> Void
typealias PhotoDownloadProgressBlock = (completed: Int, total: Int) -> Void

enum PhotoStatus {
  case Downloading
  case GoodToGo
  case Failed
}

protocol Photo {
  var status: PhotoStatus { get }
  var image: UIImage? { get }
  var thumbnail: UIImage? { get }
}

class AssetPhoto: Photo {
  var status: PhotoStatus {
    return .GoodToGo
  }

  var image: UIImage? {
    let representation = asset.defaultRepresentation()
    return UIImage(CGImage: representation.fullScreenImage().takeUnretainedValue())
  }
  
  var thumbnail: UIImage? {
    return UIImage(CGImage: asset.thumbnail().takeUnretainedValue())
  }

  let asset: ALAsset

  init(asset: ALAsset) {
    self.asset = asset
  }
}

private let downloadSession = NSURLSession(configuration: NSURLSessionConfiguration.ephemeralSessionConfiguration())

class DownloadPhoto: Photo {
  var status: PhotoStatus = .Downloading
  var image: UIImage?
  var thumbnail: UIImage?

  let url: NSURL

  init(url: NSURL, completion: PhotoDownloadCompletionBlock!) {
    self.url = url
    downloadImage(completion)
  }

  convenience init(url: NSURL) {
    self.init(url: url, completion: nil)
  }

  func downloadImage(completion: PhotoDownloadCompletionBlock?) {
    let task = downloadSession.dataTaskWithURL(url, completionHandler: {
      data, response, error in
      self.image = UIImage(data: data)
      if error == nil && self.image != nil {
        self.status = .GoodToGo
      } else {
        self.status = .Failed
      }

      self.thumbnail = self.image?.thumbnailImage(64,
        transparentBorder: 0,
        cornerRadius: 0,
        interpolationQuality: kCGInterpolationDefault)

      if let completion = completion {
        completion(image: self.image, error: error)
      }
      //图片下载完成以后，会发送一个图片下载完成通知
      dispatch_async(dispatch_get_main_queue()) {
        NSNotificationCenter.defaultCenter().postNotificationName(PhotoManagerContentUpdateNotification, object: nil)
      }
    })

    task.resume()
  }
}
