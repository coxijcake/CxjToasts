//
//  CxjToastDismisser+ByTimeUseCase.swift
//
//
//  Created by Nikita Begletskiy on 29/08/2024.
//

import Foundation

extension CxjToastDismisser {
	@MainActor
	final class DimissByTimeUseCase {
		//MARK: - Props
		private let timerUpdateInterval: TimeInterval = 0.1
		
		private let displayingTime: TimeInterval
		private var remainingTime: TimeInterval
		
		private weak var delegate: ToastDismissUseCaseDelegate?
		
		private var dismissTimer: Timer?
		private var pausedTime: TimeInterval?
		
		//MARK: - Lifecycle
		init(
			displayingTime: TimeInterval,
			delegate: ToastDismissUseCaseDelegate?
		) {
			self.displayingTime = displayingTime
			self.remainingTime = displayingTime
			self.delegate = delegate
			
			delegate?.didUpdateRemainingDisplayingTime(
				displayingTime,
				initialDisplayingTime: displayingTime,
				by: self
			)
		}
	}
}

//MARK: - ToastDismissUseCase
extension CxjToastDismisser.DimissByTimeUseCase: ToastDismissUseCase {
	var dismissMethod: ToastDimissMethod {
		.time
	}
	
	func setupState(_ state: ToastDismisserState) {
		switch state {
		case .active: activate()
		case .inActive: deactivate()
		case .paused: pause()
		}
	}
}

//MARK: - Private
private extension CxjToastDismisser.DimissByTimeUseCase {
	func activate() {
		start()
	}
	
	func deactivate() {
		pausedTime = nil
		remainingTime = displayingTime
		removeTimer()
	}
	
	func pause() {
		pausedTime = dismissTimer?.fireDate.timeIntervalSinceNow
		removeTimer()
	}
	
	func start() {
		if let pausedTime {
			setupTimer(for: pausedTime)
		} else {
			setupTimer(for: displayingTime)
		}
	}
	
	func setupTimer(
		for time: TimeInterval
	) {
		removeTimer()
		
		let timer = Timer(timeInterval: timerUpdateInterval, repeats: true) { [weak self] timer in
			guard let self else { return }
			
			Task { @MainActor [weak self] in
				guard let self = self else { return }
				
				self.remainingTime = max(.zero, self.remainingTime - self.timerUpdateInterval)
				self.delegate?.didUpdateRemainingDisplayingTime(self.remainingTime, initialDisplayingTime: displayingTime, by: self)
				
				if self.remainingTime <= 0 {
					self.delegate?.didFinish(useCase: self)
				}
			}
		}
		
		RunLoop.current.add(timer, forMode: .common)
		dismissTimer = timer
	}
	
	func removeTimer() {
		dismissTimer?.invalidate()
		dismissTimer = nil
	}
}
