from sys import argv


print "Type the filename again:"
file_again = raw_input(">")

txt_again = open(file_again)

print txt_again.read()
print txt_again.encoding
print "name: " + txt_again.name
