#TODO: turn this into a script, this script removes the git history, and then runs the script again.

do not push just 
	git add .
	git commit -am "some message"



1.echo '.env' >> .gitignore
2.git filter-branch --index-filter "git rm -rf --cached --ignore-unmatch .env" HEAD
3.git push --force


