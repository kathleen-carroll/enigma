require './lib/enigma'
require './lib/encrypt'
require './lib/key'
require './lib/offset'
require 'date'

handle = File.open(ARGV[0], "r")

incoming_text = handle.read

handle.close

enigma = Enigma.new
encrypted_text = enigma.encrypt(incoming_text)

writer = File.open(ARGV[1], "w")
writer.write(encrypted_text[:encryption])
writer.close

puts "Created #{ARGV[1]} with the key #{encrypted_text[:key]} and date #{encrypted_text[:date]}"
