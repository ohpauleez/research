#!/usr/bin/env python

# JasmProcessor.py
# This is a generic file to normalize and compare java assembly code
# Paul deGrandis

import LCS
#TODO This needs to be a separate file called LCSComparator.py Making it a class might not be a bad idea
#TODO Thus file should generate statistics about a SINGLE file.  # of lines, gotos/lines, ifs/lines, char-count, etc
#TODO    These should be combined with the source level metrics to create vectors aka: Multi-dimension metrics

def getLCSFromFiles(fileOne, fileTwo, ignoreLineDir=True, ignoreComments=True, ignoreFileSpecifics=False):
	"""
	Process an LCS object given two files

	see getStringsFromFiles for arg info
	"""
	seqOne, seqTwo = getStringsFromFiles(fileOne, fileTwo, ignoreLineDir, ignoreComments, ignoreFileSpecifics)
	retLCS = LCS.LCS(seqOne, seqTwo)
	return retLCS

def getStringsFromFiles(fileOne, fileTwo, ignoreLineDir=True, ignoreComments=True, ignoreFileSpecifics=False):
	"""
	Returns two strings of two process Jasmin files (Java Assembly/JASM)

	Args:
	fileOne, fileTwo - files (with path if needed) passed as strings
	[ignoreLineDir] - ignore line directives when processing and compiling the return string
	[ignoreComments] - ignore comments when process and compiling the return string
	[ignoreFileSpecifics] - ignore items that are specifc to the file such as class name and java source file

	Returns:
	Two strings, of the JASM lines concatenated and process based on the args passed
	"""
	
	retStrOne = ""
	retStrTwo = ""

	isSecondFile = False #Toggle for which file we're processing

	files = []
	filestats = {}
	files.append(open(fileOne))
	files.append(open(fileTwo))

	for f in files:
		filestats[f.name] = {}
		linenum = 0
		for line in f.readlines():
			linenum +=1
			#if (ignoreLineDir) and (line[0:5] == ".line"):
			if (ignoreLineDir) and (line.startswith(".line")):
				pass
			elif (ignoreComments) and (line.startswith(";;")):
				pass
			elif (ignoreFileSpecifics) and (line.startswith(".source")):
				pass
			elif (ignoreFileSpecifics) and (line.startswith(".class")):
				pass
			else:
				# If we have passed through the filter, we should store the information..
				if isSecondFile:
					retStrTwo += line
				else:
					retStrOne += line
		filestats[f.name]['linecount'] = linenum
		isSecondFile = True

	for f in files:
		f.close()

	return retStrOne, retStrTwo


if __name__ == "__main__":
	import sys
	import time
	import Levenshtein as ldistance
	args = sys.argv[1:]
	start_time = time.time()
	asmLCS = getLCSFromFiles(args[0], args[1])
	print "Sequences:", asmLCS.seq.sequences #asmLCS.seq is the LCSequence object
	print "Substrings:", asmLCS.substr.substrings
	lenSeqOne = (float)(len(asmLCS.seq.seqOne))
	lenSeqOneBuiltin = (float)(asmLCS.seq.matrix.seqOneLen)
	lenSeqTwo = (float)(len(asmLCS.seq.seqTwo))
	lenSeqTwoBuiltin = (float)(asmLCS.seq.matrix.seqTwoLen)
	lenLCSeq =  (float)(len(asmLCS.seq))
	lenLCSub = (float)(len(asmLCS.substr))
	perSim = ((lenLCSeq/lenSeqOne) + (lenLCSeq/lenSeqTwo))/2
	perExact = ((lenLCSub/lenSeqOne) + (lenLCSub/lenSeqTwo))/2
	print "Length of SeqOne:", lenSeqOne
	print "Length of SeqOne (builtin):", lenSeqOneBuiltin
	print "Length of SeqTwo:", lenSeqTwo
	print "Length of SeqTwo (builtin):", lenSeqTwoBuiltin
	print "Length of LCSeq:", lenLCSeq
	print "Length of LCSub:", lenLCSub
	print "Substring in SeqOne starts at postion:", asmLCS.seq.seqOne.find(list(asmLCS.substr.substrings)[0])
	print "Substring in SeqTwo starts at postion:", asmLCS.seq.seqTwo.find(list(asmLCS.substr.substrings)[0])
	print "Percent Similar:", perSim
	print "Percent Exact Copy:", perExact
	print "Levenshtein Distance:", ldistance.distance(asmLCS.seq.seqOne, asmLCS.seq.seqTwo)
	print "Jaro Similarity:", ldistance.jaro(asmLCS.seq.seqOne, asmLCS.seq.seqTwo)
	print "Jaro-Winkler:", ldistance.jaro_winkler(asmLCS.seq.seqOne, asmLCS.seq.seqTwo)
	print "Simlarity ratio:", ldistance.ratio(asmLCS.seq.seqOne, asmLCS.seq.seqTwo)
	print "\nSeconds to process and calculate:", time.time()-start_time

	# Levenshtein distance - character operations (add, remove, swap) needed to transform one string into the other.
	# Jaro Similarity - similarity of short strings; 0 if completely different, 1 if identical
	# Jaro-Winkler - Prefix weighted version of Jaro, because typos and divergence happens near the end of seqs
	# Similarity Ratio - The real minimal edit distance, aka diff sequence matching

