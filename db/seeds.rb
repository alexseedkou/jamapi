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
u3 = User.create(email: "guitar@guitar.com", password: "testpassword")

theateam = Song.new(title: "The A Team", artist: "Ed Sheeran", album: "+")
theateam.save
theateamTab1 = TabsSet.new(tuning: "E-B-G-D-A-E", capo: 0)
theateamTab1.times = [1.32,1.80,3.21,4.55]
theateamTab1.chords = ["G", "F#", "Em", "C"]
theateamTab1.tabs = ["030200000003","02xx00020302", "0002020000000","0003020001000"]
theateamTab1.song = theateam
theateamTab1.user = u1
theateamTab1.save

thinkingoutloud = Song.new(title: "Thinking Out Loud", artist: "Ed Sheeran", album: "X")
thinkingoutloud.save

thinkingoutloudtab1 = TabsSet.new(tuning: "E-B-G-D-A-E", capo: 0)
thinkingoutloudtab1.times = [1.1,3.5,3.8,4.4]
thinkingoutloudtab1.chords = ["D", "F#", "G", "A"]
thinkingoutloudtab1.tabs = ["xxxx00020302","02xx00020302", "030200000003", "xx0002020200"]
thinkingoutloudtab1.song = thinkingoutloud
thinkingoutloudtab1.user = u1
thinkingoutloudtab1.save


thinkingoutloudtab2 = TabsSet.new(tuning: "E-B-G-D-A-E", capo: 2)
thinkingoutloudtab2.times = [1.5,1.6, 2.4, 4.5]
thinkingoutloudtab2.chords = ["C", "E", "F", "G"]
thinkingoutloudtab2.tabs = ["xxxx00020302","02xx00020302", "030200000003", "xx0002020200"]
thinkingoutloudtab2.song = thinkingoutloud
thinkingoutloudtab2.user = u2
thinkingoutloudtab2.save

thinkingoutloudtab3 = TabsSet.new(tuning: "E-B-G-D-A-E", capo: 4)
thinkingoutloudtab3.times = [2.5, 4, 5, 5.4]
thinkingoutloudtab3.chords = ["B", "C#", "Eb", "F"]
thinkingoutloudtab3.tabs = ["xxxx00020302","02xx00020302", "030200000003", "xx0002020200"]
thinkingoutloudtab3.song = thinkingoutloud
thinkingoutloudtab3.user = u3
thinkingoutloudtab3.save
