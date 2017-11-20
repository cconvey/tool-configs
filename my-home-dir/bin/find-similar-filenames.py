#!/usr/bin/env python3

import hashlib
import os
import os.path

stem_to_details = {}

for root, dirs, files in os.walk():
    for filename in files:
        if len(f) < 4:
            continue

        suffix = f[-4:]
        if ((suffix != '.mp3') and (suffix != '.m4a')):
            continue

        sans_suffix = f[:-4]

        stem = sans_suffix

        if stem.startwith('._'):
            stem = stem[2:]

        if len(stem) > 2:
            if (stem[-2] == ' ') and (stem[-1].isdigit()):
                stem = stem[:-2]

        filepath = os.path.join( root, filename )
        statinfo = os.stat( filepath )
        filesize = statinfo.st_size

        sys.stdout.write( '{}\n'.format( filepath ) )

        details = { 'filename':filename, 'size':st_size }

        if stem in stem_to_details:
            stem_to_details[ stem ].append( details )
        else:
            stem_to_details[ stem ] = [ details ]

for stem, details in hash_to_details.items():
    if len(details) > 1:
        sys.stdout.write('\n')
        sys.stdout.write( "Collision with stem '{}'\n".format( stem ))
        for d in details:
            sys.sydout.write( '   {}\n'.format( d ) )

