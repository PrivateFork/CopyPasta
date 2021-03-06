//
// Created by Viktor Belenyesi on 11/26/15.
// Copyright (c) 2015 Viktor Belenyesi. All rights reserved.
//

@testable import VinceRP

import Quick
import Nimble

class HubOperatorsSpec: QuickSpec {
    
    override func spec() {
        
        it("should negate") {
            // given
            let x = reactive(true)
            
            // when
            expect(x.value()) == true
            
            // then
            expect(x.not()*) == false
        }
        
        it("can skip errors") {
            // given
            let x = reactive(1)
            let y = definedAs { x* + 1 }.skipErrors()
            var count = 0
            onErrorDo(y) {  _ in
                count++
            }
            
            // when
            x <- fakeError
            
            // then
            expect(count) == 0
        }
        
        it("works with foreach") {
            // given
            let x = reactive(1)
            var history = [Int]()
            
            // when
            x.foreach {
                history.append(2 * $0)
            }
            
            // then
            expect(history).toEventually(equal([2]))

            // when
            x <- 2
            
            // then
            expect(history).toEventually(equal([2, 4]))
        }

        
    }
    
}
