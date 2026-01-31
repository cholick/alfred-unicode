# alfred-unicode

This workflow searches through the unicode character set (including emoji) using the Unicode Common Locale Data Repository. This repository has a set of tags and for the characters to ease finding them.

For example, the 🎉 has the text-to-speech name of "party popper" and the tags "ball", "celebrate", "celebration", "confetti", "party" and "woohoo". Any of these things will trigger a match.

In a different plugin I used Levenshtein distance, but the annotations from CLDR a decent enough that just feeding that full set into Alfred's results filter keeps things simple (and really fast since I can rely on Alfred's caching rather than re-running the script every keystroke). It does mean that you have to spell something like `ellipsis` correct, though, and won't get proper results if you type `eli`.

<img src="/docs/screenshot.png" width="600">

### Installation
Download the newest version via [the latest release](https://github.com/cholick/alfred-unicode/releases/latest)

### Why?

There are a few of these that exist, but I didn't quite like how any of them worked. Mostly I'm tired of Googling
to get ‽ and ✔, a couple characters that I like to use often.

### Notes

* Unicode Common Locale Data Repository
    * https://cldr.unicode.org/
    * https://github.com/unicode-org/cldr/
