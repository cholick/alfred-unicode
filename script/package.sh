#!/bin/bash
set -e

script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "${script_dir}/.."

python3 cldr-xml-to-json.py

mkdir -p /tmp/alfred-unicode

cp workflow/icon.png /tmp/alfred-unicode
cp workflow/info.plist /tmp/alfred-unicode
cp tmp/cldr.json  /tmp/alfred-unicode
cp -r tmp/icons /tmp/alfred-unicode/icons

version=$(cat workflow/version)
sed -i '' "s/VERSION_PLACEHOLDER/$version/g" /tmp/alfred-unicode/info.plist

cd /tmp/alfred-unicode

zip -r archive.zip *

cd "${script_dir}"/..
mv /tmp/alfred-unicode/archive.zip unicode.alfredworkflow
