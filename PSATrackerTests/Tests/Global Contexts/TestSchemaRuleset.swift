

import XCTest
@testable import PSATracker

class TestSchemaRuleset: XCTestCase {
    func testSchemaRules() {
        guard let twoPartVendor = SchemaRule(rule: "iglu:com.acme/*/jsonschema/*-*-*") else { return XCTFail() }

        // version and event wildcard
        XCTAssertTrue(twoPartVendor.match(withUri: "iglu:com.acme/event/jsonschema/1-0-0"))
        XCTAssertFalse(twoPartVendor.match(withUri: "iglu:com.snowplow/event/jsonschema/1-0-0"))
        let equalRule = SchemaRule(rule: "iglu:com.acme/*/jsonschema/*-*-*")
        XCTAssertEqual(twoPartVendor, equalRule)

        let threePartVendor = SchemaRule(rule: "iglu:com.acme.marketing/*/jsonschema/*-*-*")
        XCTAssertNotNil(threePartVendor)

        guard let validVendorWildcard = SchemaRule(rule: "iglu:com.acme.*/*/jsonschema/*-*-*") else { return XCTFail() }
        XCTAssertNotNil(validVendorWildcard)

        let invalidVendorWildcard = SchemaRule(rule: "iglu:com.acme.*.whoops/*/jsonschema/*-*-*")
        XCTAssertNil(invalidVendorWildcard)

        // vendor matching
        XCTAssertTrue(validVendorWildcard.match(withUri: "iglu:com.acme.marketing/event/jsonschema/1-0-0"))
        XCTAssertFalse(validVendorWildcard.match(withUri: "iglu:com.snowplow/event/jsonschema/1-0-0"))

        // vendor parts need to match in length, i.e. com.acme.* will not match com.acme.marketing.foo, only vendors of the form com.acme.x
        XCTAssertFalse(validVendorWildcard.match(withUri: "iglu:com.acme.marketing.foo/event/jsonschema/1-0-0"))
    }

    func testSchemaRuleset() {
        let acme = "iglu:com.acme.*/*/jsonschema/*-*-*"
        let snowplow = "iglu:com.snowplow.*/*/jsonschema/*-*-*"
        let snowplowTest = "iglu:com.snowplow.test/*/jsonschema/*-*-*"
        let ruleset = SchemaRuleset(allowedList: [acme, snowplow], andDeniedList: [snowplowTest])
        let allowed = [acme, snowplow]
        XCTAssertEqual(ruleset.allowed, allowed)
        let denied = [snowplowTest]
        XCTAssertEqual(ruleset.denied, denied)

        // matching
        XCTAssertTrue(ruleset.match(withUri: "iglu:com.acme.marketing/event/jsonschema/1-0-0"))
        XCTAssertTrue(ruleset.match(withUri: "iglu:com.snowplow.marketing/event/jsonschema/1-0-0"))
        XCTAssertFalse(ruleset.match(withUri: "iglu:com.snowplow.test/event/jsonschema/1-0-0"))
        XCTAssertFalse(ruleset.match(withUri: "iglu:com.brand/event/jsonschema/1-0-0"))
    }

    func testSchemaRulesetOnlyDenied() {
        let snowplowTest = "iglu:com.snowplow.test/*/jsonschema/*-*-*"
        let ruleset = SchemaRuleset(deniedList: [snowplowTest])
        let allowed: [String]? = []
        XCTAssertEqual(ruleset.allowed, allowed)
        let denied = [snowplowTest]
        XCTAssertEqual(ruleset.denied, denied)

        // matching
        XCTAssertTrue(ruleset.match(withUri: "iglu:com.acme.marketing/event/jsonschema/1-0-0"))
        XCTAssertTrue(ruleset.match(withUri: "iglu:com.snowplow.marketing/event/jsonschema/1-0-0"))
        XCTAssertFalse(ruleset.match(withUri: "iglu:com.snowplow.test/event/jsonschema/1-0-0"))
        XCTAssertTrue(ruleset.match(withUri: "iglu:com.brand/event/jsonschema/1-0-0"))
    }

    func testSchemaRulesetOnlyAllowed() {
        let acme = "iglu:com.acme.*/*/jsonschema/*-*-*"
        let snowplow = "iglu:com.snowplow.*/*/jsonschema/*-*-*"
        let ruleset = SchemaRuleset(allowedList: [acme, snowplow])
        let allowed = [acme, snowplow]
        XCTAssertEqual(ruleset.allowed, allowed)
        let denied: [String]? = []
        XCTAssertEqual(ruleset.denied, denied)

        // matching
        XCTAssertTrue(ruleset.match(withUri: "iglu:com.acme.marketing/event/jsonschema/1-0-0"))
        XCTAssertTrue(ruleset.match(withUri: "iglu:com.snowplow.marketing/event/jsonschema/1-0-0"))
        XCTAssertTrue(ruleset.match(withUri: "iglu:com.snowplow.test/event/jsonschema/1-0-0"))
        XCTAssertFalse(ruleset.match(withUri: "iglu:com.brand/event/jsonschema/1-0-0"))
    }
}
