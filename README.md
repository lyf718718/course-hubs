# course-hubs — shared GitHub Pages host for course hubs

One Pages repo, one subfolder per course. Serves `https://lyf718718.github.io/course-hubs/<course>/`.

**Model of record:** `Workspace_Ops_SOP/HUB_CANVAS_SOP.md` (Google Drive). Each course's hub is
BUILT in its own course folder (`Course_Design/hub_build/site/` — index.html + files/*.docx);
this repo only hosts the result. IBM3302's hub is the exception — it rides the simternship app
repo (`mktg-research-sim`) instead, to share that app's origin.

## Deploy (stateless — no persistent clone needed)

```bash
./scripts/deploy.sh <course-slug> <path-to-site-dir>
# example:
./scripts/deploy.sh ibm4212 "/Users/yufanlin/Library/CloudStorage/GoogleDrive-lyf918918@gmail.com/My Drive/2_Teaching/IBM4212/Course_Design/hub_build/site"
```

The script shallow-clones this repo into a temp dir, replaces `<course-slug>/` with the given
`site/` contents, commits, pushes, and discards the clone. GitHub is the authoritative copy;
any local clone (e.g. `~/dev/course-hubs`) is disposable convenience — never put one inside
Google Drive (`.git` + Drive sync corrupts).

## Layout

```
.nojekyll        (serve files as-is)
index.html       (plain directory page — update when adding a course)
scripts/deploy.sh
<course>/        (deployed hub sites, one per course)
```
