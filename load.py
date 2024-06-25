import os.path
import fs
import json
import shutil
import os
str = open("sources.json","r")
jsn = json.load(str)

os.system('rm -rf src/main/haxe')

root = jsn['root']

for prj in jsn["directories"]:
    shutil.copytree(f'{root}/{prj}/src/main/haxe/','src/main/haxe/',dirs_exist_ok=True)
for prj in jsn["directories"]:
    shutil.copytree(f'{root}/{prj}/src/test/haxe/','src/test/haxe/',dirs_exist_ok=True)
