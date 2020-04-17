//
//  RepositoriesViewModelSpec.swift
//  GitReposTests
//
//  Created by Victor Magpali on 17/04/20.
//  Copyright © 2020 Victor Magpali. All rights reserved.
//

@testable import GitRepos
import Nimble
import Quick
import UIKit
import OHHTTPStubs
import RxSwift
import RxCocoa

class RepositoriesViewModelSpec: QuickSpec {
    override func spec() {
        
        var sut: RepositoriesViewModel!
        
        var disposable: Disposable?
        
        describe("RepositoriesViewModel") {
            beforeEach {
                sut = RepositoriesViewModel()
                
                stub(condition: isHost("api.github.com")) { _ in
                    let stubPath = OHPathForFile("RepositorySearchResultStub.json", type(of: self))
                    return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
                }
            }
            
            it("has requested repos") {
                sut.refreshSearch()
                waitUntil { done in
                    disposable = sut.repositoryViewModels.skip(1).subscribe(onNext: { (viewModels) in
                        expect(viewModels.first?.repoNameObservable.value) == "awesome-ios"
                        done()
                    })
                }
            }
            
            it("has requested next page") {
                sut.refreshSearch()
                var currentCycle = 0
                waitUntil { done in
                    disposable = sut.repositoryViewModels.skip(1).subscribe(onNext: { viewModels in
                        sut.currentRow.accept(7)
                        if currentCycle > 0 {
                            currentCycle = 0
                            expect(sut.repositoryViewModels.value.count) == 20
                            done()
                        }
                        currentCycle += 1
                    })
                }
            }
            
            afterEach {
                disposable?.dispose()
            }
        }
    }
}

