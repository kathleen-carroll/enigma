require './lib/enigma'
require './lib/decrypt'
require './lib/encrypt'
require './lib/key'
require './lib/offset'
require 'date'

handle = File.open(ARGV[0], "r")

incoming_text = handle.read

handle.close
enigma = Enigma.new
decrypted_text = enigma.decrypt(incoming_text.chomp, ARGV[2], ARGV[3])

writer = File.open(ARGV[1], "w")
writer.write(decrypted_text[:decryption])
writer.close

puts "Created #{ARGV[1]} with the key #{decrypted_text[:key]} and date #{decrypted_text[:date]}"
