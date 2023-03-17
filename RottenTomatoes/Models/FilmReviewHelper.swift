//
//  FilmReviewHelper.swift
//  Rotten Tomatoes
//
//  Created by Sergei Fonov on 27.02.23.
//

import CoreData

#if DEBUG
func createFilmReviewSamples(_ moc: NSManagedObjectContext) {
  let filmReview1 = FilmReview(context: moc)

  filmReview1.dateCreate = Date()
  filmReview1.title = "THE INVITATION"
  filmReview1.director = "Jessica M. Thompson"
  filmReview1.genre = Genres.horror.rawValue
  filmReview1.review = """
  Just don't watch the trailer
  One of the biggest faults of this movie, funny enough, isn't anything to do with the movie itself but the promotions for it. If you have seen the trailer for this movie then you've pretty much seen the entire movie, including the big twist reveal, which sucks as the story has so much potential. In the right capable hands, a story of someone trying to find their long-lost family and then ending up in a horror situation can be pretty good but here, it falls flat. The story takes forever to get going and once it does start to pick up the pace the movie was almost over. I know that horror movies need time to set up the setting and dynamics but this movie just did WAY too much of that. I've heard a lot of people say this and honestly, I agree with them that this story would be better as a RomCom. The two leads, more on them later, have chemistry between the two of them that just gets wasted because of the story of this movie. If it had been a RomCom movie it might've been one I actually enjoyed as it would've been a unique movie. I quickly touched on this earlier but my biggest issue with this movie wasn't the story for this movie, I already figured the trailer spoiled the whole movie, but the pacing of the movie. This movie is a horror thriller movie and the pacing for this movie didn't match that one bit. It had slower pacing to it which can be effective in the right kind of horror movie but definitely not here. I guess the slow pacing of this movie was supposed to help keep the suspense of wondering what's really happening in the manor but like I said the trailer already ruined that mystery so it wasn't effective. Also due to the slow pacing of the movie the ending for this movie gets severely rushed.
  """
  filmReview1.rating = Int16(1)

  let filmReview2 = FilmReview(context: moc)
  filmReview2.dateCreate = Date()
  filmReview2.title = "Me Time"
  filmReview2.director = "John Hamburg"
  filmReview2.genre = Genres.comedy.rawValue
  filmReview2.review = """
  Movie with much potential but failed to deliver
  First of all, I love Mark Wahlberg and Kevin Hart and have watched almost every movie of them. The trailer was quite promising and i expected a comedy, even if it was clear that the genre would not be defined new.
  """
  filmReview2.rating = Int16(4)

  let filmReview3 = FilmReview(context: moc)
  filmReview3.dateCreate = Date()
  filmReview3.title = "Carter"
  filmReview3.director = "Jeong Byeong-gil"
  filmReview3.genre = Genres.action.rawValue
  filmReview3.review = """
  VIDEO GAME CUTSCENES
  THhis is like video game cutscenes that turn into a movie .. Great movie for some peoples , bad movie for those cannot accept this type of movie .. I think this movie is okay ..
  """
  filmReview3.rating = Int16(5)

  let filmReview4 = FilmReview(context: moc)
  filmReview4.dateCreate = Date()
  filmReview4.title = "All Quiet on the Western Front"
  filmReview4.director = "Edward Berger"
  filmReview4.genre = Genres.drama.rawValue
  filmReview4.review = """
  Impressive, yet it doesn't quite hit the mark in every respect
  A fascinating film with potential that was never fully achieved. "All Quiet on the Western Front" does not rely solely on shock value to disturb its audience
  """
  filmReview4.rating = Int16(2)

  let filmReview5 = FilmReview(context: moc)
  filmReview5.dateCreate = Date()
  filmReview5.title = "Jungle Cruise"
  filmReview5.director = "Jaume Collet-Serra"
  filmReview5.genre = Genres.adventure.rawValue
  filmReview5.review = """
  Nice easy to watch adventure movie.
  If you like adventure movies like Indiana Jones, Romancing The Stone, Jewel Of The Nile, Jumanji and others in this genre you can't go wrong with Jungle Cruise. It's the same entertainment, a bit over the top, not always making sense, but that's hardly the point with these kind of movies.
  """
  filmReview5.rating = Int16(3)
}
#endif
