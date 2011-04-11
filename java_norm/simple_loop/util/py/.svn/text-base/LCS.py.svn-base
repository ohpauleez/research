#!/usr/bin/env python

# Classes to compute the longest common subsequence and longest common substring

class SequenceMatrix(list):
	"""A class to hold and operate on sequence matrices"""
	pass
class SubstringMatrix(list):
	"""A class to hold and operate on sequence matrices"""
	pass

class InvalidMatrixError(Exception):
	"""A generic exception class to handle matrix related errors"""
	pass


def __matrix(X, Y, matrixClass):
	"""
	Generates matrices used later to compute LCS.
	The are constructed of X rows and Y columns
	Where X and Y are your sequences.

	Args:
	X - A string or sequence
	Y - A string or sequence
	matrixClass - the type of matrix you are generating.
		This should be SequenceMatrix or SubstringMatrix

	Returns:
	Returns a matrix of type matrixClass,
	which is just a list of lists
	"""
	C = matrixClass()
	C.seqOne = X
	C.seqTwo = Y
	C.seqOneLen = len(X)
	C.seqTwoLen = len(Y)
	C += [[0] * (C.seqTwoLen+1) for i in range(C.seqOneLen+1)]

	for i in range(C.seqOneLen):
		for j in range(C.seqTwoLen):
			if X[i] == Y[j]:
				C[i+1][j+1] = C[i][j] + 1
			elif isinstance(C, SequenceMatrix):
				C[i+1][j+1] = max(C[i+1][j], C[i][j+1])

	#if isinstance(C, SequenceMatrix):
	#	C.levenshtein = C[-1][-1]
	#	C.l_distance = C.levenshtein
	return C

#def levenstein(s, t):
#	 m, n = len(s), len(t)
#	 d = [range(n+1)]
#	 d += [[i] for i in range(1,m+1)]
#	 for i in range(1,m+1):
#		 for j in range(1,n+1):
#			 d[i] += [0 for k in range(m)]
#			 cost = 1
#			 if s[i-1] == t[j-1]: cost = 0
#			 try:
#				 d.append( min(d[i-1][j]+1, # deletion
#							   d[i][j-1]+1, #insertion
#							   d[i-1][j-1]+cost)) #substitution
#			 except IndexError:
#				 print "Index Error:", j
#	 return d

def getSequenceMatrix(X, Y):
	"""
	Generataes and returns a SequenceMatrix

	Args:
	X - A string or sequence
	Y - A string or sequence

	See also:
	__matrix
	"""
	return __matrix(X,Y,SequenceMatrix)

def getSubstringMatrix(X, Y):
	"""
	Generataes and returns a SubstringMatrix

	Args:
	X - A string or sequence
	Y - A string or sequence

	See also:
	__matrix
	"""
	return __matrix(X,Y,SubstringMatrix)

def getMatrix(X, Y, matrixClass):
	"""
	Generataes and returns a matrix based on matrixClass

	Args:
	X - A string or sequence
	Y - A string or sequence
	matrixClass - the type of matrix you are generating.
		This should be SequenceMatrix or SubstringMatrix


	See also:
	__matrix, getSequenceMatrix, getSubstringMatrix
	"""
	if isinstance(matrixClass(), SequenceMatrix):
		return getSequenceMatrix(X, Y)
	elif isinstance(matrixClass(), SubstringMatrix):
		return getSubstringMatrix(X, Y)
	else:
		raise InvlaidMatrixError("Invlaid matrix class passed")

def getSequencesFromMatrix(C, endRow=None, endColumn=None):
	"""
	Using a matrix, calculate the longest common sequences

	Args:
	C - A SequenceMatrix, passing anything else will
		raise an InvalidMatrixError
	[endRow] - the row you would like to stop computation on and confine to
	[endColumn] - the column you would like to stop computation on and confine to
	
	Returns:
	A set of all the longest common sequences
	"""
	if isinstance(C, SequenceMatrix):
		pass
	else:
		raise InvaldiMatrixError("Invlaid matrix class passed")

	if endRow == None:
		endRow = C.seqOneLen
	if endColumn == None:
		endColumn = C.seqTwoLen

	i = endRow; j = endColumn
	X = C.seqOne; Y = C.seqTwo
	if i == 0 or j == 0:
		return set([""])

	elif X[i-1] == Y[j-1]:
		return set([Z + X[i-1] for Z in getSequencesFromMatrix(C, i-1, j-1)])

	else:
		R = set()
		if C[i][j-1] >= C[i-1][j]:
			R.update(getSequencesFromMatrix(C, i, j-1))
		if C[i-1][j] >= C[i][j-1]:
			R.update(getSequencesFromMatrix(C, i-1, j))
		return R

def getSubstringsFromMatrix(C):
	"""
	Using a matrix, calculate the longest common substrings

	Args:
	C -  A SubstringMatrix, passing anything else will
		raise an InvalidMatrixError
	"""
	if isinstance(C, SubstringMatrix):
		pass
	else:
		raise InvalidMatrixError("Invlaid matrix class passed")

	m = C.seqOneLen
	n = C.seqTwoLen
	LCS = set()
	longest = 0

	for i in range(m):
		for j in range(n):
			v = C[i+1][j+1]
			if v > longest:
				longest = v
				LCS = set()
			if v == longest:
				LCS.add(C.seqOne[i-v+1:i+1])
	return LCS


def getLCFromMatrix(C, endRow=None, endColumn=None):
	"""
	Using a matrix, calculate the LCS (seq or sub)

	See:
	getSequencesFromMatrix, getSubstringsFromMatrix
	"""
	if isinstance(C, SequenceMatrix):
		return getSequencesFromMatrix(C, endRow, endColumn)
	elif isinstance(C, SubstringMatrix):
		return getSubstringsFromMatrix(C)
	else:
		raise InvalidMatrixError("Invlaid matrix passed")



class __LCSbase(object):
	"""
	A generic class to calculate and manage sequences/substrings

	Upon intialization, sequences are checked for None,
	a matrix is generated (self.matrix),
	and the LCS is calculated (self.set)
	"""
	
	def __init__(self, seqOne, seqTwo, matrixClass):
		if self.verifyNotNone([seqOne, seqTwo]):
			self.seqOne = seqOne
			self.seqTwo = seqTwo
			self.matrix = getMatrix(self.seqOne, self.seqTwo, matrixClass)
			self.set = getLCFromMatrix(self.matrix)
			
	def __len__(self):
		return len(list(self.set)[0])

	@staticmethod
	def verifyNotNone(seqs):
		"""
		Parses to see if any args are set to None

		Args:
		seqs - a sequence or list of sequences

		Returns:
		True is no args are set to None

		Raises:
		Exception is it finds an arg set to None
		"""
		# Assure we're operating on list of a sing arg or multiple arguments
		if isinstance(seqs, list):
			pass
		else:
			seqs = [seqs]
		# Check for args passed as None
		print seqs
		for seq in seqs:
			if seq == None:
				Exception("Your sequence was passed as None.")
			else:
				pass
		return True

class LCSequence(__LCSbase):
	"""A class to handle interacting with sequences. See: __LCSbase"""
	def __init__(self, seqOne, seqTwo):
		super(LCSequence, self).__init__(seqOne, seqTwo, SequenceMatrix)
		self.sequences = self.set

class LCSubstring(__LCSbase):
	"""A class to handle interacting with substrings. See: __LCSbase"""
	def __init__(self, seqOne, seqTwo):
		super(LCSubstring, self).__init__(seqOne, seqTwo, SubstringMatrix)
		self.substrings = self.set


class LCS(object):
	"""A class to compare two sequences for LCSequence and LCSubstring"""
	def __init__(self, seqOne, seqTwo):
		self.seq = LCSequence(seqOne, seqTwo)
		self.substr = LCSubstring(seqOne, seqTwo)

if __name__ == "__main__":
	# Consider this a simple tutorial
	myLCS = LCS("HELLOHELLO", "HELLOWORLDHELLO")
	print "myLCS.seq:", myLCS.seq
	print "myLCS.substr:", myLCS.substr
	print "LCSeqs:", myLCS.seq.sequences # This could also be myLCS.seq.set
	print "LCSubstrs:", myLCS.substr.substrings # This could also be myLCS.substr.set
	print "Length of seq:", len(myLCS.seq)
	print "Length od substr:", len(myLCS.substr)
	#print "Levenshtein distance:", myLCS.seq.matrix.l_distance
	print "The sequence matrix..."
	for row in myLCS.seq.matrix:
		print row
	print "\nThe substring matrix..."
	for row in myLCS.substr.matrix:
		print row
	print ""

