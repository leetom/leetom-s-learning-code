var util = require('util');
var notesdb = require('./notesdb-sqlite3');

notesdb.connect(function(err){
	if(err) throw err;
});

notesdb.forAll(function(error, row){
	util.log('ROW: ' + util.inspect(row));
}, function(error){
	if(error) throw error;
	util.log('All done');
	notesdb.disconnect(function(err){});
});
