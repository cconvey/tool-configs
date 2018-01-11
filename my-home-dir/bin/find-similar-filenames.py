#!/usr/bin/env python3

import hashlib
import os
import os.path
import sys

def sanitize_dirname( filename ):
    return filename.replace("'", "\\'").replace('(','\(').replace(')','\)')

def sanitize_filename( filename ):
    return filename.replace("'", "\\'").replace('(','\(').replace(')','\)')

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

    return d


def do_action( a ):
    if a['verb'] == 'mkdir':
        if not os.path.isdir( a['dirname'] ):
            os.makedirs( a['dirname'] )
    elif a['verb'] == 'move-to-dir':
        filename = os.path.basename( a['src'] )
        newpath = os.path.join( a['dest-dir'], filename )
        os.rename( a['src'], newpath )
    else:
        raise "Unrecognized action: {}".format( a )

def print_action( a ):
    print( a )

def make_actions( details, penalty_box ):
    actions = []

    # Rule 1: eliminate all but the largest...
    largest_size = max( [ d['size'] for d in details ] )

    details_with_largest_size = [ d for d in details if d['size'] == largest_size ]
    details_with_smaller_size = [ d for d in details if d['size'] < largest_size ]

    for d in details_with_smaller_size:
        penalty_dir = sanitize_dirname(os.path.join( penalty_box, d['dirname'] ))
        actions.append( { 'verb':'mkdir', 'dirname':penalty_dir } )
        actions.append( { 'verb':'move-to-dir', 'src':d['pathname'], 'dest-dir':penalty_dir } )

    remainder = details_with_largest_size

    # Rule 2: prefer the simple filename to the messy filename...
    details_with_preferred_filename_format = []
    details_without_preferred_filename_format = []
    for d in remainder:
        if d['starts_with_dot_underscore'] or d['ends_with_space_digit']:
            details_without_preferred_filename_format.append( d )
        else:
            details_with_preferred_filename_format.append( d )

    remainder = details_with_preferred_filename_format

    if len(details_with_preferred_filename_format) > 0:
        remainder = details_with_preferred_filename_format

        for d in details_without_preferred_filename_format:
            penalty_dir = sanitize_dirname(os.path.join( penalty_box, d['dirname'] ))
            actions.append( { 'verb':'mkdir', 'dirname':penalty_dir } )
            actions.append( { 'verb':'move-to-dir', 'src':d['pathname'], 'dest-dir':penalty_dir } )
    else:
        remainder = details_with_preferred_filename_format + details_without_preferred_filename_format

    return actions


def main( argv ):
    search_root = argv[1]
    penalty_box = argv[2]

    stem_to_details = {}

    for root, dirs, files in os.walk(search_root):
        for filename in files:
            d = characterize_file( root, filename )
            if d['suffix'] not in ['mp3','m4a']:
                continue

            sys.stdout.write( '# {}\n'.format( d['pathname'] ) )

            stem = d['stem']
            if stem in stem_to_details:
                stem_to_details[ stem ].append( d )
            else:
                stem_to_details[ stem ] = [ d ]

    for stem, details in stem_to_details.items():
        if len(details) > 1:
            sys.stdout.write('\n')
            sys.stdout.write( "# Collision with stem '{}'\n".format( stem ))
            for d in details:
                sys.stdout.write( "#   '{}'\n".format( d ) )

        if False:
            actions = make_actions( details, penalty_box )
            for a in actions:
                print_action( a )
                do_action( a )

if __name__ == '__main__':
    main( sys.argv )

