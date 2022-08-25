#!/usr/bin/env python

"""
A custom made script to merge the XML blast outputs
when queries are run in parallel by input-choping.

Copied and adapted from <a rel="nofollow" href="https://bitbucket.org/peterjc/galaxy-central/src/5cefd5d5536e/tools/ncbi_blast_plus/blast.py">https://bitbucket.org/peterjc/galaxy-central/src/5cefd5d5536e/tools/ncbi_blast_plus/blast.py</a>

Tested working with BLAST 2.2.28+

The fields:
  &lt;Iteration_iter-num&gt;&lt;/Iteration_iter-num&gt;
  &lt;Iteration_query-ID&gt;&lt;/Iteration_query-ID&gt;
should not be used from the merged file.

You can use this script from the shell like this:
$ blast_merge_xml reads*.xml &gt; merged.xml
"""

# Modules #
import sys, os, sh
from contextlib import nested

###############################################################################
def merge_blast_xml(inputs, output):
    """Will merge the results from several BLAST searches
    when XML output is used."""
    for i,handle in enumerate(inputs):
        path = handle.name
        header = handle.readline()
        if not header:
            raise Exception("BLAST XML file '%s' was empty" % path)
        if header.strip() != '':
            raise Exception("BLAST file '%s' is not an XML file" % path)
        line = handle.readline()
        header += line
        if line.strip()[0:59] != '" in line: break
            if len(header) &gt; 10000:
                raise Exception("BLAST file '%s' has a too long a header" % path)
        if "&lt;BlastOutput&gt;" not in header:
            raise Exception("BLAST XML file '%s' header's seems bad" % path)
        if i == 0:
            output.write(header)
            old_header = header
        elif old_header[:300] != header[:300]:
            raise Exception("BLAST XML headers don't match" % path)
        else: output.write("    &lt;Iteration&gt;\n")
        for line in handle:
            if "&lt;/BlastOutput_iterations&gt;" in line: break
            output.write(line)
    output.write("&lt;/BlastOutput_iterations&gt;\n")
    output.write("&lt;/BlastOutput&gt;\n\n")
    output.flush()

###############################################################################
# Get arguments #
xml_paths = sys.argv[1:]
# Check for non-evaluated wild char #
if len(xml_paths)==1 and '*' in xml_paths[0]: xml_paths = sh.glob(xml_paths[0])
# Check for existence #
for path in xml_paths:
    if not os.path.exists(path): raise Exception("No file at '%s'." % path)
# Check for user intelligence #
if len(xml_paths) == 1: raise Exception("No need to join just one file.")
# Do it #
with nested(*map(open,xml_paths)) as inputs: merge_blast_xml(inputs, sys.stdout)