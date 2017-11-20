#!/usr/local/bin/python3

import os
import os.path
import argparse
import re
import shutil

#M4A_DOTFILE_RE_ = re.compile( r'^\..*\.m4a$')
#M4P_FILE_RE_ = re.compile( r'^.*\.m4p$')

def path_total_split( path_str ):
    if len(path_str) == 0:
        return []

    if path_str[-1] == '/':
        path_str = path_str[:-1]

    parts = []
    remainder = path_str
    while len(remainder) > 0:
        remainder, tail = os.path.split( remainder )
        parts.append( tail )

    parts.reverse()
    return parts

def main( args ):
    if not os.path.isdir( args.src_dir[0] ):
        raise "src-dir '{}' is not a directory'".format( args.src_dir[0] )

    if not os.path.isdir( args.dest_dir[0] ):
        raise "dest-dir '{}' is not a directory'".format( args.dest_dir[0] )

    src_root_dir = os.path.normpath( args.src_dir[0] )
    dest_root_dir = os.path.normpath( args.dest_dir[0] )
    filename_re = re.compile( args.filename_pattern[0] )

    for root, dirs, files in os.walk( src_root_dir ):
        src_subdirs_path = path_total_split(root)[1:]

        files_to_move = []

        for f in files:
            if filename_re.match( f ):
                files_to_move.append( f )

        if len(files_to_move) > 0:
            dest_dir_path = os.path.join( dest_root_dir, *src_subdirs_path )

            if not os.path.isdir( dest_dir_path ):
                print( "MKDIR '{}'".format( dest_dir_path ))
                os.makedirs( dest_dir_path )

            for f in files_to_move:
                src_file_path = os.path.join( root, f )
                print( 'MOVE "{}" to "{}"'.format( src_file_path, dest_dir_path ))
                shutil.move( src_file_path, dest_dir_path )


if __name__ == '__main__':
    parser = argparse.ArgumentParser("""
        Recursively search the specified directory, looking for files matching the
        specified patterns.  Any matching files are moved, and the directory structure
        from the source-directory to the matching file is reproduced under the target
        directory.
        """
        )

    parser.add_argument('src_dir', type=str, nargs=1 )
    parser.add_argument('dest_dir', type=str, nargs=1 )
    parser.add_argument('filename_pattern', type=str, nargs=1 )
    parser.add_argument('--dry-run', '-d', action='store_true')

    args = parser.parse_args()

    main( args )
