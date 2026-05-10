# tracedowney.com

Local preview uses Bundler plus the GitHub Pages gem so the site builds as close to production as possible.

## Local preview

1. Install Ruby 3.3.x and Bundler 2.x.
2. Run `bundle install`.
3. Run `./script/serve`.
4. Open `http://127.0.0.1:4000`.

The serve script writes generated files to `tmp/localpreview`, which stays out of git.

## Notes

- GitHub Pages still builds and publishes the site after pushes to `main`.
- If Bundler complains about your Ruby version, switch to Ruby 3.3 first.
