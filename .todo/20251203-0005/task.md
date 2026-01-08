# push .todo files to github issues

- STATUS: OPEN
- PRIORITY: 99
- TAGS: todo mgr, task sync

build in C, call executable in bash script
- C program syncs .todo with github both fetching issues and creating issues
- use exec to `gh issue create`
- check if issue already exists by title and tags combination
- notify and ask input if overwrite is needed
    - same title & tags, different body
    - both retrieving and creating tasks
    - provide diff for these
