//
//  ViewController.swift
//  InfiniteScrollView
//
//  Created by 김삼현 on 13/01/2019.
//  Copyright © 2019 김삼현. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet var scrollView :InfiniteScrollView!
	
	// ScrollScreen의 폭
	var scrollScreenWidth:CGFloat!
	// ScrollScreen의 높이
	var scrollScreenHeight:CGFloat!

	let img:[String] = ["yoga_0.jpg","yoga_1.jpg","yoga_2.jpg","yoga_3.jpg","yoga_4.jpg"]
	// Total 페이지 수
	var pageNum:Int!
	
	var imageWidth:CGFloat!
	var imageHeight:CGFloat!
	var screenSize:CGRect!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		screenSize = UIScreen.main.bounds
		
		// 페이지 스 크 롤과하기 위해 페이지 폭을 맞추기
		scrollScreenWidth = screenSize.width
		
		// 스크롤뷰 초기화
		for imgView in scrollView.subviews {
			imgView.removeFromSuperview()
		}
		
		let imageTop:UIImage = UIImage(named:img[0])!
		pageNum = img.count
		
		imageWidth = imageTop.size.width
		imageHeight = imageTop.size.height
		scrollScreenHeight = scrollScreenWidth * imageHeight / imageWidth
		
		for i in 0 ..< pageNum {
			// UIImageView의 인스턴스
			let image:UIImage = UIImage(named:img[i])!
			let imageView = UIImageView(image:image)
			
			var rect:CGRect = imageView.frame
			rect.origin.y = (scrollView.bounds.height - scrollScreenHeight) / 2
			
			rect.size.height = scrollScreenHeight
			rect.size.width = scrollScreenWidth
			
			imageView.frame = rect
			
			// 스크롤뷰에 새로 추가
			scrollView.addScrollSubview(imageView)
		}
		
		// 서브셀 위치 재설정
		scrollView.reposSubCell()
		
		// 센터 페이지 이동 시킨다.
		self.scrollView.goCenterPageMove()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

extension ViewController: UIScrollViewDelegate {
	
	// 스크롤 뷰에서 내용 스크롤을 시작할 시점을 대리인에게 알립니다.
	
	func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		print("scrollViewWillBeginDragging:")
		
	}
	
	// 2. 스크롤뷰가 스크롤 된 후에 실행된다.
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		
		// 무한스크롤뷰 일때
		if scrollView is InfiniteScrollView {
			let tabIndex:CGFloat = scrollView.contentOffset.x / self.view.bounds.width
			print("scrollViewDidScroll: = \(tabIndex)")
			
			let infiniteScroll: InfiniteScrollView = scrollView as! InfiniteScrollView
			
			// Prev Move
			if tabIndex <= 1.0 {
				infiniteScroll.goPrevPage()
			}
				// Next Move
			else if tabIndex >= 3.0 {
				infiniteScroll.goNextPage()
			}
		}
	}
	
	// 드래그가 스크롤 뷰에서 끝났을 때 대리자에게 알립니다.
	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		print("scrollViewDidEndDragging:willDecelerate:")
		
	}
	
	// (현재 못씀)
	func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
		print("scrollViewDidEndScrollingAnimation")
		
	}
	
	// 스크롤뷰가 Touch-up 이벤트를 받아 스크롤 속도가 줄어들때 실행된다.
	func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
		print("scrollViewWillBeginDecelerating")
		
	}
	
	// 스크롤 애니메이션의 감속 효과가 종료된 후에 실행된다.
	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		
	}
	
	// scrollView.scrollsToTop = YES 설정이 되어 있어야 아래 이벤트를 받을수 있다.
	// 스크롤뷰가 가장 위쪽으로 스크롤 되기 전에 실행된다. NO를 리턴할 경우 위쪽으로 스크롤되지 않도록 한다.
	//- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
	//{
	//    NSLog(@"scrollViewShouldScrollToTop");
	//    return YES;
	//}
	
	// 스크롤뷰가 가장 위쪽으로 스크롤 된 후에 실행된다.
	//- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
	//{
	//    NSLog(@"scrollViewDidScrollToTop");
	//}
	
	// 사용자가 콘텐츠 스크롤을 마쳤을 때 대리인에게 알립니다.
	func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
		print("scrollViewWillEndDragging:withVelocity:targetContentOffset:")
		
	}
}

