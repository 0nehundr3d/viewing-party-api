# About this Application

Viewing Party is an application that allows users to explore movies and create a Viewing Party Event that invites users and keeps track of a host. Once completed, this application will collect relevant information about movies from an external API, provide CRUD functionality for creating a Viewing Party and restrict its use to only verified users.

## Setup

1. Fork and clone the repo
2. Install gem packages: `bundle install`
3. Setup the database: `rails db:{drop,create,migrate,seed}`

Spend some time familiarizing yourself with the functionality and structure of the application so far.

Run the application and test out some endpoints: `rails s`

| Purpose | URL path | Verb | Required Data | Sample Sucessful Response | Sample Unsuccessful Response |
|---------|----------|------|---------------|---------------------------|------------------------------|
| Top Rated Movies | `/api/v1/movie/top` | GET | `N/A` | `{"data": [{"id": 278,"type": "movie","attributes": {"title": "The Shawshank Redemption","vote_average": 8.707}},{"id": 238,"type": "movie","attributes": { "title": "The Godfather","vote_average": 8.686}}]}` | `N/A`
| Movie Search | `api/v1/movie` | GET | `?search=query` | `{"page":1,"results":[{"adult":false,"backdrop_path":"/icmmSD4vTTDKOq2vvdulafOGw93.jpg","genre_ids":[28,878],"id":603,"original_language":"en","original_title":"TheMatrix","overview":"Setinthe22ndcentury,TheMatrixtellsthestoryofacomputerhackerwhojoinsagroupofundergroundinsurgentsfightingthevastandpowerfulcomputerswhonowruletheearth.","popularity":30.7461,"poster_path":"/dXNAPwY7VrqMAo51EKhhCJfaGb5.jpg","release_date":"1999-03-31","title":"TheMatrix","video":false,"vote_average":8.224,"vote_count":26246}]}` | `N/A`