# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#u1 = User.create(email: 'song@example.com', password: 'testpassword')

u1 = User.create(email: "song@twistjam.com", password: "testpassword")
u2 = User.create(email: "example@twistjam.com", password: "testpassword")

song1 = Song.new(title: "Thinking Out Loud", artist: "Ed Sheeran", album: "X")
song1.save

tab1 = TabsSet.new(tuning: "E-B-G-D-A-E", capo: 0)
tab1.times = [1,3,6]
tab1.chords = ["D", "F#", "G", "A"]
tab1.tabs = ["xxxx00020302","02xx00020302", "030200000003", "xx0002020200"]
tab1.song = song1
tab1.user = u1
tab1.save
