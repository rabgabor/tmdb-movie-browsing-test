# tmdb-movie-browsing-test

| ! The [TMDB  api key] has been removed from the code, and causes `FatalError` if not provided !  |
|--------------------------------------------------------------------------------------------------|

###  Implementation notes and remarks

- I have updated the provided code and added other features too, like cached async images, but I have removed these changes and restored the original UI. I tried to maintain the asked MVVM pattern. I tried not to change the provided View files and provided skeleton, apart from adding pull-to-refresh to the movie list scene.

- I persist the Favorites in UserDefaults. Although the current Favorites architecture is not a perfect solution, it works, and the data remains even when the user reloads the movies/ quits the app.

- I have introduced a manager class that handles the movie service and connects it with the favorites. The movie list view model only subscribes to the changes of the movie view model database in the manager. I have tried multiple approach to optimize the view reload frequency, but this solution changed the original skeleton the least.

- Error handling has no UI implication, it is only printed.

- Although some unit tests are provided, they are not thourough.


**************


###  Introduction


Using the application framework provided for you, **create  a  movie  browsing  application** that displays a list of most popular movies, as well as some basic details about them.


###  Implementation  details


-  Use  the  application  framework  provided  for  you.

-  Write  your  application  using  Swift.

-  Host  your  project  on  GitHub.  Use  git  as  you  see  fit.

-  Use  the  latest  version  of  [TMDB  api](https://developers.themoviedb.org/3/getting-started/introduction)  to  fetch  data  about  movies.  An  API  key  will  be  provided  for  you.

-  Create  a  screen  to  show  a  list  of  trending  movies.  Display  some  additional  info  including  the  movie  poster,  title,  its  genres, rating etc. (UI is provided)

-  Selecting  a  movie  from  the  list,  the  user  should  navigate  to  the  detail  page  of  that  movie,  that  displays  some  additional  info. (UI + navigation provided)

- On the details screen the user can mark the movie and add it to their own list (You don't have to persist this data). This status is also visible on the movie list screen. (shared data/state)

-  Please  note  that  TMDB  uses  unique  genre  IDs  that  need  to  be  resolved  using  a  separate  API  call.  Do  not  hardcode  genres  into  your  application.


###  Notes
-  The  application  framework  that  is  provided  for  you  uses  an  MVVM  approach.  We  advise  to  separate  your  code  into  layers  that  you  see  fit  in  this  architecture.

- Instead of proof of concept style solutions, we would be interested how you would implement the task as a scalable solution

