var host = 'localhost',
    port = '27017',
    database = 'tuan';

exports.getValues = function(pName) {
    return eval(pName);
};