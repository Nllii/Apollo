#!/bin/bash  
# functiontest.sh a sample to call the function in the shell script  
# $ cat test.sh    
#!/bin/bash

ls2() {
        echo "Hello World"
}

ls3() {
        echo "Testing $*"
}

# the next line calls the function passed as the first parameter to the script.
# the remaining script arguments can be passed to this function.

$1 $2 $3 $4 $5 