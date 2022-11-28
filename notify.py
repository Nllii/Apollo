from  secret_assistant import notification

# open a text file called "myfile.txt" 
dummy_file = open("/tmp/is_online.txt", "r")
status_ = dummy_file.read()
notification(str(status_)).sendmessage().send_mail()
dummy_file.close()




