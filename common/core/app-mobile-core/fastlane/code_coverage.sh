file=test/coverage_helper_test.dart

# Remove the folder
cd ..
cd src
rm -rf coverage
rm test/coverage_helper_test.dart

echo "// Helper file to make coverage work for all dart files\n" > $file
echo "// ignore_for_file: unused_import" >> $file

find lib '!' -path '*generate*/*' '!' -name '*.g.dart' '!' -name '*.part.dart' '!' -name '*.freezed.dart' -name '*.dart' | cut -c4- | awk -v package=$1 '{printf "import '\''package:core%s%s'\'';\n", package, $1}' >> $file
echo "void main(){}" >> $file
