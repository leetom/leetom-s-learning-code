var util = require('util');
var sqlite3 = require('sqlite3');
sqlite3.verbose();

var db = undefined;
exports.connect = function(callback){
	db = new sqlite3.Database('chap06.sqlite3', 
			sqlite3.OPEN_READWRITE | sqlite3.OPEN_CREATE,
			function(err){
				if(err){
					util.log('Failed on creating database ' + err);
					callback(err);
				}else{
					callback(null);
				}
			});
}

exports.disconnect = function(callback){
	callback(null);
}

exports.setup = function(callback){
	db.run("CREATE TABLE IF NOT EXISTS notes " +
			"(ts DATETIME, author VARCHAR(255), note TEXT)", 
			function(err){
				if(err){
					util.log('Failed on creating table ' + err);
					callback(err);
				}else
					callback(null);
			});
}

exports.emptyNote = { 'ts': '', author: '', note: ''};

exports.add = function(author, note, callback){
	db.run("INSERT INTO notes (ts, author, note) " +
			"VALUES (?, ?, ?);",
			[new Date(), author, note],
			function(error){
				if(error){
					util.log('FAIL TO ADD ' + error);
					callback(error);
				}else
					callback(null);
			});
}

exports.delete = function(ts, callback){
	db.run('DELETE FROM notes WHERE ts = ?;', [ ts ], function(error){
		if(error){
			util.log('Fail to delete ' + error);
			callback(error);
		}else{
			callback(null);
		}
	});
}

exports.edit = function(ts, author, note, callback){
	db.run('UPDATE notes ' +
			'SET ts = ?, author = ?, note = ?' +
			'WHERE ts = ?',
			[ ts, author, note, ts ],
			function(err){
				if(err){
					util.log('Fail on updating table ' + err);
					callback(err);
				}else{
					callback(null);
				}
			});
}

exports.allNotes = function(callback){
	util.log(' in allNotes');
	db.all('SELECT * FROM notes', callback);
};
exports.forAll = function(doEach, done){
	db.each('SELECT	* FROM notes', function(err, row){
		if(err){
			util.log('Fail to retrieve row ' + err);
			done(err, null);
		}else{
			doEach(null, row);
		}
	}, done);
}
