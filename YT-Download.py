#-*-coding:utf8;-*-
#qpy:2
#qpy:console

from os import chdir, getcwd, rename
from pytube import YouTube

print "\nYouTube Downloader by Alex M\n"

yt = YouTube(input("URL: "))
filename = input("Filename: ")
yt.set_filename(filename)

type = input("Music or Video (m/v): ")

if type == "m" or type == "music" or type == "M" or type == "Music":
  try: video = yt.get("mp4", "360p")
  except: video = yt.get("mp4", "720p")
  chdir("/sdcard/Music")
  video.download(getcwd())
  rename(filename + '.mp4', filename + '.mp3')
  print "Success"
  print filename + " is located at /sdcard/Music"
else:
  try: video = yt.get("mp4", "720p")
  except: video = yt.get("mp4", "360p")
  video.download("/sdcard/Download")
  print "\nSuccess"
  print filename + " is located in /sdcard/Download"
