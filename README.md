# browsin'

## Purpose

browsin' provides users with an efficient way to search streaming movies and shows based on their subscriptions to Netflix, Hulu Plus and HBO. Results are sorted by ratings collected from IMDB and Rotten Tomatoes, allowing users to immediately discover the highest-rated content available to them. 

#### Getting Started
The available database contains over 1,200 movies and tv shows from Netflix, HBO Go, and Hulu.

* Fork our repository
* Clone your fork
* You will need to add a [Guidebox API](http://api.guidebox.com/) key to have access to their data. Add the following to your shell environment (eg. .bash_profile, .zshrc):
```
export GUIDEBOX_API_KEY="[your key]"
```
* run
  * ```bundle```
  * ```rake db:reset```
  * ```rake db:media```
  * ```rails s```
* Open your localhost in a webbrowser and start searching.
* Or visit our herokuapp page!
  * [deployed app](http://browsin-dbc.herokuapp.com/)

## Dependencies
* [Guidebox](http://api.guidebox.com/)
* [Instant Watcher](http://instantwatcher.com/)
* [OMDB](http://www.omdbapi.com/)


## Technologies
* Ruby on Rails
* Nokogiri
* jQuery
* React
* PostgreSQL
* Testing: RSpec, Capybara, Jasmine
* Hosting: Heroku
* CI Testing: Codeship

## Contributors
####Team
| Name          |   Github                                   |   LinkedIn                                  |
| :-----------: | :----------------------------------------: | :-----------------------------------------: |
| Grace Yim | [graceekyim](https://github.com/graceekyim) | [LinkedIn](https://www.linkedin.com/in/graceekyim) ||
| Joey Sabani | [axhi](https://github.com/axhi) | [LinkedIn](https://www.linkedin.com/in/joeysabani) ||
| Joey Chamberlin | [jochambo](https://github.com/jochambo) | [LinkedIn](https://www.linkedin.com/in/joeychamberlin) ||
| Rob Schwartz | [robschwartz](https://github.com/robschwartz) | [LinkedIn](https://www.linkedin.com/in/robschwartz10) ||


#### Licenses
The MIT License (MIT)

Copyright (c) [2014] [browsin]

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
