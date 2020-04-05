import json
from collections import OrderedDict


with open('city.list.json', 'r') as jsfile:
    mydict = json.load(jsfile)
mylist = []

for distro in mydict:
    mylist.append(distro['name'])

mylist.sort()
mylist = list(dict.fromkeys(mylist))

with open('mynewfancylist.txt', 'w') as myfile:
    for i in mylist:
        myfile.write(i+"\n")