#!/bin/bash
set -e

script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "${script_dir}/.."

mkdir -p tmp
mkdir -p tmp/icons

if [ -f "tmp/en.xml" ]; then
    echo "Using existing tmp/en.xml; delete to re-download current off main."
else
    # This just takes main rather than the released version
    # Probably fine; switch to official releases in the future if needed
    curl -so tmp/en.xml https://raw.githubusercontent.com/unicode-org/cldr/refs/heads/main/common/annotations/en.xml
fi

echo "Processing en.xml"
python3 cldr-xml-to-json.py

echo "Generating icons"
swift generate-icons.swift
