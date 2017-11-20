#!/usr/bin/env python3

import hashlib
import os
import os.path

hash_to_details = {}

for root, dirs, files in os.walk():
    for filename in files:
        if len(f) < 4:
            continue

        suffix = f[-4:]
        if ((suffix != '.mp3') and (suffix != '.m4a')):
            continue

        filepath = os.path.join( root, filename )
        sys.stdout.write( '{}\n'.format( filepath ) )

        with open( filename, 'r' ) as f:
            data = f.read()
            md5sum = hashlib.md5(data).hexdigest()

            details = { 'filename':filename, 'size':len(size) }

            if md5sum in hash_to_details:
                hash_to_details[ md5sum ].append( details )
            else:
                hash_to_details[ md5sum ] = [ details ]

for hash, details in hash_to_details.items():
    if len(details) > 1:
        sys.stdout.write('\n')
        sys.stdout.write( 'Collision with md5sum {}\n'.format( hash ))
        for d in details:
            sys.sydout.write( '   {}\n'.format( d ) )

