import UIKit
import RxSwift
import RxCocoa

//let observable = Observable.just(1)
//
//let observable2 = Observable.of(1,2,3)
//
//let observable3 = Observable.of([1,2,3])
//
//let observable4 = Observable.from([1,2,3,4,5])
//
//observable4.subscribe { event in
//    if let element = event.element {
//        print(element)
//    }
//}
//
//observable3.subscribe { event in
//    if let element = event.element {
//        print(element)
//    }
//}
//
//let subscription4 = observable4.subscribe(onNext: { (element) in
//    print(element)
//})
//
//subscription4.dispose()

let disposeBag = DisposeBag()

//Observable.of("A", "B", "C").subscribe({ print($0) }).disposed(by: disposeBag)
//
//Observable.of("A", "B", "C").subscribe(onNext: ({ print($0) })).disposed(by: disposeBag)
//
//Observable<String>.create { (observer) -> Disposable in
//
//    observer.onNext("A")
//    observer.onCompleted()
//    observer.onNext("?")
//    return Disposables.create()
//
//}.subscribe(onNext: { print($0) }, onError: { print($0) }, onCompleted: { print("completed") }, onDisposed: { print("disposed") }).disposed(by: disposeBag)


// Publish subject
//let subject = PublishSubject<String>()
//
//subject.onNext("Issue 1")
//
//subject.subscribe({ event in
//    print(event)
//})
//
//subject.onNext("Issue 2")
//subject.onNext("Issue 3")
//subject.dispose()
//subject.onNext("Issue 4")

// Behaviour subject

//let subject = BehaviorSubject(value: "initial value")
//
//subject.onNext("Last issue")
//
//subject.subscribe({ event in
//    print(event)
//})

// subject.onNext("Issue 1")

//Replay subject

//let subject = ReplaySubject<String>.create(bufferSize: 2)
//
//subject.onNext("Issue 1")
//subject.onNext("Issue 2")
//subject.onNext("Issue 3")
//
//subject.subscribe({
//    print($0)
//})
//
//subject.onNext("Issue 4")
//subject.onNext("Issue 5")
//subject.onNext("Issue 6")
//
//print("****")
//
//subject.subscribe({ print($0) })


// Variables
//let relay = BehaviorRelay(value: ["item 1"])
//
//var value = relay.value
//value.append("item 2")
//value.append("item 3")
//
//relay.accept(value)
//
//relay.asObservable()
//    .subscribe {
//    print($0)
//}



// Ignore elements

let strikes = PublishSubject<String>()

//strikes.ignoreElements().subscribe({ elements in
//    print("[Subscription is called]")
//    print("elements: \(elements)")
//}).disposed(by: disposeBag)
//
//strikes.onNext("A")
//strikes.onNext("B")
//strikes.onNext("C")
//
//strikes.onCompleted()

//strikes.elementAt(2)
//    .subscribe(onNext: { element in
//        print("you are out!")
//        print(element)
//    }).disposed(by: disposeBag)
//
//strikes.onNext("X")
//strikes.onNext("Y")
//strikes.onNext("Z")

//Observable.of(1,2,3,4,5,6,7)
//    .filter({ $0 % 2 == 0 })
//    .subscribe(onNext: {
//        print($0)
//    }).disposed(by: disposeBag)

//Observable.of("A", "B", "C", "D", "E")
//    .skip(3)
//    .subscribe(onNext: {
//        print($0)
//    }).disposed(by: disposeBag)

//Observable.of(2,2,3,4,4)
//    .skipWhile({ $0 % 2 == 0 })
//    .subscribe(onNext: {
//        print($0)
//    }).disposed(by: disposeBag)

//let subject = PublishSubject<String>()
//let trigger = PublishSubject<String>()
//
//subject.skipUntil(trigger)
//    .subscribe(onNext: {
//        print($0)
//    }).disposed(by: disposeBag)
//
//subject.onNext("A")
//subject.onNext("B")
//trigger.onNext("X")
//subject.onNext("C")

//Observable.of(1,2,3,4,5,6)
//    .take(3)
//    .subscribe(onNext: {
//        print($0)
//    }).disposed(by: disposeBag)

//Observable.of(2,4,6,7,8,10)
//    .takeWhile({ $0 % 2 == 0 })
//    .subscribe(onNext: {
//        print($0)
//    }).disposed(by: disposeBag)

//let subject = PublishSubject<String>()
//let trigger = PublishSubject<String>()
//
//subject.takeUntil(trigger)
//    .subscribe(onNext: {
//        print($0)
//    }).disposed(by: disposeBag)
//
//subject.onNext("1")
//subject.onNext("2")
//trigger.onNext("X")
//subject.onNext("3")

//Observable.of(1,2,3,4,5)
//    .toArray()
//    .subscribe({
//        print($0)
//    }).disposed(by: disposeBag)

//Observable.of(1,2,3,4,5)
//    .map {
//        return $0 * 2
//    }.subscribe(onNext: {
//        print($0)
//    }).disposed(by: disposeBag)

//struct Student {
//    var score: BehaviorRelay<Int>
//}
//
//var john = Student(score: BehaviorRelay.init(value: 75))
//var mary = Student(score: BehaviorRelay.init(value: 95))
//
//let student = PublishSubject<Student>()
//
//student.asObservable()
//    .flatMapLatest { $0.score.asObservable() }
//    .subscribe(onNext: {
//        print($0)
//    }).disposed(by: disposeBag)
//
//student.onNext(john)
//john.score.accept(100)
//student.onNext(mary)
//john.score.accept(40)

//let numbers = Observable.of(2,3,4)
//let observable = numbers.startWith(1)
//observable.subscribe(onNext: {
//    print($0)
//}).disposed(by: disposeBag)

//let first = Observable.of(1,2,3)
//let second = Observable.of(4,5,6)
//let observable = Observable.concat([first, second])
//observable.subscribe(onNext: {
//    print($0)
//}).disposed(by: disposeBag)

//let left = PublishSubject<Int>()
//let right = PublishSubject<Int>()
//let source = Observable.of(left.asObservable(), right.asObservable())
//let observable = source.merge()
//observable.subscribe(onNext: {
//    print($0)
//}).disposed(by: disposeBag)
//left.onNext(5)
//left.onNext(3)
//right.onNext(2)
//right.onNext(1)
//left.onNext(99)

//let left = PublishSubject<Int>()
//let right = PublishSubject<Int>()
//let observable = Observable.combineLatest(left, right) { lastLeft, lastRight in
//    "\(lastLeft) \(lastRight)"
//}
//
//let disposable = observable.subscribe(onNext: {
//    print($0)
//})
//
//left.onNext(45)
//right.onNext(1)
//left.onNext(30)
//right.onNext(3)
//right.onNext(2)

//let button = PublishSubject<String>()
//let textField = PublishSubject<String>()
//let observable = button.withLatestFrom(textField)
//let disposable = observable.subscribe(onNext: {
//    print($0)
//})
//
//textField.onNext("Sw")
//textField.onNext("Swif")
//textField.onNext("Swift")

//let source = Observable.of(1,2,3)
//source.reduce(0, accumulator: +)
//    .subscribe(onNext: {
//        print($0)
//    }).disposed(by: disposeBag)

//let source = Observable.of(1,2,3,4,5,6)
//source.scan(0, accumulator: +)
//    .subscribe(onNext: {
//        print($0)
//    }).disposed(by: disposeBag)
