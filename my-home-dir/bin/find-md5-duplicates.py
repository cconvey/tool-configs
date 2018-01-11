#!/usr/bin/env python3

import hashlib
import os
import os.path
import sys

def characterize_file( dirname, filename ):
    d = {}

    d['filename'] = filename
    d['dirname'] = dirname
    d['pathname'] = os.path.join( dirname, filename )

    statinfo = os.stat( d['pathname'] )
    filesize = statinfo.st_size
    d['size'] = filesize

    if (len(filename) >= 4) and (filename[-4:] in ['.mp3', '.m4a']):
        d['suffix'] = filename[-3:]
    else:
        d['suffix'] = 'other'

    if d['suffix'] in ['mp3', 'm4a']:
        stem = filename[:-4]

        d['starts_with_dot_underscore'] = stem.startswith('._')

        d['ends_with_space_digit'] = (len(stem) >= 2) and (stem[-2] == ' ') and (stem[-1].isdigit())

        if d['starts_with_dot_underscore']:
            stem = stem[2:]

        if d['ends_with_space_digit']:
            stem = stem[:-2]

        d['stem'] = stem

        with open( d['pathname'], 'rb' ) as f:
            data = f.read()
            md5sum = hashlib.md5(data).hexdigest()
            d['md5sum'] = md5sum

    return d


def main( argv ):
    search_root = argv[1]

    hash_to_details = {}

    for root, dirs, files in os.walk( search_root ):
        for filename in files:
            d = characterize_file( root, filename )

            if 'md5sum' in d:
                sys.stdout.write( "{}  '{}'\n".format( d['md5sum'], d['pathname'] ) )
                md5sum = d['md5sum']
                if 'md5sum' in hash_to_details:
                    hash_to_details[ md5sum ].append( d)
                else:
                    hash_to_details[ md5sum ] = [ d ]

    for hash, details in hash_to_details.items():
        if len(details) > 1:
            sys.stdout.write('\n')
            sys.stdout.write( 'Collision with md5sum {}\n'.format( hash ))
            for d in details:
                sys.sydout.write( '   {}\n'.format( d ) )

if __name__ == '__main__':
    main( sys.argv )
