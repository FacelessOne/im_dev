#!/bin/env python
import optparse

if __name__ == '__main__':
    parser = optparse.OptionParser( usage = "usage: %prog [options] profile" )

    ( options, args ) = parser.parse_args()

    if not options:
	parser.print_help()
	sys.exit( 1 )

    env = '/home/ian.muir/depot/'
    virtualenv_descriptor = None
    dev_env = None

    if( args[0] == 'store' or args[0] == 'main' ):
	depot = env + 'headend/store/main'
	dev_env = env + 'headend/store/main/apache_local/dev_env.sh'
	virtualenv_descriptor = 'store-main'
    elif( args[0] == 'storedb' or args[0] == 'maindb' or args[0] == 'db' ):
        depot = env + 'headend/database/storedb/main'
	dev_env = env + 'headend/store/main/apache_local/dev_env.sh'
        virtualenv_descriptor = 'storedb-main'
    elif( args[0] == 'ian.muir' or args[0] == 'im' or args[0] == 'imdev' ):
        depot = env + 'ian.muir'
        virtualenv_descriptor = 'ian.muir_dev'
    else:
	depot = env + '/headend/store/v' + args[0]
	dev_env = env + 'headend/store/v' + args[0] + '/apache_local/dev_env.sh'
	virtualenv_descriptor = 'store-v' + args[0]

    if env:
	print 'cd %s' % depot
	print "# Comment"
	print "echo --- Using %s ---" % args[0]

    if dev_env:
	print '_SOURCE=%s' % dev_env
	with open( dev_env ) as f:
	    print f.read()

    if virtualenv_descriptor:
	print 'export K_VIRTUAL_ENV_DESCRIPTOR=%s' % virtualenv_descriptor
