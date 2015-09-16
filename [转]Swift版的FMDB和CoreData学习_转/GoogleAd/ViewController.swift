//
//  ViewController.swift
//  GoogleAd
//
//  Created by Limin Du on 8/27/14.
//  Copyright (c) 2014 GoldenFire.Do. All rights reserved.
//

import UIKit
import iAd

class ViewController: UIViewController, GADBannerViewDelegate, GADInterstitialDelegate,  ADBannerViewDelegate {
    var iAdSupported = false
    var iAdView:ADBannerView?
    var bannerView:GADBannerView?
    var interstitial:GADInterstitial?
    var button:UIButton?
    var imageView:UIImageView?
    var timer:NSTimer?
    var loadRequestAllowed = true
    var bannerDisplayed = false
    let statusbarHeight:CGFloat = 20.0
    
    var demoButton:UIButton?
    
    var demoCoreDataButton:UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        iAdSupported = iAdTimeZoneSupported()
        
        bannerDisplayed = false
        
        if iAdSupported {
            iAdView = ADBannerView(adType: ADAdType.Banner)
            iAdView?.frame = CGRectMake(0, 0 - iAdView!.frame.height, iAdView!.frame.width, iAdView!.frame.height)
            iAdView?.delegate = self
            self.view.addSubview(iAdView!)
            
        } else {
            bannerView = GADBannerView(adSize: kGADAdSizeBanner)
            bannerView?.adUnitID = "ca-app-pub-6938332798224330/9023870805"
            bannerView?.delegate = self
            bannerView?.rootViewController = self
            self.view.addSubview(bannerView!)
            bannerView?.loadRequest(GADRequest())
        
            timer?.invalidate()
            timer = NSTimer.scheduledTimerWithTimeInterval(40, target: self, selector: "GoogleAdRequestTimer", userInfo: nil, repeats: true)
        }
        
        var image = UIImage(named: "admob.png")
        imageView = UIImageView(image: image)
        var frame = imageView!.frame
        frame.origin.x = 0
        frame.origin.y = statusbarHeight
        imageView!.frame = frame
        self.view.addSubview(imageView!)
        
        //Admob Interstitial
        if !iAdSupported {
            interstitial = createAndLoadInterstitial()
            
            button = UIButton.buttonWithType(UIButtonType.System) as? UIButton
            button?.frame = CGRectMake(60, 20, 180, 20)
            button?.setTitle("<<<点此测试插屏广告>>>", forState: UIControlState.Normal)
            button?.enabled = false
            button?.userInteractionEnabled = true
            button?.addTarget(self, action: "presentInterstitial:", forControlEvents: .TouchUpInside)
            self.view.addSubview(button!)
        }
        
        demoButton = UIButton.buttonWithType(UIButtonType.System) as? UIButton
        demoButton?.frame = CGRectMake(40, 45, 240, 20)
        demoButton?.setTitle("<<<点此测试 Wrapping FMDB>>>", forState: UIControlState.Normal)
        demoButton?.userInteractionEnabled = true
        demoButton?.addTarget(self, action: "showDemo:", forControlEvents: .TouchUpInside)
        self.view.addSubview(demoButton!)
        
        demoCoreDataButton = UIButton.buttonWithType(UIButtonType.System) as? UIButton
        demoCoreDataButton?.frame = CGRectMake(20, 70, 280, 20)
        demoCoreDataButton?.setTitle("<<<点此测试 Wrapping CoreData>>>", forState: UIControlState.Normal)
        demoCoreDataButton?.userInteractionEnabled = true
        demoCoreDataButton?.addTarget(self, action: "showCoreDataDemo:", forControlEvents: .TouchUpInside)
        self.view.addSubview(demoCoreDataButton!)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "AppBecomeActive", name: UIApplicationDidBecomeActiveNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "AppResignActive", name: UIApplicationWillResignActiveNotification, object: nil)
    }

    func GoogleAdRequestTimer() {
        if iAdSupported {
            return;
        }
        
        if (!loadRequestAllowed) {
            println("load request not allowed")
            return
        }
        
        println("load request")
        bannerView?.loadRequest(GADRequest())
    }
    
    func AppBecomeActive() {
        println("received UIApplicationDidBecomeActiveNotification")
        loadRequestAllowed = true
    }
    
    func AppResignActive() {
        println("received UIApplicationWillResignActiveNotification")
        loadRequestAllowed = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //GADBannerViewDelegate
    func adViewDidReceiveAd(view: GADBannerView!) {
        println("adViewDidReceiveAd:\(view)");
        bannerDisplayed = true
        relayoutViews()
    }
    
    func adView(view: GADBannerView!, didFailToReceiveAdWithError error: GADRequestError!) {
        println("\(view) error:\(error)")
        bannerDisplayed = false
        relayoutViews()
    }
    
    func adViewWillPresentScreen(adView: GADBannerView!) {
        println("adViewWillPresentScreen:\(adView)")
        bannerDisplayed = false
        relayoutViews()
    }
    
    func adViewWillLeaveApplication(adView: GADBannerView!) {
        println("adViewWillLeaveApplication:\(adView)")
        bannerDisplayed = false
        relayoutViews()
    }
    
    func adViewWillDismissScreen(adView: GADBannerView!) {
        println("adViewWillDismissScreen:\(adView)")
        bannerDisplayed = false
        relayoutViews()
    }
    
    func relayoutViews() {
        if (bannerDisplayed) {
            var bannerFrame = iAdSupported ? iAdView!.frame : bannerView!.frame
            bannerFrame.origin.x = 0
            bannerFrame.origin.y = statusbarHeight
            if iAdSupported {
                iAdView!.frame = bannerFrame
            } else {
                bannerView!.frame = bannerFrame
            }
            
            var imageviewFrame = imageView!.frame
            imageviewFrame.origin.x = 0
            imageviewFrame.origin.y = statusbarHeight + bannerFrame.size.height
            imageView!.frame = imageviewFrame
            
            //Admob Interstitial button
            if !iAdSupported {
                var buttonFrame = button!.frame
                buttonFrame.origin.y = 70
                button!.frame = buttonFrame
                
                buttonFrame = demoButton!.frame
                buttonFrame.origin.y = 95
                demoButton!.frame = buttonFrame
                
                buttonFrame = demoCoreDataButton!.frame
                buttonFrame.origin.y = 120
                demoCoreDataButton!.frame = buttonFrame
            }
        } else {
            var bannerFrame = iAdSupported ? iAdView!.frame : bannerView!.frame
            bannerFrame.origin.x = 0
            bannerFrame.origin.y = 0 - bannerFrame.size.height
            if iAdSupported {
                iAdView!.frame = bannerFrame
            } else {
                bannerView!.frame = bannerFrame
            }
            
            var imageviewFrame = imageView!.frame
            imageviewFrame.origin.x = 0
            imageviewFrame.origin.y = statusbarHeight
            imageView!.frame = imageviewFrame
            
            //Admob Interstitial button
            if !iAdSupported {
                var buttonFrame = button!.frame
                buttonFrame.origin.y = 20
                button!.frame = buttonFrame
                
                buttonFrame = demoButton!.frame
                buttonFrame.origin.y = 45
                demoButton!.frame = buttonFrame
                
                buttonFrame = demoCoreDataButton!.frame
                buttonFrame.origin.y = 70
                demoCoreDataButton!.frame = buttonFrame
            }
        }
    }
    
    //Interstitial func
    func createAndLoadInterstitial()->GADInterstitial {
        println("createAndLoadInterstitial")
        var interstitial = GADInterstitial()
        interstitial.delegate = self
        interstitial.adUnitID = "ca-app-pub-6938332798224330/6206234808"
        interstitial.loadRequest(GADRequest())
        
        return interstitial
    }
    
    func presentInterstitial(sender:UIButton!) {
        if let isReady = interstitial?.isReady {
            interstitial?.presentFromRootViewController(self)
        }
    }
    
    //Interstitial delegate
    func interstitial(ad: GADInterstitial!, didFailToReceiveAdWithError error: GADRequestError!) {
        println("interstitialDidFailToReceiveAdWithError:\(error.localizedDescription)")
        button?.enabled = false
        interstitial = createAndLoadInterstitial()
    }
    
    func interstitialDidReceiveAd(ad: GADInterstitial!) {
        println("interstitialDidReceiveAd")
        button?.enabled = true
    }
    
    func interstitialWillDismissScreen(ad: GADInterstitial!) {
        println("interstitialWillDismissScreen")
        button?.enabled = false
        interstitial = createAndLoadInterstitial()
    }
    
    func interstitialDidDismissScreen(ad: GADInterstitial!) {
        println("interstitialDidDismissScreen")
    }
    
    func interstitialWillLeaveApplication(ad: GADInterstitial!) {
        println("interstitialWillLeaveApplication")
    }
    
    func interstitialWillPresentScreen(ad: GADInterstitial!) {
        println("interstitialWillPresentScreen")
    }
    
    
    //iAd func
    func iAdTimeZoneSupported()->Bool {
        let iAdTimeZones = "America/;US/;Pacific/;Asia/Tokyo;Europe/".componentsSeparatedByString(";")
        var myTimeZone = NSTimeZone.localTimeZone().name
        for zone in iAdTimeZones {
            if (myTimeZone.hasPrefix(zone)) {
                return true;
            }
        }
        
        return false;
    }
    
    //iAdBannerViewDelegate
    func bannerViewWillLoadAd(banner: ADBannerView!) {
        println("bannerViewWillLoadAd")
    }
    
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        println("bannerViewDidLoadAd")
        bannerDisplayed = true
        relayoutViews()
    }
    
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        println("didFailToReceiveAd error:\(error)")
        bannerDisplayed = false
        relayoutViews()
    }
    
    func bannerViewActionDidFinish(banner: ADBannerView!) {
        println("bannerViewActionDidFinish")
        bannerDisplayed = false
        relayoutViews()
    }
    
    func bannerViewActionShouldBegin(banner: ADBannerView!, willLeaveApplication willLeave: Bool) -> Bool {
        println("bannerViewActionShouldBegin")
        return true;
    }
    
    //FMDB
    func showDemo(sender:UIButton!) {
        let demoVC = FMDBDemoViewController()
        let navVC = UINavigationController(rootViewController: demoVC)
        let backButton = UIBarButtonItem(title: "Close", style: .Plain, target: self, action: "back")
        demoVC.navigationItem.setLeftBarButtonItem(backButton, animated: true)
        
        self.presentViewController(navVC, animated: true, completion: nil)
    }
    
    func back() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //CoreData
    func showCoreDataDemo(sender:UIButton!) {
        let demoVC = CoreDataDemoViewController()
        let navVC = UINavigationController(rootViewController: demoVC)
        let backButton = UIBarButtonItem(title: "Close", style: .Plain, target: self, action: "back")
        demoVC.navigationItem.setLeftBarButtonItem(backButton, animated: true)
        
        self.presentViewController(navVC, animated: true, completion: nil)
    }
}

