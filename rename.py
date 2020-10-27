import os

folder = input("enter the name of the folder: ")
for count, name in enumerate(os.listdir(folder)):
    dst = str(count) + "." + list(name.split("."))[1]
    src = folder +"/" + name
    dst = folder +"/" + dst
    os.rename(src,dst)