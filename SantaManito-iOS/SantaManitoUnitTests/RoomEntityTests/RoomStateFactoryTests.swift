////
////  RoomStateFactoryTests.swift
////  SantaManitoUnitTests
////
////  Created by 장석우 on 10/14/24.
////
//
//import XCTest
//@testable import SantaManito_iOS
//
//final class RoomStateFactoryTests: XCTestCase {
//    
//    let sut = RoomStateFactory.self
//
//    override func setUp()  {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDown() {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//    
//    func test_매칭_전_방장이_삭제한_경우_상태가_삭제됨으로_변경되는지() {
//        // Given
//        let dto = RoomDetailResponse(id: "", roomName: "", invitationCode: "",
//                                      expirationDate: Date().addingTimeInterval(-3),
//                                      matchingDate: nil,
//                                      deletedByCreatorDate: Date().addingTimeInterval(-1),
//                                      creator: .init(id: "", username: ""), missions: [], members: [])
//        
//        // When
//        let state = sut.create(dto)
//        
//        // Then
//        XCTAssertEqual(state, .deleted)
//    }
//    
//    func test_매칭_이후_방장이_삭제한_경우_상태가_삭제됨으로_변경되는지() {
//        // Given
//        let dto = RoomDetailResponse(id: "", roomName: "", invitationCode: "",
//                                      expirationDate: Date().addingTimeInterval(-3),
//                                      matchingDate: Date().addingTimeInterval(-2),
//                                      deletedByCreatorDate: Date().addingTimeInterval(-1),
//                                      creator: .init(id: "", username: ""), missions: [], members: [])
//        
//        // When
//        let state = sut.create(dto)
//        
//        // Then
//        XCTAssertEqual(state, .deleted)
//    }
//    
//    func test_매칭_잔_만료일이_지난_경우_상태가_완료됨으로_변경되는지() {
//        // Given
//        let dto = RoomDetailResponse(id: "", roomName: "", invitationCode: "",
//                                      expirationDate: Date().addingTimeInterval(-3),
//                                      matchingDate: nil,
//                                      deletedByCreatorDate: nil,
//                                      creator: .init(id: "", username: ""), missions: [], members: [])
//        
//        // When
//        let state = sut.create(dto)
//        
//        // Then
//        XCTAssertEqual(state, .completed)
//    }
//    
//    func test_매칭_후_만료일이_지난_경우_상태가_완료됨으로_변경되는지() {
//        // Given
//        let dto = RoomDetailResponse(id: "", roomName: "", invitationCode: "",
//                                      expirationDate: Date().addingTimeInterval(-3),
//                                      matchingDate: Date().addingTimeInterval(-2),
//                                      deletedByCreatorDate: nil,
//                                      creator: .init(id: "", username: ""), missions: [], members: [])
//        
//        // When
//        let state = sut.create(dto)
//        
//        // Then
//        XCTAssertEqual(state, .completed)
//    }
//    
//    
//    func test_매칭_전_만료일이_지난_경우_상태가_완료됨으로_변경되는지() {
//        // Given
//        let dto = RoomDetailResponse(id: "", roomName: "", invitationCode: "",
//                                      expirationDate: Date().addingTimeInterval(-3),
//                                      matchingDate: nil,
//                                      deletedByCreatorDate: nil,
//                                      creator: .init(id: "", username: ""), missions: [], members: [])
//        
//        // When
//        let state = sut.create(dto)
//        
//        // Then
//        XCTAssertEqual(state, .completed)
//    }
//    
//    func test_만료일이_남은_경우_매칭_전이면_상태가_시작전으로_변경되는지() {
//        // Given
//        let dto = RoomDetailResponse(id: "", roomName: "", invitationCode: "",
//                                      expirationDate: Date().addingTimeInterval(+3),
//                                      matchingDate: nil,
//                                      deletedByCreatorDate: nil,
//                                      creator: .init(id: "", username: ""), missions: [], members: [])
//        
//        // When
//        let state = sut.create(dto)
//        
//        // Then
//        XCTAssertEqual(state, .notStarted)
//    }
//    
//    
//    func test_만료일이_남은_경우_매칭_후면_상태가_진행_중으로_변경되는지() {
//        // Given
//        let dto = RoomDetailResponse(id: "", roomName: "", invitationCode: "",
//                                      expirationDate: Date().addingTimeInterval(+3),
//                                     matchingDate: Date().addingTimeInterval(-1),
//                                      deletedByCreatorDate: nil,
//                                      creator: .init(id: "", username: ""), missions: [], members: [])
//        
//        // When
//        let state = sut.create(dto)
//        
//        // Then
//        XCTAssertEqual(state, .inProgress)
//    }
//    
//    
//    
//    
//    
//
//
//}
