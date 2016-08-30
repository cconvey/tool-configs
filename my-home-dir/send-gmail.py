#!/usr/bin/python

import smtplib
import sys
import subprocess
from email.mime.text import MIMEText

p = subprocess.Popen('dig +short myip.opendns.com @resolver1.opendns.com',
                     shell=True,
                     stdout=subprocess.PIPE,
                     stderr=subprocess.STDOUT)
lines = []
for line in p.stdout.readlines():
    lines.append( line );
retval = p.wait()

print '\n'.join( lines );

if retval != 0:
    sys.exit( retval )

if len(lines) != 1:
    print "More than one line of output.  Exiting."
    sys.exit( 1 )

from_add = "christian.convey@gmail.com"
to_addr = "christian.convey@gmail.com"

#msg = MIMEMultipart(lines[0])
msg = MIMEText(lines[0])
msg['From'] = from_add
msg['To'] = to_addr
msg['Subject'] = 'spaceman IP address'

username = "christian.convey"
#password = "PUT PASSWORD HERE"

# Start the server using gmail's servers
server = smtplib.SMTP('smtp.gmail.com:587')
server.starttls()
server.login(username, password)
server.sendmail(from_add, from_add, msg.as_string())

# Log off
server.quit()
