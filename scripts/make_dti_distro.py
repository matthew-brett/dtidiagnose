#!/bin/env python
''' Make DTI toolbox distro '''

import os
import sys
import shutil
import urlparse
import tempfile
import optparse
from os import system as oss

svn_url = 'http://imaging.mrc-cbu.cam.ac.uk/svn'

class OptionParser (optparse.OptionParser):

    def check_required (self, opt):
        option = self.get_option(opt)
        
        # Assumes the option's 'default' is set to None!
        if getattr(self.values, option.dest) is None:
            self.error("%s option not supplied" % option)
            
def get_options():
    parser = OptionParser()
    parser.add_option("-d", "--dti-version", dest="dtiversion")
    parser.add_option("-u", '--utilities-version', dest='utilsversion')
    parser.add_option('-t', '--testing-version', dest='testingversion')
    options, args = parser.parse_args()
    parser.check_required("-d")
    parser.check_required("-u")
    parser.check_required("-t")
    if len(args):
        raise OSError('Specifiy options only')
    return options

def url2name(url):
    (s, netloc, path, p, q, f) = urlparse.urlparse(url)
    fpath, fname = os.path.split(path)
    if fname.startswith('release-'):
        fname = fname.replace('release-', '')
    path1, path2 = os.path.split(fpath)
    path3, path4 = os.path.split(path1)
    return '%s-%s' % (path4, fname)    

def pack_repos(repos_url, outpath=None):
    ''' Pack repository URL into archive in outpath
    Assumes URL is of form path/versions/[release-]version_id
    '''
    cwd = os.path.abspath(os.curdir)
    if outpath is None:
        outpath = cwd
    # Make archive file name
    arch_name = url2name(repos_url)
    tar_name = '%s.tar.gz' % arch_name
    # Export to temporary directory
    tmpdir= tempfile.mkdtemp()
    arch_path = os.path.join(tmpdir, arch_name)
    svn_str = 'svn export %s %s' % (repos_url, arch_path)
    os.system(svn_str)
    # Pack to tar archive in output directory
    os.chdir(tmpdir)
    os.system('tar zcvf %s %s' % (tar_name, arch_name))
    shutil.move(tar_name, outpath)
    os.chdir(cwd)
    # Remove temporary directory
    shutil.rmtree(tmpdir)

def main():
    options = get_options()
    repo_defs = (('cbudti', options.dtiversion),
                 ('utilities', options.utilsversion),
                 ('testing', options.testingversion))
    for name, version in repo_defs:
        version_suffix = os.path.join(name, 'versions',
                                      'release-'+ version)
        svn_purl = os.path.join(svn_url, version_suffix)
        pack_repos(svn_purl)

if __name__ == '__main__':
    main()

