var http = require('http');

http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end('Hello World!');
}).listen(8080);

/*
module.exports.getGitUser = function(callback){
  execute("git config --global user.name", function(name){
      execute("git config --global user.email", function(email){
          callback({ name: name.replace("\n", ""), email: email.replace("\n", "") });
      });
  });
};
*/

