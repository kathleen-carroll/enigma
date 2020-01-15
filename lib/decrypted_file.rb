require './lib/enigma'
require './lib/decrypt'
require './lib/encrypt'
require './lib/key'
require './lib/offset'
require 'date'

handle = File.open(ARGV[0], "r")

incoming_text = handle.read 
# incoming_text2 = handle.rewind
# incoming_text3 = handle.readlines

handle.close
require "pry"; binding.pry
enigma = Enigma.new
decrypted_text = enigma.decrypt(incoming_text)

writer = File.open(ARGV[1], "w")
writer.write(decrypted_text)
writer.close

# puts incoming_text
puts "Created #{ARGV[1]} with the key #{decrypted_text[:key]} and date #{decrypted_text[:date]}"
#enigma.encrypt(incoming_text)
