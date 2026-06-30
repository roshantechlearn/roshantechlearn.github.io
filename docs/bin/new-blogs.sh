#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

# Configuration
POSTS_DIR="../_posts"
DRAFTS_DIR="../_drafts"
BOOKS_DIR="../_books"
PAPERS_DIR="../_papers"

show_help() {
  echo "Usage: ./bin/new-blogs.sh [type] \"Post Title\""
  echo ""
  echo "Types:"
  echo "  blog   : Active blog post (published immediately)"
  echo "  draft  : Draft blog post (hidden on prod, visible locally via --drafts)"
  echo "  book   : Bookshelf review entry"
  echo "  paper  : Papershelf technical analysis"
  echo ""
  echo "Example: ./bin/new-blogs.sh draft \"Deep Dive into Akka Actor Internals\"" 
  echo "Example: ./bin/new-blogs.sh book \"Designing Data-Intensive Applications\""
}

# Ensure correct argument counts
if [ $# -lt 2 ]; then
  show_help
  exit 1
fi

TYPE=$1
TITLE=$2

# Format metadata markers
CURRENT_DATE=$(date +"%Y-%m-%d")
SLUG=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | sed -e 's/[^a-z0-9]/-/g' -e 's/-\+/-/g' -e 's/^-//' -e 's/-$//')

case "$TYPE" in
  blog)
    TARGET_DIR="$POSTS_DIR"
    FILENAME="${CURRENT_DATE}-${SLUG}.md"
    FRONT_MATTER="---\ntitle: \"${TITLE}\"\ndate: ${CURRENT_DATE}\n---"
    ;;
  draft)
    TARGET_DIR="$DRAFTS_DIR"
    FILENAME="${SLUG}.md" # Drafts do not strictly require dated prefix loops
    FRONT_MATTER="---\ntitle: \"${TITLE}\"\ndate: ${CURRENT_DATE}\n---"
    ;;
  book)
    TARGET_DIR="$BOOKS_DIR"
    FILENAME="${CURRENT_DATE}-${SLUG}.md"
    FRONT_MATTER="---\ntitle: \"${TITLE}\"\nauthor: \"Author Name\"\nstatus: \"reading\" # options: reading, finished\ndate: ${CURRENT_DATE}\n---"
    ;;
  paper)
    TARGET_DIR="$PAPERS_DIR"
    FILENAME="${CURRENT_DATE}-${SLUG}.md"
    FRONT_MATTER="---\ntitle: \"${TITLE}\"\nconference: \"USENIX / OSDI '26\"\ndate: ${CURRENT_DATE}\n---"
    ;;
  *)
    echo "Error: Unknown type '$TYPE'."
    show_help
    exit 1
    ;;
esac

# Create directory matrices safely if they do not exist
mkdir -p "$TARGET_DIR"

FULL_PATH="${TARGET_DIR}/${FILENAME}"

# Prevent accidentally overwriting a technical post
if [ -f "$FULL_PATH" ]; then
  echo "Error: File already exists at ${FULL_PATH}"
  exit 1
fi

# Generate template markdown
echo -e "$FRONT_MATTER" > "$FULL_PATH"
echo -e "\nWrite your technical analysis or content markdown here..." >> "$FULL_PATH"

echo "Success! Created new ${TYPE} entry at: ${FULL_PATH}"
