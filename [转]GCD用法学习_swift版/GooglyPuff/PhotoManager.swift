//
//  PhotoManager.swift
//  GooglyPuff
//
//  Created by Bjørn Olav Ruud on 06.08.14.
//  Copyright (c) 2014 raywenderlich.com. All rights reserved.
//

import Foundation

/// Notification when new photo instances are added
let PhotoManagerAddedContentNotification = "com.raywenderlich.GooglyPuff.PhotoManagerAddedContent"
/// Notification when content updates (i.e. Download finishes)
let PhotoManagerContentUpdateNotification = "com.raywenderlich.GooglyPuff.PhotoManagerContentUpdate"

typealias PhotoProcessingProgressClosure = (completionPercentage: CGFloat) -> Void
typealias BatchPhotoDownloadingCompletionClosure = (error: NSError?) -> Void

private let _sharedManager = PhotoManager()//全局私有存储属性

class PhotoManager {
  //类方法, 类计算属性。返回私有的存储属性。。这里实现单列模式
  class var sharedManager: PhotoManager {
    return _sharedManager
  }

  private var _photos: [Photo] = []//私有的存储属性
 // 这个属性的getter方法是一个读方法。调用者得到一个数组的拷贝并且保护了原始数组不被改变，但是这不能保证一个线程在调用addPhoto来写的时候没有另一个线程同时也在调用getter方法读photos属性。
  //可变的计算属性，返回存储属性的值。
  var photos: [Photo] {
    var photosCopy: [Photo]!
    dispatch_sync(concurrentPhotoQueue) { // 1 同步调度到concurrentPhotoQueue队列执行读操作。
      photosCopy = self._photos // 2 保存图片数组的拷贝到photoCopy并返回它。
    }
    return photosCopy
  }
  
  private let concurrentPhotoQueue = dispatch_queue_create(
    "com.raywenderlich.GooglyPuff.photoQueue", DISPATCH_QUEUE_CONCURRENT)
  
//  来看这段代码如何工作的： 1. 将写操作加入自定义的队列中。当临界区被执行时，这是队列中唯一一个在执行的任务。 2. 将对象加入数组。因为是屏障闭包，这个闭包不会和concurrentPhotoQueue中的其他任务同时执行。 3. 最终发送一个添加了图片的通知。这个通知应该在主线程中发送因为这涉及到UI，所以这里分派另一个异步任务到主队列中。
  func addPhoto(photo: Photo) {
    dispatch_barrier_async(concurrentPhotoQueue) { // 1
      self._photos.append(photo) // 2
      dispatch_async(GlobalMainQueue) { // 3
        self.postContentAddedNotification()
      }
    }
  }

//  在学习下一个调度组的用法前，先看看怎样在不同的队列类型下使用调度组。
//  
//  自定义顺序队列：好选择。当一组任务完成时用它发送通知。
//  主队列（顺序）：在当前情景下是不错的选择。但你要谨慎地在主队列中使用，因为同步等待所有任务会阻塞主线程。然而，当一个需要较长时间的任务（比如网络请求）完成时，异步更新UI是很好的选择。
//  并发队列：好选择。用于调度组和通知。

  func downloadPhotosWithCompletion4(completion: BatchPhotoDownloadingCompletionClosure?) {
    var storedError: NSError!
    let downloadGroup = dispatch_group_create()
    var addresses = [OverlyAttachedGirlfriendURLString,
      SuccessKidURLString,
      LotsOfFacesURLString]
    addresses += addresses + addresses // 1
    var blocks: [dispatch_block_t] = [] // 2
    
    for i in 0 ..< addresses.count {
      dispatch_group_enter(downloadGroup)
      let block = dispatch_block_create(DISPATCH_BLOCK_INHERIT_QOS_CLASS) { // 3
        let index = Int(i)
        let address = addresses[index]
        let url = NSURL(string: address)
        let photo = DownloadPhoto(url: url!) {
          image, error in
          if let error = error {
            storedError = error
          }
          dispatch_group_leave(downloadGroup)
        }
        PhotoManager.sharedManager.addPhoto(photo)
      }
      blocks.append(block)
      dispatch_async(GlobalMainQueue, block) // 4
    }
    
    for block in blocks[3 ..< blocks.count] { // 5
      let cancel = arc4random_uniform(2) // 6
      if cancel == 1 {
        dispatch_block_cancel(block) // 7
        dispatch_group_leave(downloadGroup) // 8
      }
    }
    
    dispatch_group_notify(downloadGroup, GlobalMainQueue) {
      if let completion = completion {
        completion(error: storedError)
      }
    }
    
  }
  
  func downloadPhotosWithCompletion3(completion: BatchPhotoDownloadingCompletionClosure?) {
    var storedError: NSError!
    var downloadGroup = dispatch_group_create()
    let addresses = [OverlyAttachedGirlfriendURLString,
      SuccessKidURLString,
      LotsOfFacesURLString]
    
    dispatch_apply(UInt(addresses.count), GlobalUserInitiatedQueue) {
      i in
      let index = Int(i)
      let address = addresses[index]
      let url = NSURL(string: address)
      dispatch_group_enter(downloadGroup)
      let photo = DownloadPhoto(url: url!) {
        image, error in
        if let error = error {
          storedError = error
        }
        dispatch_group_leave(downloadGroup)
      }
      PhotoManager.sharedManager.addPhoto(photo)
    }
    dispatch_group_notify(downloadGroup, GlobalMainQueue) {
      if let completion = completion {
        completion(error: storedError)
      }
    }
  }

  func downloadPhotosWithCompletion2(completion: BatchPhotoDownloadingCompletionClosure?) {
    var storedError: NSError!
    var downloadGroup = dispatch_group_create()
    
    for address in [OverlyAttachedGirlfriendURLString,
      SuccessKidURLString,
      LotsOfFacesURLString]
    {
      let url = NSURL(string: address)
      dispatch_group_enter(downloadGroup)
      let photo = DownloadPhoto(url: url!) {
        image, error in
        if let error = error {
          storedError = error
        }
        dispatch_group_leave(downloadGroup)
      }
      PhotoManager.sharedManager.addPhoto(photo)
    }
    //dispatch_group_notify异步执行闭包。当调度组内没有剩余任务的时候闭包才执行。同样要指明在哪个队列中执行闭包。当下，你需要在主队列中执行闭包。
    dispatch_group_notify(downloadGroup, GlobalMainQueue) { // 2
      if let completion = completion {
        completion(error: storedError)
      }
    }
  }

  func downloadPhotosWithCompletion(completion: BatchPhotoDownloadingCompletionClosure?) {
    dispatch_async(GlobalUserInitiatedQueue) { // 1因为使用dispatch_group_wait阻塞了当前进程，要用dispatch_async将整个方法放到后台队列，才能保证主线程不被阻塞。
      var storedError: NSError!
      var downloadGroup = dispatch_group_create() // 2创建一个调度组，作用好比未完成任务的计数器。
      
      for address in [OverlyAttachedGirlfriendURLString,
        SuccessKidURLString,
        LotsOfFacesURLString]
      {
        let url = NSURL(string: address)
        dispatch_group_enter(downloadGroup) // 3dispatch_group_enter通知调度组一个任务已经开始。你必须保证dispatch_group_enter和dispatch_group_leave是成对调用的，否则程序会崩溃。
        let photo = DownloadPhoto(url: url!) {
          image, error in
          if let error = error {
            storedError = error
          }
          dispatch_group_leave(downloadGroup) // 4通知任务已经完成。再一次，这里保持进和出相匹配。
        }
        PhotoManager.sharedManager.addPhoto(photo)
      }
      
      dispatch_group_wait(downloadGroup, DISPATCH_TIME_FOREVER) // 5dispatch_group_wait等待所有任务都完成直到超时。如果在任务完成前就超时了，函数会返回一个非零值。可以通过返回值来判断是否等待超时；不过，这里你用DISPATCH_TIME_FOREVER来表示一直等待。这意味着，它会永远等待！没关系，因为图片总是会下载完的。
      dispatch_async(GlobalMainQueue) { // 6此时，你可以保证所有图片任务都完成或是超时了。接下来在主队列中加入完成闭包。闭包晚些时候会在主线程中执行。
        if let completion = completion { // 7执行闭包。
          completion(error: storedError)
        }
      }
    }
    
  }

  
  private func postContentAddedNotification() {
    NSNotificationCenter.defaultCenter().postNotificationName(PhotoManagerAddedContentNotification, object: nil)
    
  }
}
