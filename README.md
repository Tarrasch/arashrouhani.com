[![Build Status](https://travis-ci.org/Tarrasch/arashrouhani.com.png)](https://travis-ci.org/Tarrasch/arashrouhani.com)

arashrouhani.com
================

The files for my personal web page. I usually use these commands:

```
stack build
stack exec -- site clean
stack exec -- site build
stack exec -- site check  # This tend to fail due to sites.google.com certificates
```

## Pushing the website

I push the website into a different repository to keep the "build recipe" (this repo) clean from build artifacts ([this other repo](https://github.com/Tarrasch/tarrasch.github.io)). To sync over the changes, do these steps.

From this repo.

```
stack exec -- site build
rsync  --verbose --delete-after --recursive _site/* ../tarrasch.github.io/
```

Go to other repo `cd ../tarrasch.github.io`. Check that `git status` diff makes sense and then run:

```
git -c core.excludesfile='NONE' add --all -- ./
git commit --message="Commiting generated contents"
git push origin master
```

This "manual" process the crazy `.travis.yml` script I used to have. :D
