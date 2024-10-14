cd ..
cd src/coverage/html
value=$(grep "headerCovTableEntryLo" index.html)
coverage=$(echo $value | cut -d'>' -f 2)
coverage=$(echo $coverage | cut -d' ' -f 1)

minimum_coverage=$1

echo "current coverage: $coverage"

if [[ "$coverage" < "$minimum_coverage" ]]; then
    echo "Failed: Code coverage is less than 80%"
    exit 1
fi
