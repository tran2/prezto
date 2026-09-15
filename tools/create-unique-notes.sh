createUniqueNewNote() {
  local title="$*"
  # Generate your YYYY.MM.DD.dd format (e.g., 2026.03.25.We)
  local date_prefix=$(date +"%Y.%m.%d.%a" | sed 's/\([A-Z][a-z]\).*/\1/')
  # add a .md because obsidian will truncate the .md part so if we have a.b.c c will be truncated if
  # we don't add .md
  local full_title="${date_prefix} ${title}.md"

  echo "${full_title}"

  obsidian create path="001 Quick Notes" name="${full_title}" template="FollowUp-Template" open
}

createUniqueNewNote()
