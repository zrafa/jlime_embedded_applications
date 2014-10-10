#!/bin/sh

PHRA="`echo $1 | tr '[:lower:]' '[:upper:]'`"

cd /usr/local/share/mydict/a317/
CRC=`bgTreeCmd search sec.bgt S"$PHRA"`
NLINES=`bgTreeCmd search sec.bgt $CRC sec.bgb xiss | tee /tmp/tempfile | wc -l`

while [ "$NLINES" = "1" ] ; do
	PHRA=`echo $PHRA | sed -e 's/\//\\\\\//g'`
	NEWPHRA=`sed -e "s/^.*$PHRA[\t| ]//" -e "s/^ *//" /tmp/tempfile`
	PHRA="`echo $NEWPHRA | tr '[:lower:]' '[:upper:]'`"

	CRC=`bgTreeCmd search sec.bgt S"$PHRA"`
	NLINES=`bgTreeCmd search sec.bgt $CRC sec.bgb xiss | tee /tmp/tempfile | wc -l`

done
	
cat /tmp/tempfile | grep -v "^|" | sed 's/&nbsp;/ /g; s/&ndash;/-/g; s/\[\[.*\]\]//g; s/[\t  ]*/ /g' | 
 tr -s ' ' ' ' | tr '\012' ' ' | sed 's/|/@|/g; s/ $/@/; s/   */@@/g; s/[^@]\{35\} /&@/g; s/^[\t| ]*//' | tr '@' '\012' > /tmp/wikireader_temp_todelete
rm /tmp/tempfile
