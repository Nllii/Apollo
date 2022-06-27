#TODO: turn this into a script 

do not push just 
	git add .
	git commit -am "some message"



1.echo '.env' >> .gitignore
2.git filter-branch --index-filter "git rm -rf --cached --ignore-unmatch .env" HEAD
3.git push --force


