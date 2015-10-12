//
//  PhotoCollectionViewController.swift
//  GooglyPuff
//
//  Created by Bjørn Olav Ruud on 06.08.14.
//  Copyright (c) 2014 raywenderlich.com. All rights reserved.
//

import UIKit

private let CellImageViewTag = 3
private let BackgroundImageOpacity: CGFloat = 0.1

class PhotoCollectionViewController: UICollectionViewController
{
  var library: ALAssetsLibrary!
  private var popController: UIPopoverController!

  private var contentUpdateObserver: NSObjectProtocol!
  private var addedContentObserver: NSObjectProtocol!

  // MARK: - Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    library = ALAssetsLibrary()

    // Background image setup
    let backgroundImageView = UIImageView(image: UIImage(named:"background"))
    backgroundImageView.alpha = BackgroundImageOpacity
    backgroundImageView.contentMode = .Center
    collectionView?.backgroundView = backgroundImageView

    //推送一个通知
    contentUpdateObserver = NSNotificationCenter.defaultCenter().addObserverForName(PhotoManagerContentUpdateNotification,
      object: nil,
      queue: NSOperationQueue.mainQueue()) { notification in
        self.contentChangedNotification(notification)
    }
    addedContentObserver = NSNotificationCenter.defaultCenter().addObserverForName(PhotoManagerAddedContentNotification,
      object: nil,
      queue: NSOperationQueue.mainQueue()) { notification in
        self.contentChangedNotification(notification)
    }
  }

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    showOrHideNavPrompt()//提醒用户选择图片
  }

  deinit {
    let nc = NSNotificationCenter.defaultCenter()
    if contentUpdateObserver != nil {
      nc.removeObserver(contentUpdateObserver)
    }
    if addedContentObserver != nil {
      nc.removeObserver(addedContentObserver)
    }
  }
}

//collectionview数据源代理方法
// MARK: - UICollectionViewDataSource

private let PhotoCollectionCellID = "photoCell"

extension PhotoCollectionViewController: UICollectionViewDataSource {
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return PhotoManager.sharedManager.photos.count
  }

  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(PhotoCollectionCellID, forIndexPath: indexPath) as UICollectionViewCell

    let imageView = cell.viewWithTag(CellImageViewTag) as UIImageView
    let photoAssets = PhotoManager.sharedManager.photos
    let photo = photoAssets[indexPath.row]

    switch photo.status {
    case .GoodToGo:
      imageView.image = photo.thumbnail
    case .Downloading:
      imageView.image = UIImage(named: "photoDownloading")
    case .Failed:
      imageView.image = UIImage(named: "photoDownloadError")
    }

    return cell
  }
}

// MARK: - UICollectionViewDelegate

extension PhotoCollectionViewController: UICollectionViewDelegate {
  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    let photos = PhotoManager.sharedManager.photos
    let photo = photos[indexPath.row]

    switch photo.status {
    case .GoodToGo:
      let detailController = storyboard!.instantiateViewControllerWithIdentifier("PhotoDetailViewController") as PhotoDetailViewController
      detailController.image = photo.image
      navigationController?.pushViewController(detailController, animated: true)

    case .Downloading:
      let alert = UIAlertController(title: "Downloading",
        message: "The image is currently downloading",
        preferredStyle: .Alert)
      alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
      presentViewController(alert, animated: true, completion: nil)

    case .Failed:
      let alert = UIAlertController(title: "Image Failed",
        message: "The image failed to be created",
        preferredStyle: .Alert)
      alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
      presentViewController(alert, animated: true, completion: nil)
    }
  }
}

// MARK: - ELCImagePickerControllerDelegate
//从图库选择图片的imagepacker的代理方法
extension PhotoCollectionViewController: ELCImagePickerControllerDelegate {
  func elcImagePickerController(picker: ELCImagePickerController!, didFinishPickingMediaWithInfo info: [AnyObject]!) {
    for dictionary in info as [NSDictionary] {
      library.assetForURL(dictionary[UIImagePickerControllerReferenceURL] as NSURL, resultBlock: {
        asset in
        let photo = AssetPhoto(asset: asset)
        PhotoManager.sharedManager.addPhoto(photo)
      },
      failureBlock: {
        error in
        let alert = UIAlertController(title: "Permission Denied",
          message: "To access your photos, please change the permissions in Settings",
          preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
      })
    }

    if Utils.userInterfaceIdiomIsPad {
      popController?.dismissPopoverAnimated(true)
    } else {
      dismissViewControllerAnimated(true, completion: nil)
    }
  }
  
  //取消从图库选择图片
  func elcImagePickerControllerDidCancel(picker: ELCImagePickerController!) {
    if Utils.userInterfaceIdiomIsPad {
      popController?.dismissPopoverAnimated(true)
    } else {
      dismissViewControllerAnimated(true, completion: nil)
    }
  }
}

// MARK: - IBAction Methods
//popViewController用法
extension PhotoCollectionViewController {
  // The upper right UIBarButtonItem method
  @IBAction func addPhotoAssets(sender: AnyObject!) {
    // Close popover if it is visible
    if popController?.popoverVisible == true {
      popController.dismissPopoverAnimated(true)
      popController = nil
      return
    }

    let alert = UIAlertController(title: "从哪里选择图片:", message: nil, preferredStyle: .ActionSheet)

    // Cancel button
    let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
    alert.addAction(cancelAction)

    // 从图库选择图片
    let libraryAction = UIAlertAction(title: "图库", style: .Default) {
      action in
      let imagePickerController = ELCImagePickerController()
      imagePickerController.imagePickerDelegate = self//代理方法在上面

      if Utils.userInterfaceIdiomIsPad {//是否是ipad
        self.popController.dismissPopoverAnimated(true)
        self.popController = UIPopoverController(contentViewController: imagePickerController)
        self.popController.presentPopoverFromBarButtonItem(self.navigationItem.rightBarButtonItem!, permittedArrowDirections: .Any, animated: true)
      } else {
        self.presentViewController(imagePickerController, animated: true, completion: nil)
      }
    }
    alert.addAction(libraryAction)

    // 从网上加载图片
    let internetAction = UIAlertAction(title: "网络", style: .Default) {
      action in
      self.downloadImageAssets()
    }
    alert.addAction(internetAction)

    
    if Utils.userInterfaceIdiomIsPad {
      popController = UIPopoverController(contentViewController: alert)
      popController.presentPopoverFromBarButtonItem(navigationItem.rightBarButtonItem!, permittedArrowDirections: .Any, animated: true)
    } else {
      presentViewController(alert, animated: true, completion: nil)
    }
  }
}

// MARK: - Private Methods
//图片从网络下载完成以后会接收到通知。
private extension PhotoCollectionViewController {
  func contentChangedNotification(notification: NSNotification!) {
    collectionView?.reloadData()
    showOrHideNavPrompt();
  }

  
//  想知道何时使用dispatch_after？
//  
//  自定义顺序队列：慎用。在自定义顺序队列中慎用dispatch_after。你最好留在主队列中。
//  主队列（顺序）：好主意。在主队列中使用dispatch_after是一个好主意；Xcode对此有自动补全模板。
//  并发队列：慎用。很少会这样使用，最好留在主队列中。
  
  //showOrHideNavPrompt会在viewDidLoad以及UICollectionView重新加载的时候被执行。
  func showOrHideNavPrompt() {
    let delayInSeconds = 1.0
    let popTime = dispatch_time(DISPATCH_TIME_NOW,
      Int64(delayInSeconds * Double(NSEC_PER_SEC))) // 1
    dispatch_after(popTime, GlobalMainQueue) { // 2
      let count = PhotoManager.sharedManager.photos.count
      if count > 0 {
        self.navigationItem.prompt = nil
      } else {
        self.navigationItem.prompt = "Add photos with faces to Googlyify them!"
      }
    }
  }
  
  
  //从网上下载图片
  func downloadImageAssets() {
    PhotoManager.sharedManager.downloadPhotosWithCompletion() {
      error in
      // This completion block currently executes at the wrong time
      let message = error?.localizedDescription ?? "The images have finished downloading"
      let alert = UIAlertController(title: "Download Complete", message: message, preferredStyle: .Alert)
      alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
      self.presentViewController(alert, animated: true, completion: nil)
    }
  }
}
