//
//  AppDelegateTests.swift
//  LuxFocusReduxTests
//
//  Created by Brian Dorn on 5/17/19.
//  Copyright © 2019 Brian Dorn. All rights reserved.
//

import XCTest
@testable import LuxFocusRedux

class AppDelegateTests: XCTestCase {

    var appDelegate: AppDelegate

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        appDelegate.normalizeIntensityValue()
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

svc-cqms-stage-web
#      -DoneLogin.user.username=
#      -DoneLogin.user.password=$ONELOGIN_PASSWORD

docker-build/docker-mvn.sh \
--docker-image containers.rmn.io/retailmenot/cqms-dockerbuild \
--mvn-executable cqms-mvn.sh \
clean deploy -B -DskipTests

docker-build/docker-mvn.sh \
--docker-image containers.rmn.io/retailmenot/cqms-dockerbuild \
--mvn-executable cqms-mvn.sh \
compile test-compile exec:java -B \
-pl ui-webtests \
-U -P gridTestsMain \
-DrunType=GRID \
-DuploadScreenshots=true \
-DtestProjectName=CQMS \
-DhibernatePath=src/main/resources/hibernateMappings/ \
-DenvironmentType=%system.environmentType% \
-DincludedGroups=%system.groups% \
-DexcludedGroups=local,legacy,prod_safe \
"-DtestPlanName=%system.testPlan%" \
-DbrowserType='%system.browserType%' \
-Dspring.profiles.active=tclegacy \
-DthreadCount='%system.threadCount%' \
-DoneLogin.user.enabled='%system.oneLogin.user.enabled%' \
-DoneLogin.user.username='%system.oneLogin.user.username%' \
-DoneLogin.user.password='%system.oneLogin.user.password%'

docker-build/build.sh clean deploy -B -P dockerBuild -DskipTests %teamCityMavenArgs%

# then run just api tests
docker-build/build.sh test -B \
-pl api-endpoints-tests \
-U -P ApiEndpointsTests \
-DtestProjectName=CQMS \
-DhibernatePath=src/main/resources/hibernateMappings/ \
-DuseLocalRun=true \
-DrunEmbeddedJar \
-DenvironmentType=local \
-DenableTestHelperCleanup=false \
-DautomationHostName='%system.automationHostName%' \
-Dcqms.home='/var/lib/wsm/cqms-apitests' \
%teamCityMavenArgs%


variables:
MAVEN_GOAL_SETS: "versions:set; clean install -DskipTests; test ${MAVEN_EXTRA_ARGS}"
MAVEN_EXTRA_ARGS: >-
-B
-pl api-endpoints-tests
-U
-P ApiEndpointsTests
-DtestProjectName=CQMS
-DhibernatePath=src/main/resources/hibernateMappings/
-DuseLocalRun=true
-DrunEmbeddedJar
-DenvironmentType=local
-DenableTestHelperCleanup=false
-DautomationHostName=localhost
-Dcqms.home='/var/lib/wsm/cqms-apitests'

QmVhcmVyIDZ0azlmcG5tZm1teXo1MmtxajllZmdrNTNq
