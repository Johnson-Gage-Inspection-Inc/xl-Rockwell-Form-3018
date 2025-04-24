git log --follow --pretty=format:"%h %ad" --date=iso-strict -- "Form 3018, Rockwell.xltm" | \
while IFS= read -r line; do
  commit=$(echo "$line" | awk '{print $1}')
  datetime=$(echo "$line" | awk '{print $2 "T" $3}')
  size=$(git cat-file -s "$commit:Form 3018, Rockwell.xltm" 2>/dev/null || echo "0")
  echo "$datetime $commit $size"
done
