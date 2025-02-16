#setup
mkdir cut_test
cd cut_test

echo "Foobar" > cutme.txt
mkdir cutdummydir
echo "Foobar" > cutdummydir/cutme.txt

#test cutting a file and a directory
clipboard cut cutme.txt cutdummydir
if [ ! -f "$TMPDIR"/Clipboard/0/cutme.txt ]; then
  echo did not cut file
  exit 1
fi
if [ ! -f "$TMPDIR"/Clipboard/0/cutdummydir/cutme.txt ]; then
  echo did not cut directory
  exit 1
fi

#test pasting a file and a directory that were cut
mkdir dummydir
cd dummydir
clipboard paste
if [ ! -f cutme.txt ]; then
  echo did not paste file
  exit 1
fi
if [ ! -f cutdummydir/cutme.txt ]; then
  echo did not paste file in directory
  exit 1
fi

#test contents of the files
contents=$(cat cutme.txt)
if [ "$contents" != "Foobar" ]; then
  echo "contents: $contents"
  exit 1
fi
contents=$(cat cutdummydir/cutme.txt)
if [ "$contents" != "Foobar" ]; then
  echo "contents: $contents"
  exit 1
fi

#setup for more cut tests
mkdir dummydir
cd dummydir
echo "Foobar" > cutme.txt
mkdir cutdummydir
echo "Foobar" > cutdummydir/cutme.txt

#test cutting a file and a directory to clipboard 1
clipboard cut1 cutme.txt cutdummydir
if [ ! -f "$TMPDIR"/Clipboard/1/cutme.txt ]; then
  echo did not cut file into cb 1
  exit 1
fi
if [ ! -f "$TMPDIR"/Clipboard/1/cutdummydir/cutme.txt ]; then
  echo did not cut directory into cb 1
  exit 1
fi

#test pasting a file and a directory that were cut from clipboard 1
mkdir dummydir
cd dummydir
clipboard paste1
if [ ! -f cutme.txt ]; then
  echo did not paste file from cb 1
  exit 1
fi
if [ ! -f cutdummydir/cutme.txt ]; then
  echo did not paste file in directory from cb 1
  exit 1
fi

#test contents of the files
contents=$(cat cutme.txt)
if [ "$contents" != "Foobar" ]; then
  echo "contents: $contents"
  exit 1
fi
contents=$(cat cutdummydir/cutme.txt)
if [ "$contents" != "Foobar" ]; then
  echo "contents: $contents"
  exit 1
fi

#setup to repeat cut tests, but with "--cut" instead of "cut"
clipboard --clear
mkdir dummydir
cd dummydir
echo "Foobar" > cutme.txt
mkdir cutdummydir
echo "Foobar" > cutdummydir/cutme.txt

#test cutting a file and a directory with "--cut"
clipboard --cut cutme.txt cutdummydir
if [ ! -f "$TMPDIR"/Clipboard/0/cutme.txt ]; then
  echo did not cut file
  exit 1
fi
if [ ! -f "$TMPDIR"/Clipboard/0/cutdummydir/cutme.txt ]; then
  echo did not cut directory
  exit 1
fi

#test pasting a file and a directory that were cut with "--paste"
mkdir dummydir
cd dummydir
clipboard --paste
if [ ! -f cutme.txt ]; then
  echo did not paste file
  exit 1
fi
if [ ! -f cutdummydir/cutme.txt ]; then
  echo did not paste file in directory
  exit 1
fi

#test contents of the files
contents=$(cat cutme.txt)
if [ "$contents" != "Foobar" ]; then
  echo "contents: $contents"
  exit 1
fi
contents=$(cat cutdummydir/cutme.txt)
if [ "$contents" != "Foobar" ]; then
  echo "contents: $contents"
  exit 1
fi

echo "Test passed"