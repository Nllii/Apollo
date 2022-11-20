from  secret_assistant import notification

# open a text file called "myfile.txt" 
with open("/tmp/is_online.txt", "r") as text_file:
    status_ = text_file.read()
    notification(str(status_)).sendmessage().send_mail()
    text_file.close()




