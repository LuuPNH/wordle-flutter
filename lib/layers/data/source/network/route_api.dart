//This is exam application, so I didn't setup environment, base url, ...
class RouteApi {
  const RouteApi._();
  //This is api to guess word
  static const guessWord = 'https://wordle.votee.dev:8000/word/';

  //This is api to create a word
  static const getWord = 'https://random-word-api.herokuapp.com/word';
}
