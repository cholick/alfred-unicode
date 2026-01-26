import json
import os

from xml.etree import ElementTree

# A list of terms that I wouldn't use and get in the way of a better result hit
TERMS_TO_REMOVE = [
    'interpunct', # messes with interrobang
]

def build_data():
    os.chdir("tmp")

    tree = ElementTree.parse('en.xml')
    root = tree.getroot()
    
    # Pull out all the text-to-speech values first to use as the name
    tts_names = {}
    for entry in root.findall('annotations/annotation'):
        if entry.get('type') != 'tts':
            continue

        tts_names[entry.get('cp')] = entry.text
    
    alfred_items = []
    
    for entry in root.findall('annotations/annotation'):
        if entry.get('type') == 'tts':
            continue

        char = entry.get('cp')
        annotation = entry.text

        terms = annotation.split(" | ")
        terms = [t for t in terms if t not in TERMS_TO_REMOVE]

        keyword = ' '.join(terms)
        subtitle = ', '.join(terms)
        
        # Fail if missing in tts map, should have complete mapping
        if char not in tts_names:
            print(f"Missing tts for {char}")
            exit(1)
        tts_name = tts_names.get(char)
        
        icon_path = f"icons/{tts_name.replace(' ', '-')}.png"

        alfred_items.append({
            "title": tts_name.title(),
            "subtitle": subtitle,
            "arg": char,
            "match": f"{tts_name} {keyword}",
            "icon": {"path": icon_path}
        })

    with open('cldr.json', 'w', encoding='utf-8') as f:
        json.dump({"items": alfred_items}, f, ensure_ascii=False)

if __name__ == "__main__":
    build_data()
