define(['algoliasearch'], function(algoliasearch) {
  'use strict';

  var Search = function() {
    this.applicationID = 'BHPSLYIJ2L';
    this.apiKey = '2679ba91da8ec5014b27f77399b09b57'; // search-only API key
  };

  /**
   * Initialise the component
   */
  Search.prototype.init = function() {
    this.client = algoliasearch(this.applicationID, this.apiKey, {protocol: 'https:'});
    this._addToIndex();
    // this._getResults();
  }

  /**
   * Get search results
   */
  Search.prototype._getResults = function() {
    var index = this.client.initIndex('records');

    index.search('money', {
      hitsPerPage: 10,
      page: 0
    }).then(function searchDone(content) {
      console.log(content)
    }).catch(function searchFailure(err) {
      console.error(err);
    });
  }

  /**
   * Add to an index
   */
  Search.prototype._addToIndex = function() {
    var index = this.client.initIndex('records');
    var recordsJSON = [{"count":439,"resource_url":"https://api.discogs.com/users/davidTrussler/collection/folders/0","id":0,"name":"All"},{"count":3,"resource_url":"https://api.discogs.com/users/davidTrussler/collection/folders/1015286","id":1015286,"name":"Alternative Rock"},{"count":1,"resource_url":"https://api.discogs.com/users/davidTrussler/collection/folders/596866","id":596866,"name":"Avantgarde"},{"count":1,"resource_url":"https://api.discogs.com/users/davidTrussler/collection/folders/1015289","id":1015289,"name":"Documentary"},{"count":47,"resource_url":"https://api.discogs.com/users/davidTrussler/collection/folders/743276","id":743276,"name":"Drum n Bass"},{"count":33,"resource_url":"https://api.discogs.com/users/davidTrussler/collection/folders/538629","id":538629,"name":"Electronic"},{"count":14,"resource_url":"https://api.discogs.com/users/davidTrussler/collection/folders/538635","id":538635,"name":"Folk Rock"},{"count":13,"resource_url":"https://api.discogs.com/users/davidTrussler/collection/folders/538625","id":538625,"name":"Folk, World, & Country"},{"count":17,"resource_url":"https://api.discogs.com/users/davidTrussler/collection/folders/538633","id":538633,"name":"Free Improvisation"},{"count":1,"resource_url":"https://api.discogs.com/users/davidTrussler/collection/folders/700959","id":700959,"name":"Free Jazz"},{"count":1,"resource_url":"https://api.discogs.com/users/davidTrussler/collection/folders/538643","id":538643,"name":"Fusion"},{"count":2,"resource_url":"https://api.discogs.com/users/davidTrussler/collection/folders/703218","id":703218,"name":"Heavy Metal"},{"count":1,"resource_url":"https://api.discogs.com/users/davidTrussler/collection/folders/1205145","id":1205145,"name":"Hip hop"},{"count":7,"resource_url":"https://api.discogs.com/users/davidTrussler/collection/folders/743277","id":743277,"name":"IDM"},{"count":14,"resource_url":"https://api.discogs.com/users/davidTrussler/collection/folders/538645","id":538645,"name":"Indie Rock"},{"count":24,"resource_url":"https://api.discogs.com/users/davidTrussler/collection/folders/538630","id":538630,"name":"Jazz"},{"count":1,"resource_url":"https://api.discogs.com/users/davidTrussler/collection/folders/703165","id":703165,"name":"Jazz Funk"},{"count":1,"resource_url":"https://api.discogs.com/users/davidTrussler/collection/folders/700989","id":700989,"name":"Jazz Rock"},{"count":13,"resource_url":"https://api.discogs.com/users/davidTrussler/collection/folders/538644","id":538644,"name":"Lo-Fi"},{"count":2,"resource_url":"https://api.discogs.com/users/davidTrussler/collection/folders/575924","id":575924,"name":"Noise"},{"count":19,"resource_url":"https://api.discogs.com/users/davidTrussler/collection/folders/538634","id":538634,"name":"Prog Rock"},{"count":1,"resource_url":"https://api.discogs.com/users/davidTrussler/collection/folders/538646","id":538646,"name":"Psychedelic Rock"},{"count":3,"resource_url":"https://api.discogs.com/users/davidTrussler/collection/folders/1081277","id":1081277,"name":"Punk"},{"count":21,"resource_url":"https://api.discogs.com/users/davidTrussler/collection/folders/538642","id":538642,"name":"Rock"},{"count":1,"resource_url":"https://api.discogs.com/users/davidTrussler/collection/folders/703172","id":703172,"name":"Soul"},{"count":1,"resource_url":"https://api.discogs.com/users/davidTrussler/collection/folders/703186","id":703186,"name":"Soundtrack"},{"count":2,"resource_url":"https://api.discogs.com/users/davidTrussler/collection/folders/1081271","id":1081271,"name":"Techno"},{"count":1,"resource_url":"https://api.discogs.com/users/davidTrussler/collection/folders/743279","id":743279,"name":"Trip Hop"},{"count":194,"resource_url":"https://api.discogs.com/users/davidTrussler/collection/folders/1","id":1,"name":"Uncategorized"}];
    var contactsJSON = [
      {objectID: '1', firstname: 'Jimmie', lastname: 'Barninger'},
      {objectID: '2', firstname: 'Warren', lastname: 'Speach'},
      {objectID: '3', firstname: 'David', lastname: 'Trussler'}
    ];

    index.addObjects(recordsJSON, function(err, content) {
      console.log(content);

      if (err) {
        console.error(err);
      }
    });
  }

  return Search;
});
