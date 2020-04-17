//
//  RepositoryTableViewCellSpec.swift
//  GitReposUITests
//
//  Created by Victor Magpali on 17/04/20.
//  Copyright © 2020 Victor Magpali. All rights reserved.
//

@testable import GitRepos
import Nimble
import Nimble_Snapshots
import Quick
import UIKit

class RepositoryTableViewCellSpec: QuickSpec {
    override func spec() {
        
        var sut: RepositoryTableViewCell!
        
        describe("RepositoryTableViewCell") {
            beforeEach {
                sut = RepositoryTableViewCell()
                sut.setViews(with: RepositoryCellViewModelMock())
                sut.frame = CGRect(x: 0, y: 0, width: 350, height: 120)
            }
            
            it("has valid snapshot") {
                expect(sut) == snapshot("RepositoryTableViewCell")
            }
        }
    }
}


