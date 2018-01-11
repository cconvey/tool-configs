#!/usr/bin/env python3

import collections
import hashlib
import os
import os.path
import sys


def main( argv ):
    search_root = argv[1]

    basename_to_dirnames = collections.defaultdict(list)

    for root, dirs, files in os.walk( search_root ):
        for filename in files:
            basename_to_dirnames[ filename ].append( ('file', root,) )
        for dirname in dirs:
            basename_to_dirnames[ dirname ].append( ('dir', root,) )

    # Identify basenames that are prefixes of others...
    sorted_basenames = sorted( basename_to_dirnames.keys() )
    for i in range(0, len(sorted_basenames)-1):
        n1 = sorted_basenames[i]
        n2 = sorted_basenames[i+1]

        if n2.startswith(n1):
            sys.stdout.write('\n')
            sys.stdout.write( "n1 = {}\n".format(n1))
            sys.stdout.write( "n2 = {}\n".format(n2))

            sys.stdout.write( "n1 paths:\n")
            for d in basename_to_dirnames[n1]:
                sys.stdout.write("   '{}'\n".format( d ))

            sys.stdout.write( "n2 paths:\n")
            for d in basename_to_dirnames[n2]:
                sys.stdout.write("   '{}'\n".format( d ))


if __name__ == '__main__':
    main( sys.argv )
