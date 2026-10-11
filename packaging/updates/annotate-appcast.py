#!/usr/bin/env python3
"""Add the iPhone app version a release needs (squadbots:minApp) to its Sparkle appcast item.

The Mac app reads it from the item before installing (docs/reference/compatibility.md).
The feed itself isn't signed; Sparkle signs the archive, so editing the XML is safe.
"""
import sys
import xml.etree.ElementTree as ET

SPARKLE = "http://www.andymatuschak.org/xml-namespaces/sparkle"
SQUADBOTS = "https://squadbots.ai/xml-namespaces/appcast"


def main():
    feed, min_app = sys.argv[1:]
    ET.register_namespace("sparkle", SPARKLE)
    ET.register_namespace("dc", "http://purl.org/dc/elements/1.1/")
    ET.register_namespace("squadbots", SQUADBOTS)
    tree = ET.parse(feed)
    items = tree.getroot().findall("./channel/item")
    assert len(items) == 1, "expected one current release"
    element = ET.SubElement(items[0], f"{{{SQUADBOTS}}}minApp")
    element.text = min_app
    tree.write(feed, xml_declaration=True, encoding="utf-8")


if __name__ == "__main__":
    main()
