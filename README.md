# About this Application

Viewing Party is an application that allows users to explore movies and create a Viewing Party Event that invites users and keeps track of a host. Once completed, this application will collect relevant information about movies from an external API, provide CRUD functionality for creating a Viewing Party and restrict its use to only verified users.

## Setup

1. Fork and clone the repo
2. Install gem packages: `bundle install`
3. Setup the database: `rails db:{drop,create,migrate,seed}`

Spend some time familiarizing yourself with the functionality and structure of the application so far.

Run the application and test out some endpoints: `rails s`

| Purpose | URL path | Verb | Required Data |
|---------|----------|------|---------------|
| Top Rated Movies | `/api/v1/movie/top` | GET | `N/A` |
| Movie Search | `/api/v1/movie` | GET | `?search=query` |
| Create a Viewing Party | `/api/v1/users/:user_id/party` | POST | `{"name":name,"start_time": start_time, "end_time": end_time, "movie_id": movie_id, "movie_title": movie_title, "invitees": [user_id, user_id, user_id]}` |
| Add User to Viewing Party | `/api/v1/users/:user_id/party/:party_id` | PATCH | `{invitees_user_id: user_id}` |
| Movie Details | `/api/v2/movie/:movie_id` | GET | `N/A` |
| Retrieve User Profile | `/api/v1/users/:user_id` | GET | `N/A` |