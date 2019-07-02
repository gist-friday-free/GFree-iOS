//
//  RxExtensions.swift
//  GFree
//
//  Created by 문명주 on 03/07/2019.
//  Copyright © 2019 MJ Studio. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


infix operator <->

extension ObservableType {
	func currentAndPrevious() -> Observable<(current: E, previous: E)> {
		return self.multicast({ () -> PublishSubject<E> in PublishSubject<E>() }) { (values: Observable<E>) -> Observable<(current: E, previous: E)> in
			let pastValues = Observable.merge(values.take(1), values)
			
			return Observable.combineLatest(values.asObservable(), pastValues) { (current, previous) in
				return (current: current, previous: previous)
			}
		}
	}
}

func <-> <T: Equatable>(lhs: BehaviorRelay<T>, rhs: BehaviorRelay<T>) -> Disposable {
	typealias ItemType = (current: T, previous: T)
	
	return Observable.combineLatest(lhs.currentAndPrevious(), rhs.currentAndPrevious())
		.filter({ (first: ItemType, second: ItemType) -> Bool in
			return first.current != second.current
		})
		.subscribe(onNext: { (first: ItemType, second: ItemType) in
			if first.current != first.previous {
				rhs.accept(first.current)
			}
			else if (second.current != second.previous) {
				lhs.accept(second.current)
			}
		})
}

func <-> <T>(property: ControlProperty<T>, relay: BehaviorRelay<T>) -> Disposable {
	let bindToUIDisposable = relay.bind(to: property)
	let bindToRelay = property
		.subscribe(onNext: { n in
			relay.accept(n)
		}, onCompleted:  {
			bindToUIDisposable.dispose()
		})
	
	return Disposables.create(bindToUIDisposable, bindToRelay)
}
