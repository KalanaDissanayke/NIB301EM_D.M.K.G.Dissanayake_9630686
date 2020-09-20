//
//  PageControlViewController.swift
//  D.M.K.G.Dissanayake-COBSCCOMP191P-007
//
//  Created by Kalana Dissanayake on 9/20/20.
//  Copyright © 2020 Kalana Dissanyake. All rights reserved.
//

import UIKit

class PageControlViewController: UIViewController, UIScrollViewDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrImages = [UIImage(named: "Covid 1"), UIImage(named: "Covid 2"), UIImage(named: "Covid 3"), UIImage(named: "Covid 4"), UIImage(named: "Covid 5")] as! [UIImage]

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var arrImages : [UIImage] = []
    var arrLabelTitle : [UILabel] = []
    
    @IBAction func backItem(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLayoutSubviews() {
         self.loadScrollView()
     }
    
     func loadScrollView() {
         let pageCount = arrImages.count
         scrollView.frame = view.bounds
         scrollView.delegate = self
         scrollView.backgroundColor = UIColor.clear
         scrollView.isPagingEnabled = true
         scrollView.showsHorizontalScrollIndicator = true
         scrollView.showsVerticalScrollIndicator = false
         
         pageControl.numberOfPages = pageCount
         pageControl.currentPage = 0
         
         for i in (0..<pageCount) {
             
             let imageView = UIImageView()
             imageView.frame = CGRect(x: i * Int(self.view.frame.size.width) , y: 180 , width:
                 Int(self.view.frame.size.width) , height: 500)
             
             imageView.image = arrImages[i]
             self.scrollView.addSubview(imageView)
         }
         
         let width1 = (Float(arrImages.count) * Float(self.view.frame.size.width))
         scrollView.contentSize = CGSize(width: CGFloat(width1), height: self.view.frame.size.height)
         
         self.view.addSubview(scrollView)
         self.pageControl.addTarget(self, action: #selector(self.pageChanged(sender:)), for: UIControl.Event.valueChanged)

         self.view.addSubview(pageControl)
     }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
        print(pageNumber)
        
    }
    
    @objc func pageChanged(sender:AnyObject)
    {
        let xVal = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x: xVal, y: 0), animated: true)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
}
