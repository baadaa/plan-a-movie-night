# Plan a Movie Night
iOS app that help organize movie night events by assessing participants' tastes and suggesting the best film to watch together.

<img src="https://basinbald.com/img/portfolio/pamn-auth.gif" width="200" style="display: inline;"> <img src="https://basinbald.com/img/portfolio/pamn-movie-sections.gif" width="200" style="display: inline;"> <img src="https://basinbald.com/img/portfolio/pamn-movie-details.gif" width="200" style="display: inline;"> <img src="https://basinbald.com/img/portfolio/pamn-rsvp.gif" width="200" style="display: inline;">


### Challenge
When organizing a movie night with friends, choosing the film to watch together can be a painful process. The larger the group, the harder to select the perfect movie that _everybody_ would enjoy watching. How do you make it easy to gather friends, pick time and place, and most importantly, select the perfect film to screen?

### Solution
The main idea was to devise an impeccable recommendation engine, which will collect users' preferences and insights on a variety of films and present the perfect selections for a movie night by cross-analyzing participants' taste database. Users can browse a huge list of movies provided through [TheMovieDB API](https://www.themoviedb.org/), and choose to leave quick insights on each film: _1) did you watch this film? 2) would you watch it with your friends? 3) how bad do you want to watch it?_ When it's time for gathering, users can simply create an event by choosing the date and time, connected via Facebook Event, and inviting friends—and the app will take care of the rest by recommending the impeccable film to watch together.

### Execution
A four-people team divided roles per MVC pattern: MODEL, VIEW, and CONTROLLER. While VIEW component is being defined and developed by one member, the other members would separately develop MODEL and CONTROLLER components that handle recommendation engine and other back-end functionality. Once all parts ready, each component would be combined into one functional app.

### Limitation
Three-week sprint resulted in functional front-end shell of the app, but the complete app never got to come to fruition. Although API integration was well on its way with Facebook and TMDb, the core recommendation engine development came to a halt as the responsible team members got pulled into other engagements.
