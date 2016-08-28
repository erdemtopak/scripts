import os
import re
import sys
from glob import glob

# Example use :
# search.py /Users/topake/Code/ProjectName @AnnotationTest

def analyse_source_file(filePath):
	inputFile = open(filePath, "r")
	for line in inputFile:
		if re.match('.*' + sys.argv[2] + '.*', line):
			print filePath[filePath.rindex('/') + 1 :] + ' - ' + line,
			break
	inputFile.close()

def list_source_files(sourcePath):
	result = [y for x in os.walk(sourcePath) for y in glob(os.path.join(x[0], '*.java'))]
	for x in result:
		analyse_source_file(x)

def check_arguments():
	if len(sys.argv) != 3:
		print '\nExample use: \n\search.py /Users/topake/Code/ProjectName @ExampleAnnotation\n'
	else:
		list_source_files(sys.argv[1])

check_arguments()