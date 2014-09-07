[ ![Codeship Status for bobolinks-2014/browsin](https://codeship.io/projects/fa0524b0-15f6-0132-f381-3ada423a8ca3/status)](https://codeship.io/projects/33778)

# Browsin'

## Purpose

Browsin is designed for quick search of the best shows or movies based on your available time.

## Getting Started
The available database contains over 1200 movies and tv shows from Netflix, HBO Go, and Hulu.  To get started, clone this repo.

You will need to add your [Guidebox API](http://api.guidebox.com/) key to have access to their database.

Add the following to your shell environment (eg. .bash_profile, .zshrc):
```
export GUIDEBOX_API_KEY="[your key]"
```
Now set up your rails environment:
```
rake db:reset
rake db:media => This process can take up to 15 minutes depending on your system
rails server => Point your browser to localhost:3000
```

## Dependencies
* [Guidebox](#)
* [Netflix](#)
* [OMDB](#)

## Contributors
* [Grace Yim](https://github.com/graceekyim)
* [Joey Sabani](https://github.com/axhi)
* [Joey Chamberlin](https://github.com/jochambo)
* [Rob Schwartz](https://github.com/robschwartz)

## Licenses
The MIT License (MIT)

Copyright (c) [2014] [Browsin]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
