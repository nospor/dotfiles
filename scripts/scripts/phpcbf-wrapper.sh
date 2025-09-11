#!/bin/bash

# wrapper for phpcbf to format PHP code from stdin
# phpcbf requires to be <?php at the begining of the text so main role of this wrapper is just to add that <?php if it doesn't exist
# currenlty that wrapper is used by nvim to format php block code

# Create a temp file for stdin input
TMPFILE=$(mktemp --suffix=.php)

# Read stdin into a variable
INPUT=$(cat)

# Check if input starts with "<?php"
if [[ "$INPUT" != "<?php"* ]]; then
  echo "<?php" > "$TMPFILE"
fi

# Append input to the file
echo "$INPUT" >> "$TMPFILE"

# Run phpcbf on the temp file
phpcbf --standard=PSR12 "$TMPFILE" > /dev/null 2>&1

# Output the result, skipping the <?php line if we added it
if [[ "$INPUT" != "<?php"* ]]; then
  tail -n +3 "$TMPFILE"
else
  cat "$TMPFILE"
fi

# Cleanup
rm "$TMPFILE"


